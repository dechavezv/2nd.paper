echo '############'
echo Make_dir_for_PAML
echo '############'
for file in *.fasta; do (mkdir Dir_$file && mv $file Dir_$file && /
cp -r tree Dir_$file && /
cd Dir_$file && cp $file tree/modelA/Omega1 && /
cd tree/modelA/Omega1 && mv *.fasta align.phy);done
