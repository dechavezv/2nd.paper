source /u/local/Modules/default/init/modules.sh
module load java
module load bedtools
module load plink

GATK=/u/home/a/ab08028/klohmueldata/annabel_data/bin/GenomeAnalysisTK-3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/a/ab08028/klohmueldata/annabel_data/ferret_genome/Mustela_putorius_furo.MusPutFur1.0.dna.toplevel.fasta
fastDir=/u/home/a/ab08028/klohmueldata/annabel_data/bin/fastStructure
kvals="1 2 3 4" # set this to whatever numbers you want 



snpNoCallFrac=0.2
genotypeDate=20181119

################ Just Baja - California Structure ##################
# select 2 california individuals at random (a few selections)
# not RWAB; not low coverage
# choose from: 
# 114_Elut_CA_214
# 115_Elut_CA_305
# 116_Elut_CA_307
# 117_Elut_CA_315
# 139_Elut_CA_390
# 140_Elut_CA_403
# 141_Elut_CA_419
# 142_Elut_CA_365 
# these aren't low coverage or RWAB -- chose 6 (3 pairs)
ind1=114_Elut_CA_214
ind2=117_Elut_CA_315

ind3=140_Elut_CA_403
ind4=142_Elut_CA_365

ind5=115_Elut_CA_305
ing6=139_Elut_CA_390

# want to add two alaska:

ind7=64_Elut_AK_GE91059
ind8=129_Elut_AK_AL4660

# temprorarly using QD2 dir (change once my script finishes)
vcfdir=/u/flashscratch/a/ab08028/captures/vcf_filtering/${genotypeDate}_filtered/QD2Filter_deleteAfterCompare ## temporary!!! 
mkdir -p $vcfdir/subsampledVCFs/plinkFormat
outdir=$vcfdir/subsampledVCFs/plinkFormat
vcf=snp_7_maxNoCallFrac_${snpNoCallFrac}_passingBespoke_passingAllFilters_postMerge_raw_variants.vcf.gz
# pair these with the Baja for PCA: 

# first pair: 
java -jar $GATK \
-R $REFERENCE \
-T SelectVariants \
--variant $vcfdir/$vcf \
-o ${vcfdir}/subsampledVCFs/subsample.1.BAJ.${ind1}.${ind2}.$vcf \
-se $ind1 \
-se $ind2 \
-se '.+_BAJ_.+' 

# first pair + alaska
java -jar $GATK \
-R $REFERENCE \
-T SelectVariants \
--variant $vcfdir/$vcf \
-o ${vcfdir}/subsampledVCFs/subsample.1.BAJ.${ind1}.${ind2}.plus2Alaska.$vcf \
-se $ind1 \
-se $ind2 \
-se $ind7 \
-se $ind8 \
-se '.+_BAJ_.+'

# second pair: 
java -jar $GATK \
-R $REFERENCE \
-T SelectVariants \
--variant $vcfdir/$vcf \
-o ${vcfdir}/subsampledVCFs/subsample.2.BAJ.${ind3}.${ind4}.$vcf \
-se $ind3 \
-se $ind4 \
-se '.+_BAJ_.+' 

# third pair:
# second pair: 
java -jar $GATK \
-R $REFERENCE \
-T SelectVariants \
--variant $vcfdir/$vcf \
-o ${vcfdir}/subsampledVCFs/subsample.3.BAJ.${ind5}.${ind6}.$vcf \
-se $ind5 \
-se $ind6 \
-se '.+_BAJ_.+' 

# fast convert to plink
for i in {1..3}
do
mkdir -p $outdir/subsample.${i}.BAJ
plink --vcf ${vcfdir}/subsampledVCFs/subsample.${i}.BAJ.*gz --make-bed --keep-allele-order --const-fid 0 --allow-extra-chr --maf 0.05 -out $outdir/subsample.${i}.BAJ/subsample.${i}.BAJ.${ind1}.${ind2}.${vcf%.vcf.gz}
# get sample list:
awk '{print $2}' $outdir/subsample.${i}.BAJ/subsample.${i}.BAJ.${ind1}.${ind2}.${vcf%.vcf.gz}.fam > $outdir/subsample.${i}.BAJ/subsample.${i}.BAJ.${ind1}.${ind2}.${vcf%.vcf.gz}.samples
cp $outdir/subsample.${i}.BAJ/subsample.${i}.BAJ.${ind1}.${ind2}.${vcf%.vcf.gz}.samples $outdir/subsample.${i}.BAJ/subsample.${i}.BAJ.${ind1}.${ind2}.${vcf%.vcf.gz}.manual.popAssignment
### then do assignment
done

