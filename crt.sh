#!/bin/sh

query="SELECT ci.NAME_VALUE NAME_VALUE FROM certificate_identity ci WHERE ci.NAME_TYPE = 'dNSName' AND reverse(lower(ci.NAME_VALUE)) LIKE reverse(lower('%.$1'));"

(echo $1; echo $query | \
    psql -t -h crt.sh -p 5432 -U guest certwatch | \
    sed -e 's:^ *::g' -e 's:^*\.::g' -e '/^$/d' | \
    sed -e 's:*.::g';) | sort -u
                                    
