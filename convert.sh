#convert first page pdf to png
#!/bin/bash
rm -rf *png
ls *.pdf > oldValues
rm -rf cover/
rm -rf *.txt
#conpert file to png , ngapus semua semua yang spesial char. mampus pokoknya,daripada ada spesial karakter marai error dan mumet.
cat oldValues | tr -d '[:punct:]' | sed 's/pdf/.pdf/g' > newValues
paste -d'#' oldValues newValues > oldAndNew
while IFS='#'; read oldValue newValue
do
  mv $oldValue $newValue #rename pdf file
    #conpert pdfline1 ke jpg#
   pdftoppm -f 1 -l 1 $newValue $newValue -png #convert pdf to png
   pagesc=$(pdfinfo $oldValue | awk '/^Pages:/ {print $2}')
   echo $pagesc >> pagesc.txt
   echo "convert png file" $newValue

done < oldAndNew


#rename png
ls *.png > pnglama
cat pnglama | tr -d '[:punct:]' | sed 's/pdf001png/.png/g' | sed 's/pdf1png/.png/g' | sed 's/pdf01png/.png/g' > pngbaru
paste -d'#' pnglama pngbaru > pnglamabaru
while IFS='#'; read pnglama pngbaru 
do
    mv $pnglama $pngbaru 
    echo "rename pngfile" $pngbaru
 done < pnglamabaru

paste -d'#' oldValues newValues pagesc.txt pngbaru > listfile.txt

rm -rf newValues oldAndNew pnglama pngbaru pnglamabaru
mkdir cover
mv *png cover/
