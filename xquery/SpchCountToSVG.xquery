(:generates speechcount.html :)

declare option saxon:output "method=html";

declare variable $quote := doc('../xml/Frankenstein_MarkUp.xml')//q;
declare variable $speakers := $quote//data(@speaker) => distinct-values();
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
        
    <h1>Speaker Frequencies in Frankenstein</h1>
    <p>This graph shows the amount of times each person is quoted in the story Victor has the most quotes since he is the narrator for most of the story followed by the Monster who is the 2nd most quoted person</p>
    <svg xmlns="http://www.w3.org/2000/svg" width="1100" height="1000" viewBox="0 0 1100 1000">
        <g transform="translate(170,100)">
        
            <line x1="0" y1="0" x2="0" y2="{count($speakers) * $yspacer + 15}" stroke="black" stroke-width="2"/>
            
            <text x="-160" y="{count($chapters) * $yspacer + -355}" font-family="sans-serif" font-size="16px" fill="black">Speakers</text>

            
            <line x1="0" y1="{count($chapters) * $yspacer + -135}" x2="{max($chapters//Q{}p=>count()) * $xspacer + 15}" y2="{count($chapters) * $yspacer + -130}" stroke="black" stroke-width="2"/>
            
            <text x="400" y="{count($chapters) * $yspacer + -90}" font-family="sans-serif" font-size="16px" fill="black">Total Number of Quotes</text>

            {
                let $max_x := max($chapters//Q{}p=>count())
                        for $i in 0 to $max_x
                        where $i mod 5 = 0
                        return
                            <g>
                                <line x1="{$i * $xspacer}" y1="{count($chapters) * $yspacer + -130}" x2="{$i * $xspacer}" y2="{count($chapters) * $yspacer + -140}" stroke="black" stroke-width="2"/>
                                <text x="{$i * $xspacer}" y="{count($chapters) * $yspacer + -115}" font-family="sans-serif" font-size="12px" fill="black" text-anchor="middle">{$i}</text>
                            </g>
            }
            
            {
                for $spkr at $pos in $speakers
                let $spkr-speech-count := $quote[data(@speaker) = $spkr] => count()
                return
                    <g>
                        <text x="-75" y="{$pos * $yspacer + 5}" font-family="sans-serif" font-size="12px" fill="black">{$spkr}</text>
                        <line x1="0" y1="{$pos * $yspacer}" x2="{$spkr-speech-count * $xspacer}" y2="{$pos * $yspacer}" stroke="purple" stroke-width="15"/>
                        <text x="{$spkr-speech-count * $xspacer + 10}" y="{$pos * $yspacer + 5}" font-family="sans-serif" font-size="12px" fill="black">{$spkr-speech-count}</text>
                    </g>
            }
        </g>
    </svg>
    </body>
</html>