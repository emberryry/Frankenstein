
declare option saxon:output "method=text";
declare variable $project := collection("../xml/?.select=*.xml");
declare variable $frank := doc("../xml/Frankenstein_MarkUp.xml");
declare variable $linefeed := "&#10;";
declare variable $tab :="&#x9;";

<html>
  <body> <p>There is a probable connection between the narrator of each chapter and how many times they speak, this table will show how many paragraphs and line characters there is for each chapter.</p> 
    <table>
    <tr>
    <th>Chapter</th>
    <th>Paragraphs</th>
    <th>Line Characters</th></tr>
{
(:declare variable $project := collection("../xml/?.select=*.xml");:)
(:declare variable $frank := doc("../xml/Frankenstein_MarkUp.xml");:)
(:declare variable $linefeed := "&#10;";:)
(:declare variable $tab :="&#x9;";:)



let $chapters := //body//ch
(:return $chapter:)
(: Made ch into a variable:)
for $chapter in $chapters
    let $chapNumber := $chapter/data(@n)
            (:let $chap_count := $chapters=>count():)  (:return $chapter-count:) (:Made it so that chapters could be counted:)  (:let $letter := //letter:)
    let $paragraphs := $chapter//p
            (:made letters and paragraphs into variable:)  (:return $paragraph => count():)
    let $para_count := $paragraphs=>count()
    let $chapLength := $chapter!normalize-space()!string-length()

order by $para_count, $chapLength

(:return concat("Chapter ", $chapNumber, " contains ", $para_count , 
" paragraphs, and is ", $chapLength, " characters long.", $linefeed):)

return concat($chapNumber, $tab, $para_count, $tab, $chapLength, $linefeed)

(:return $para_count div $chap_count:)
(:Found the average of how many pargarpagh there are per chapter:)
}</table>
</body>
</html>