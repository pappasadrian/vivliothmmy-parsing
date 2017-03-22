# vivliothmmy-parsing
THMMY AUTh Undergraduate Thesis Repository Parsing and Data Analytics (vivliothmmy2.ee.auth.gr)

Several hundreds of Theses are uploaded and publicly available on the Department of Electrical and Computer Engineering of the Aristotle University of Thessaloniki's Thesis Repository. However, the web interface is very basic and offers little to no functionality.

By parsing and looking into the data, much more info can be extracted.

This probably only works on linux.

## download.sh

This script does the initial grab of the whole database of theses. It will save all theses (PDFs) in a new "docs" subfolder, and will create a CSV file with all available data for each thesis from the webpage.

## pagecount.sh

This will go through the downloaded PDFs and extract a pagecount for each one, saving the result in a new CSV file.

Uses the pdfinfo linux utility.

## fontanalysis.sh

Get a statistical font usage analysis. See what fonts are mostly used in Thesis writing (results will not surprise you)
