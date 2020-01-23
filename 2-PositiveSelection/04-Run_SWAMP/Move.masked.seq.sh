echo '#######################'
echo Move_Files
echo '######################'

for dir in Tree*; do (echo $dir && cd $dir/modelA/Omega1 && pwd && /
cp align_masked.phy $dir.phy && /
mv $dir.phy /u/flashscratch/d/dechavez/PAML/PAML/PAML_out/SWAMP_sequneces_10in5_AND_3in5);done
