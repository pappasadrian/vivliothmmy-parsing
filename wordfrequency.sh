#!/bin/bash

cd docs
mkdir text

#for each pdf file
for f in *.pdf
do
	#export pdf as text and save results to csv
	#spaces thingy fixes awkward space bug
	noending=`echo $f | cut -d '.' -f1`
    pdftotext $f - | tr ' ' ' ' > text/$noending.txt
done

cd text
mkdir tallies

for f in *.txt
do
	noending=`echo $f | cut -d '.' -f1`
	#cleanup unnecessary characters
	#make sure that each word is in a new line
	#remove words which contain numbers
	#remove words with less than 3 characters
	#sort everything
	cat $f | tr '"' '\n' | tr ' ' '\n' | tr '\r' '\n' | tr '\t' '\n' |tr '/' '\n' | tr '-' '\n' | tr ':' '\n' | awk '!/[0-9]/' | sed '/^\s*$/d' | sed s/"\,"//g | sed s/"\."//g | sed s/")"//g | sed s/"("//g | sed s/"\[.*\]"//g | awk "length>2" | sort | uniq -c -i | awk '{print $2","$1}' | sort -nr --field-separator=',' --key=2 > $noending.csv

done

mv *.csv tallies/

for f in *.txt
do
    #get words from all files into a single new file for a total tally
    cat $f >> grandtotal
done

#same as above
cat grandtotal| tr '"' '\n' | tr ' ' '\n' | tr '\r' '\n' | tr '\t' '\n' |tr '/' '\n' | tr '-' '\n' | tr ':' '\n' | awk '!/[0-9]/' | sed '/^\s*$/d' | sed s/"\,"//g | sed s/"\."//g | sed s/")"//g | sed s/"("//g | sed s/"\[.*\]"//g | awk "length>2" | sort | uniq -c -i | awk '{print $2","$1}' | sort -nr --field-separator=',' --key=2 > grandtotal.csv

mv *.csv tallies/
