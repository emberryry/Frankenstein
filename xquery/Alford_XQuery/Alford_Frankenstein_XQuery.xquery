declare variable $project := collection("../XML/?.select=*.xml");
declare variable $frank := doc("../XML/Frankenstein_MarkUp.xml");
(: This should be accessing the mark up:)

let $chapter := //ch
(:return $chapter:)
(: Made ch into a variable:)

let $chap_count := $chapter=>count()
(:return $chapter-count:)
(:Made it so that chapters could be counted:)

let $letter := //letter
let $paragraph := //p
(:made letters and paragraphs into variable:)

(:return $paragraph => count():)

let $para_count := $paragraph=>count()

return $para_count div $chap_count
(:Found the average of how many pargarpagh there are per chapter:)
