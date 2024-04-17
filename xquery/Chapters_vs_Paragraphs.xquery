declare option saxon:output "method=html";

<html>
  <body>
        <table>
                <tr>
                    <th>Chapter</th>
                    <th>Paragraphs</th>
                </tr>
            {
                let $chapters := //body//ch
                (: Is retrieving all the <ch> elements inside of the <body> elements and bindds them to the variable $chapters :)
                for $chapter in $chapters
                (: Creates a for loop :)
                    let $chapNumber := $chapter/data(@n)
                    (: This  extracts the value of the n attribute from the current $chapter element and binds it to the variable $chapNumber. :)
                    let $paragraphs := $chapter//p
                    (: Retrieves all <p> elements inside the $chapter elements :)
                    let $para_count := $paragraphs=>count()
                    (: This calculates the count of paragraphs stored in the variable $paragraphs and binds the result to the variable $para_count. :)
                
                order by $para_count
                (: This is ordering the table by the number of paragraphs in each chapter :)
                
                return (<tr><td>{$chapNumber}</td><td>{$para_count}</td></tr>)
                (: Returning the data being gether into the table format :)
            }
        </table>
    </body>
</html>