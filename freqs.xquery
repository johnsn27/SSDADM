<html>
    <body>
    <table>
    <tr>
    <th><i>Target</i></th>
    <th><i>Successor</i></th>
    <th><i>Frequency</i></th>
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
                            
        for $distinct_value in distinct-values($list_of_successors/text())
            let $freqs := count($list_of_successors[text() = $distinct_value])
            let $successor := (($list_of_successors[text() = $distinct_value])[1])
            let $column := tokenize($successor, ',')
            order by $freqs descending
            return 
                <tr>
                    <td>{$column[1]}</td>
                    <td>{$column[2]}</td>
                    <td>{$freqs}</td>
                </tr>
     }
     
    </table>
    </body>
 </html>
