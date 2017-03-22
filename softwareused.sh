#!/bin/bash

cd docs

#for each pdf file
for f in *.pdf
do
	#pdfinfo is a great utility that shows basic info about PDF files
	#get the line with creator/editor software, and save everything on a csv file
    pdfinfo $f | grep "Creator:" -a | sed s/"^Creator:[ ]* "/""/g | sed s/"^"/"$f,"/ >> softwareused.csv

done

mv softwareused.csv ../
cd ..

#count the number of usages of each software type
#save result in a csv file
cat softwareused.csv | cut -d ',' -f2 | tr ',' '\n'| sort | uniq -c | sort -nr |tail -n +2 | sed 's/ \+/ /g' | sed s/" "/""/ | sed s/" "/"\,"/ > softwareoccurence.csv
