# can be run in the shell on an interactive node (takes ~ 1min)
###### Need to convert vcf file to plink bed format 
# isn't there some issue with chromosomes?
# need to make sure it's only SNPs not invariant sites
# so want to convert my final SNP file

source /u/local/Modules/default/init/modules.sh
module load plink

calldate=20181119 # date that genotypes were called
indir=/u/flashscratch/a/ab08028/captures/vcf_filtering/${calldate}_filtered/
 # temporary
#indir=/u/flashscratch/a/ab08028/captures/vcf_filtering/${calldate}_filtered/downsampledVCFs/
# sample size can have an effect, so have downsampled the commanders:
#infile=snp_7_maxNoCallFrac_0.2_passingBespoke_passingAllFilters_postMerge_raw_variants.vcf.gz
infile=snp_7_maxNoCallFrac_0.2_passingBespoke_passingAllFilters_postMerge_raw_variants.vcf.gz
outdir=$SCRATCH/captures/vcf_filtering/${calldate}_filtered/plinkFormat 
mkdir -p $outdir
# you need to use const-fid 0 otherwise it thinks that family name_sample name is structure of ID and tries to split it (and fails)
# allow extra chromosomes: to get it to get over the fact that chr names are non standard (make sure these wont get ignored?)
plink --vcf $indir/$infile --make-bed --keep-allele-order --const-fid 0 --allow-extra-chr --maf 0.05 -out $outdir/${infile%.vcf.gz}
### note for faststructure to work you have to filter on maf 0.05
