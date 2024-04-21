(: Generates Chapters_Vs_Paragraphs.html :)

declare option saxon:output "method=html";

declare variable $chapters := //Q{}body//Q{}ch;
declare variable $xspacer := 10;
declare variable $yspacer := 25;

<html>
    <head>
        <title>Number of Paragraphs per Chapter</title>
        <link type="text/css" href="Frankenstein.css" rel="stylesheet" />
        <link type="text/css" href="dropdownMenu.css" rel="stylesheet" />
    </head>
    <body>
    <img src="border.png" alt="border" class="border"/>
        <h1>Frankenstein</h1>
        
        <nav>
            <div class="dropdown">
                <a href="#">Graphs</a>
                <div class="dropdown-content">
                    <!-- Dropdown options -->
                    <a href="speechcount.html">Speaker Frequencies</a>
                    <a href="#">Paragraphs per Chapter</a>
                    <a href="#">Network Graph</a>
                </div>
            </div>
            <div><a href="#about-content">About</a></div>
            <div><a href="#team-content">Team</a></div>
        </nav>
        
            <h2>Graphs</h2>
        <svg xmlns="http://www.w3.org/2000/svg" width="1100" height="1000" viewBox="0 0 1100 1000">
            <g transform="translate(150,100)">
                <g>
                    <text x="0" y="-5" font-family="sans-serif" font-size="20px" fill="black" style="text-decoration: underline;">Number of Paragraphs Per Chapter</text>
                </g>
                <g>
                    <!-- Y-Axis Line -->
                    <line x1="0" y1="0" x2="0" y2="{count($chapters) * $yspacer + 15}" stroke="black" stroke-width="2"/>
                    
                    <!-- X-Axis Label -->
                    <text x="400" y="{count($chapters) * $yspacer + 30}" font-family="sans-serif" font-size="12px" fill="black">Number of Paragraphs</text>
                    
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
                                <text x="-35" y="{$pos * $yspacer + 5}" font-family="sans-serif" font-size="12px" fill="black">{$chapNumber}</text>
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


