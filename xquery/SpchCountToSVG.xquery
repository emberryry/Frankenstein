(:generates speechcount.html :)

declare option saxon:output "method=html";

declare variable $quote := doc('../xml/Frankenstein_MarkUp.xml')//q;
declare variable $speakers := $quote//data(@speaker) => distinct-values();
declare variable $xspacer := 10;
declare variable $yspacer := 25;
<html>
    <head>
        <title>Frankenstein Speech Count</title>
        <link type="text/css" href="Frankenstein.css" rel="stylesheet" />
    </head>
    <body>
    <img src="border.png" alt="border" class="border"/>
        <h1>Frankenstein</h1>
        
        <nav>
                <div><a href="speechcount.html">Graphs</a></div>
                <div><a href="#about-content">About</a></div>
                <div><a href="#team-content">Team</a></div>
        </nav>
            
        <h2>Graphs</h2>
        <svg xmlns="http://www.w3.org/2000/svg" width="1100" height="1000" viewBox="0 0 1100 1000">
            <g transform="translate(150,100)">
            <g>
            <text x="0" y="-5" font-family="sans-serif" font-size="20px" fill="black">Speaker Frequencies in Frankenstein</text>
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
    </body>
</html>