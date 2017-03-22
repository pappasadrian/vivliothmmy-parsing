#!/bin/bash

cd docs

#for each pdf file
for f in *.pdf
do
	#pdfinfo is a great utility that shows basic info about 
	#get the line with the pagecount from the output, and save everything on a csv file
    pdfinfo $f | grep "Pages" -a | sed s/"^.* "/""/g | sed s/"^"/"$f,"/ >> pagecount.csv

done

mv pageoutput.csv ../
