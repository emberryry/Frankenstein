
declare option saxon:output "method=html";
declare variable $project := collection("../xml/?.select=*.xml");
declare variable $frank := doc("../xml/Frankenstein_MarkUp.xml");
declare variable $linefeed := "&#10;";
declare variable $tab :="&#x9;";

<html>
  <body> 
    <table>
    <tr>
       <th>Chapter</th>
       <th>Paragraphs</th>
       </tr>
        {
            let $chapters := //body//ch
            
            for $chapter in $chapters
                let $chapNumber := $chapter/data(@n)
                let $paragraphs := $chapter//p
                let $para_count := $paragraphs=>count()
            
            order by $para_count
            
            return (<tr><td>{$chapNumber}</td><td>{$para_count}</td></tr>)
        }
    </table>
    </body>
</html>