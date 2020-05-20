#! /bin/bash

#$ -l highp,h_rt=22:00:00,h_data=10G
#$ -N FastStructure
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/FASTSTRUCTURE/log/FastqQC
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/FASTSTRUCTURE/log/FastqQC
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load python

### This can be run in the shell on an interactive node:
# 

################# installing fastStructure: #############

# git clone https://github.com/rajanil/fastStructure
#cd fastStructure/vars
#python setup.py build_ext --inplace
#cd ..
#python setup.py build_ext --inplace
#test:
#python structure.py # works!
# !!!! you need to add the following two lines to the distruct.py script so that it works without X11 forwarding (https://github.com/rajanil/fastStructure/issues/36)
# import matplotlib as mpl
# mpl.use('svg')
# !!!! these must be added PRIOR to setting: import matplotlib.pyplot as plot

################# running fastStructure: #############
calldate=20200517 # date you called genotypes
# program dir: (downloaded 20180726)
fastDir=/u/home/d/dechavez/project-rwayne/fastStructure
#kvals="1 2 3 4 5 6 7 8 9 10"
kvals="1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17" # set this to whatever numbers you want 
#kvals=10
indir=/u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/${calldate}_filtered/plinkFormat # eventually going to be filtered SNP vcf (no monomorphic sites)
infilePREFIX=LS_joint_allchr_Annot_Mask_Filter_passingSNPs.vcf
# old infile prefix 20180724: snp_5_passingAllFilters_postMerge_raw_variants # the prefix of the .bed file
outdir=/u/home/d/dechavez/project-rwayne/rails.project/FASTSTRUCTURE/${calldate}_filtered

# manually added pop levels (step 1b); they should be a column in exact order of samples (gotten order from .fam file) 
pops=$indir/${infilePREFIX}.pops # file list of population assignments (single column) in same order as your sample input *careful here* get order from .fam or .nosex files
# if this is empty, you forgot to do manual assignment 
# copy sample info to dir for download to laptop:
cp $indir/${infilePREFIX}.samples $outdir
cp $indir/${infilePREFIX}.manual.popAssignment $outdir
cp $indir/${infilePREFIX}.pops $outdir

 # eventually going to be FASTSTRUCTURE dir
plotdir=$outdir/plots
mkdir -p $outdir
mkdir -p $plotdir
# want to iterate over several values of K: 
for k in $kvals
do
echo "carrying out faststructure analysis with K = $k "
python $fastDir/structure.py -K $k --input=$indir/$infilePREFIX --output=$outdir/${infilePREFIX}.faststructure_output
### --tol=10e-12 #use this if you want to increase convergance

# "This generates a genotypes_output.3.log file that tracks how the algorithm proceeds, 
# and files genotypes_output.3.meanQ and genotypes_output.3.meanP 
# containing the posterior mean of admixture proportions and allele frequencies, respectively."
# note that the output prefix has the K value appended, which is handy:
# e.g. XX.test.faststructure_output.2.log is the result of the above line of code with K =2 
# to 
# choose the correct K:

# want to plot each one:
if [ -s $pops ]
then
python $fastDir/distruct.py \
-K $k \
--input=$outdir/$infilePREFIX.faststructure_output \
--output=$plotdir/${infilePREFIX}.faststructure_plot.${k}.svg \
--title="fastStructure Results, K=$k" \
--popfile=$pops

else
echo "you didn't do manual assignment of populations? go back and do that."
python $fastDir/distruct.py \
-K $k \
--input=$outdir/$infilePREFIX.faststructure_output \
--output=$plotdir/${infilePREFIX}.faststructure_plot.${k}.svg \
--title="fastStructure Results, K=$k" 
fi
done
# choose amongst the K values:
python $fastDir/chooseK.py --input=$outdir/$infilePREFIX.faststructure_output > $outdir/$infilePREFIX.faststructure.chooseK.output

# Based on what I see, I want to know the individual names for K=5
#k=5
#python $fastDir/distruct.py \
#-K $k \
#--input=$outdir/$infilePREFIX.faststructure_output \
#--output=$plotdir/${infilePREFIX}.faststructure_plot.${k}.indNames.svg \
#--title="fastStructure Results, K=$k" \
#--popfile=$indir/${infilePREFIX}.samples
############ planning to run faststructure for multiple values of K
# how many?
# kuril, commander, aleutian, alaska, california = 5
# kuril, bering, medny, aleutian, alaska, california = 6
# kuril, bering, medny, attu, adak, amchitka, alaska, california = 8
# kuril+commander, aleutian, alaska, california = 4
# kuril + commander, aleut+alaska, cali = 3
# so for at least 3,4,5,6,7,8
