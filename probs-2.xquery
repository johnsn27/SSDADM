<html>
    <body>
    <table>
    <tr>
    <th>Target</th>
    <th>Successor</th>
    <th>Probability</th>
    </tr>
    {
        let $list_of_successors := for $s in collection('xml_files?select=*.xml')//s
            return 
                for $w in $s/w
                    return
                        if(lower-case(normalize-space($w/text())) eq 'has')
                            then 
                                let $successor := (data($s/w[.>> $w][1]))
                                return 
                                    <list> { (lower-case(normalize-space($w/text()))) } {','} {(lower-case(normalize-space($successor))) }</list>
                            else()
                            
        let $words := for $s in collection('xml_files?select=*.xml')//s
            return
                for $w in $s/w
                    return <word>{ (lower-case(normalize-space($w/text()))) }</word>
               
        for $distinct-value in distinct-values($list_of_successors/text())
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
     }
     
    </table>
    </body>
 </html>
