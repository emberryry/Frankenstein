(: Generates Chapters_Vs_Paragraphs.html :)

declare option saxon:output "method=html";
declare option saxon:output "doctype-system=about:legacy-compat";

declare variable $chapters := //Q{}body//Q{}ch;
declare variable $xspacer := 10;
declare variable $yspacer := 25;



<html>
<head>
    <title>Speaker Frequencies in Frankenstein</title>
    <link type="text/css" href="Frankenstein.css" rel="stylesheet" />
    <link type="text/css" href="dropdownMenu.css" rel="stylesheet" />
</head>
<body>
    <img src="border.png" alt="border" class="border"/>
    <a href="index.html">
        <h1>Frankenstein</h1>
    </a>
    
        <nav>
            <div class="dropdown">
                <a href="#">Graphs</a>
                <div class="dropdown-content">
                    <a href="speechcount.html">Speaker Frequencies</a>
                    <a href="Chapters_vs_Paragraphs.html">Paragraphs Per Chapter</a>
                    <a href="Network_Graph.html">Network Graph</a>
                </div>
            </div>
             <div><a href="aboutTab.html">About</a></div>
            <div><a href="teamTab.html">Team Info</a></div>
        </nav>
    <h1>Paragraphs per Chapter</h1>
    <p>This graph shows the amount of paragraphs each chapter has in the book Frankenstein. This was As shown, the last chapter, chapter 24, has the most paragraphs by far in the book which is almost three times as many paragraphs as the chapter with the least.</p>
    <svg xmlns="http://www.w3.org/2000/svg" width="1100" height="1000" viewBox="0 0 1100 1000">
        <g transform="translate(150,100)">
        
                <g>
                    <text x="0" y="-15" font-family="sans-serif" font-size="30px" fill="black" style="text-decoration: underline;">Number of Paragraphs Per Chapter</text>
                </g>
                <g>
                    <!-- Y-Axis Line -->
                    <line x1="0" y1="0" x2="0" y2="{count($chapters) * $yspacer + 15}" stroke="black" stroke-width="2"/>
                    
                    <!-- Y-Axis Label -->
                    <text x="-125" y="{count($chapters) * $yspacer + -295}" font-family="sans-serif" font-size="16px" fill="black">Chapters</text>
                    
                    <!-- X-Axis Label -->
                    <text x="400" y="{count($chapters) * $yspacer + 60}" font-family="sans-serif" font-size="16px" fill="black">Number of Paragraphs</text>
                    
                    <!-- X-Axis Line -->
                    <line x1="0" y1="{count($chapters) * $yspacer + 15}" x2="{max($chapters//Q{}p=>count()) * $xspacer + 10}" y2="{count($chapters) * $yspacer + 15}" stroke="black" stroke-width="2"/>
            
                    <!-- Number Line -->
                    {
                        let $max_x := max($chapters//Q{}p=>count())
                        for $i in 0 to $max_x
                        where $i mod 5 = 0
                        return
                            <g>
                                <line x1="{$i * $xspacer}" y1="{count($chapters) * $yspacer + 10}" x2="{$i * $xspacer}" y2="{count($chapters) * $yspacer + 20}" stroke="black" stroke-width="2"/>
                                <text x="{$i * $xspacer}" y="{count($chapters) * $yspacer + 35}" font-family="sans-serif" font-size="12px" fill="black" text-anchor="middle">{$i}</text>
                            </g>
                    }
                    
                    <!-- Number Line -->
                    <line x1="0" y1="{count($chapters) * $yspacer + 15}" x2="{max($chapters//Q{}p=>count()) * $xspacer + 10}" y2="{count($chapters) * $yspacer + 15}" stroke="black" stroke-width="2"/>
                    {
                        for $chapter at $pos in $chapters
                        let $chapNumber := $chapter/data(@n)
                        let $paragraphs := $chapter//Q{}p
                        let $para_count := $paragraphs=>count()
                        
                        order by $para_count
                        
                        return
                            <g>
                                <text x="-35" y="{$pos * $yspacer + 5}" font-family="sans-serif" font-size="15px" fill="black">{$chapNumber}</text>
                                <line x1="0" y1="{$pos * $yspacer}" x2="{$para_count * $xspacer}" y2="{$pos * $yspacer}" stroke="purple" stroke-width="15"/>
                                <text x="{$para_count * $xspacer + 10}" y="{$pos * $yspacer + 5}" font-family="sans-serif" font-size="12px" fill="black">{$para_count}</text>
                                <line x1="0" y1="0" x2="0" y2="{count($chapters) * $yspacer}" stroke="black" stroke-width="2"/>
                            </g>
                    }
                </g>
            </g>
        </svg>
    </body>
</html>