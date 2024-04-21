(:generates speechcount.html :)

declare option saxon:output "method=html";

declare variable $quote := doc('../xml/Frankenstein_MarkUp.xml')//q;
declare variable $speakers := $quote//data(@speaker) => distinct-values();
declare variable $chapters := //Q{}body//Q{}ch;
declare variable $xspacer := 10;
declare variable $yspacer := 25;
<html>
    <head>
        <title>Frankenstein Speech Count</title>
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
        <p>This graph shows the amount of times each person is quoted in the story Victor has the most quotes since he is the narrator for most of the story followed by the Monster who is the 2nd most quoted person</p>
        <svg xmlns="http://www.w3.org/2000/svg" width="1100" height="1000" viewBox="0 0 1100 1000">
            <g transform="translate(150,100)">
            <g>
            <text x="10" y="-15" font-family="sans-serif" font-size="30px" fill="black" style="text-decoration: underline;">Speaker Frequencies in Frankenstein</text>
            </g>
            <g>
                {
                    for $spkr at $pos in $speakers
                    let $spkr-speech-count := $quote[data(@speaker) = $spkr] => count()
                        (:where $spkr-speech-count > 1 This has been eliminated:)
                        (:order by $spkr-speech-count descending  This isn't working :)
                    return
                        <g>
                        <text x="-75" y="{$pos * $yspacer + 5}" font-family="sans-serif" font-size="12px" fill="black">{$spkr}</text>
                        <line x1="0" y1="{$pos * $yspacer}" x2="{$spkr-speech-count * $xspacer}" y2="{$pos * $yspacer}" stroke="purple" stroke-width="15"/>
                        <text x="{$spkr-speech-count * $xspacer + 10}" y="{$pos * $yspacer + 5}" font-family="sans-serif" font-size="12px" fill="black">{$spkr-speech-count}</text>
                        <line x1="0" y1="0" x2="0" y2="{max($pos +1) * $yspacer}" stroke="black" stroke-width="2"/>
                        </g>
                }

                </g>
                </g>
            </svg>
            
            <svg xmlns="http://www.w3.org/2000/svg" width="1100" height="1000" viewBox="0 0 1100 1000">
                <g transform="translate(150,100)">
                    <g>
                        <text x="10" y="-15" font-family="sans-serif" font-size="30px" fill="black" style="text-decoration: underline;">Number of Paragraphs Per Chapter</text>
                    </g>
                    <g>
                        <!-- Y-Axis Line -->
                        <line x1="0" y1="0" x2="0" y2="{count($chapters) * $yspacer + 15}" stroke="black" stroke-width="2"/>
                                
                        <!-- X-Axis Label -->
                        <text x="400" y="{count($chapters) * $yspacer + 40}" font-family="sans-serif" font-size="15px" fill="black">Number of Paragraphs</text>
                        
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