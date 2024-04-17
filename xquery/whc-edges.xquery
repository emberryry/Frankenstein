declare option saxon:output "method=text";
declare variable $frank := doc("../xml/Frankenstein_MarkUp.xml");
declare variable $linefeed := "&#10;";
declare variable $narrators := $frank//narrator/data(@name)=>distinct-values();
(:declare variable $quotes := doc('../xml/Frankenstein_MarkUp.xml')//q;
declare variable $speakers := $quotes//data(@speaker)=>distinct-values();:)
concat("From, To, Relation", $linefeed, string-join(
for $narrator in $narrators
    let $speakers := $frank//narrator[data(@name)=$narrator]
    //q/data(@speaker)=>distinct-values()
    for $speaker in $speakers
        let $speech-count :=$frank//narrator[data(@name)=$narrator]
            //q[data(@speaker)=$speaker]=>count()
           
           return concat($narrator, "_Narrator,", $speaker,",",$speech-count, $linefeed)
        ))