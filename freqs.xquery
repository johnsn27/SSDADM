<html>
    <body>
    <table>
    <tr>
    <th>Target</th>
    <th>Successor</th>
    <th>Frequency</th>
    <th></th>
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
