<html>
    <body>
    <table>
    <tr>
    <th><i>Target</i></th>
    <th><i>Successor</i></th>
    <th><i>Probability</i></th>
    </tr>
    {
        let $list_of_successors := for $s in collection('xml_files?select=*.xml')//s
            return 
               for $w in $s/w
                    let $has-occurence := (lower-case(normalize-space($w/text())) eq 'has')
                    return
                        if($has-occurence)
                            then 
                                let $normalised-word := (lower-case(normalize-space($w/text())))
                                let $successor := (data($s/w[.>> $w][1]))
                                let $normalised-successor := (lower-case(normalize-space($successor)))
                                return 
                                    <list>{ $normalised-word } {','} { $normalised-successor }</list>
                            else()
                            
        let $words := for $s in collection('xml_files?select=*.xml')//s
            return
                for $w in $s/w
                    return <word>{ (lower-case(normalize-space($w/text()))) }</word>
               
        let $probability := for $distinct-value in distinct-values($list_of_successors/text())
            let $freqs := count($list_of_successors[text() = $distinct-value])
            let $successor := (($list_of_successors[text() = $distinct-value])[1])
            let $column := tokenize($successor, ',')
            let $total_words := count($words[text()=$column[2]])
            let $probability := $freqs div $total_words
            order by $probability descending, $column[2] ascending
            return 
                <tr>
                    <td>{$column[1]}</td>
                    <td>{$column[2]}</td>
                    <td>{$probability}</td>
                </tr>
            return
                let $sub-items := subsequence($probability, 1, 20)
                for $item in $sub-items
                    return $item
     }
     
    </table>
    </body>
 </html>
