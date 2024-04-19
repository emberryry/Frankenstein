declare option saxon:output "method=html";

declare variable $chapters := //Q{}body//Q{}ch;
declare variable $xspacer := 10;
declare variable $yspacer := 25;
<html>
    <head><title>Number of Paragraphs per Chapter</title></head>
    <body>
        <svg xmlns="http://www.w3.org/2000/svg" width="1100" height="1000" viewBox="0 0 1100 1000">
            <g transform="translate(150,100)">
            <g>
            <text x="0" y="-5" font-family="sans-serif" font-size="20px" fill="black">Number of Paragraphs Per Chapter</text>
            </g>
            <g>
                {
                    for $chapter at $pos in $chapters
                        let $chapNumber := $chapter/data(@n)
                        let $paragraphs := $chapter//Q{}p
                        let $para_count := $paragraphs=>count()
                    
                    order by $para_count
                    
                    return
                        <g>
                        <text x="-75" y="{$pos * $yspacer + 5}" font-family="sans-serif" font-size="12px" fill="black">{$chapter}</text>
                        <line x1="0" y1="{$pos * $yspacer}" x2="{$para_count * $xspacer}" y2="{$pos * $yspacer}" stroke="purple" stroke-width="15"/>
                        <text x="{$para_count * $xspacer + 10}" y="{$pos * $yspacer + 5}" font-family="sans-serif" font-size="12px" fill="black">{$chapters}</text>
                        <line x1="0" y1="0" x2="0" y2="{max($pos +1) * $yspacer}" stroke="black" stroke-width="2"/>
                        </g>
                    }
            </g>
            </g>
        </svg>
    </body>
</html>