######## plink conversino of file with AK:
mkdir -p $outdir/subsample.1.BAJ.plusAK

plink --vcf ${vcfdir}/subsampledVCFs/subsample.1.BAJ.${ind1}.${ind2}.plus2Alaska.$vcf --make-bed --keep-allele-order --const-fid 0 --allow-extra-chr --maf 0.05 -out $outdir/subsample.1.BAJ.plusAK/subsample.1b.BAJ.${ind1}.${ind2}.plus2Alaska.${vcf%.vcf.gz}



######### manually do pop assignments !!!!!!!!!! #########

# then:
for i in 1
do
awk '{print $2}' $outdir/subsample.${i}.BAJ/subsample.${i}.BAJ.${ind1}.${ind2}.${vcf%.vcf.gz}.manual.popAssignment > $outdir/subsample.${i}.BAJ/subsample.${i}.BAJ.${ind1}.${ind2}.${vcf%.vcf.gz}.pops
done
# run faststructure:
for i in 1
do
indir=$vcfdir/subsampledVCFs/plinkFormat/subsample.${i}.BAJ/
infilePREFIX=subsample.${i}.BAJ.${ind1}.${ind2}.${vcf%.vcf.gz}
fastoutdir=$SCRATCH/captures/analyses/FASTSTRUCTURE/${genotypeDate}_filtered
plotdir=$fastoutdir/plots
mkdir -p $plotdir # makes outdir and plotdir
pops=$indir/${infilePREFIX}.pops # file list of population assignments (single column) in same order as your sample input *careful here* get order from .fam or .nosex files
for k in $kvals
do
echo "carrying out faststructure analysis with K = $k "
python $fastDir/structure.py -K $k --input=$indir/$infilePREFIX --output=$fastoutdir/${infilePREFIX}.faststructure_output

if [ -s $pops ]
then
python $fastDir/distruct.py \
-K $k \
--input=$fastoutdir/$infilePREFIX.faststructure_output \
--output=$plotdir/${infilePREFIX}.faststructure_plot.${k}.svg \
--title="fastStructure Results, K=$k" \
--popfile=$pops

else
echo "you didn't do manual assignment of populations? go back and do that."
# python $fastDir/distruct.py \
# -K $k \
# --input=$outdir/$infilePREFIX.faststructure_output \
# --output=$plotdir/${infilePREFIX}.faststructure_plot.${k}.svg \
# --title="fastStructure Results, K=$k" 
fi
done
done

########  adding in Alaska: #########

indir=$vcfdir/subsampledVCFs/plinkFormat/subsample.1.BAJ.plusAK/
infilePREFIX=subsample.1b.BAJ.114_Elut_CA_214.117_Elut_CA_315.plus2Alaska.snp_7_maxNoCallFrac_0.2_passingBespoke_passingAllFilters_postMerge_raw_variants
fastoutdir=$SCRATCH/captures/analyses/FASTSTRUCTURE/${genotypeDate}_filtered
plotdir=$fastoutdir/plots
for k in $kvals
do
echo "carrying out faststructure analysis with K = $k "
python $fastDir/structure.py -K $k --input=$indir/$infilePREFIX --output=$fastoutdir/${infilePREFIX}.faststructure_output

if [ -s $pops ]
then
python $fastDir/distruct.py \
-K $k \
--input=$fastoutdir/$infilePREFIX.faststructure_output \
--output=$plotdir/${infilePREFIX}.faststructure_plot.${k}.svg \
--title="fastStructure Results, K=$k" \
--popfile=$pops

else
echo "you didn't do manual assignment of populations? go back and do that."
fi
done
# do for adding in Alaska:


# ********* skip 2/3 pairs for now (wait until 1b+  QD 8 is done ) ***************