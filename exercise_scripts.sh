#!/bin/bash
no_of_people=$(awk 'BEGIN {
	FS="\t";
	}; 
{
	if(NF==7) {
		empty_fields = 0; for(i=0;i<=NF;i++) {
			if($i=="") {
				empty_fields=1;break }
			} if(!empty_fields) print $0}
	}
' "$1"| wc -l;)
no_over_30=$(awk 'BEGIN {
        FS="\t";
        };
{
         if($6 != "" && ($6 < 1993 || ($6 <1994 && $5<10))) print $0
        }
' "$1" | wc -l;)

number_of_jans=$(cut -d$'\t' -f1,1 "$1" | grep -wc "Jan")
number_of_jans=$(awk 'BEGIN{FS="\t"}{if($7 && tolower($1) == "jan") print $0}' "$1" | wc -l;)

most_popular_country=$(awk 'BEGIN{FS="\t"}{if($7 != "") print $7}' "$1" | sort | uniq -c | sort -nr | head -n1 | rev | cut -d ' ' -f1 | rev)

number_of_50_up_in_popular_country=$(awk 'BEGIN{FS="\t"}{if(NF==7 && ($6<1973 ||($6<1974 && $5<10)) && $7 == $most_popular_country) print $0}' "$1" | wc -l)

echo "Number of people is $no_of_people"
echo "Number over 30 is  $no_over_30"
echo "Number of Jans is  $number_of_jans"
echo "Number of people over 50 in most popular country is $number_of_50_up_in_popular_country"


