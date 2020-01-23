echo '############'
echo PAML_annalysis
echo '############'

for dir in Tree*;do (cd $dir/modelA/Omega1 && ./codeml codeml_modelA_masked.ctl && /
cd .. && cd .. && /
cd modelAnull/Omega1 && ./codeml codeml_modelAnull_masked.ctl);done
