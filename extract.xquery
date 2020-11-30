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
                    return
                        if(lower-case(normalize-space($w/text())) eq 'has')
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
