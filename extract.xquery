<html>
    <body>
    <table>
    <tr>
    <th><i>Target</i></th>
    <th><i>Successor</i></th>
    </tr>
    {
        for $s in collection('xml_files?select=*.xml')//s
            return 
                for $w in $s/w
                    let $has-occurence := (lower-case(normalize-space($w/text())) eq 'has')
                    return
                        if($has-occurence)
                            then 
                                let $successor := (data($s/w[.>> $w][1]))
                                return 
                                 <tr>
                                     <td>{data($w)}</td>
                                     <td>{$successor}</td>
                                 </tr>
                        else()
     }
    </table>
    </body>
 </html>
