#!/bin/bash

cd docs

#for each pdf file
for f in *.pdf
do
	#export pdf as text and save results to csv
	#spaces thingy fixes awkward space bug
	pdftotext $f - | tr ' ' ' ' |  wc -w | sed s/"^"/"$f,"/ >> wordcount.csvdone
done

mv wordcount.csv ../
