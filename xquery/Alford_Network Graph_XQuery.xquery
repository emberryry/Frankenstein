declare option saxon:output "method=html";
declare variable $project := collection("../xml/?.select=*.xml");
declare variable $frank := doc("../xml/Frankenstein_MarkUp.xml");
declare variable $linefeed := "&#10;";
declare variable $tab :="&#x9;";
declare variable $quote := doc('../xml/Frankenstein_MarkUp.xml')//q;
declare variable $speaker := $quote//data(@speaker)=>distinct-values();

concat("Label, Entity, Frequency", $linefeed, string-join(

let $speakers := //q[./data(@speaker)]/data(@speaker)
for $speaker in $speakers => distinct-values()
    let $frequency := count(//q[./data(@speaker)=$speaker])
    

return concat($speaker, ",Speaker,", $frequency,$linefeed)))