# can be run in the shell on an interactive node (takes ~ 1min)
###### Need to convert vcf file to plink bed format 
# isn't there some issue with chromosomes?
# need to make sure it's only SNPs not invariant sites
# so want to convert my final SNP file

source /u/local/Modules/default/init/modules.sh
module load plink

calldate=20200727 # date that genotypes were called
indir=/u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData
 # temporary
# sample size can have an effect, so have downsampled the commanders:
#infile=snp_7_maxNoCallFrac_0.2_passingBespoke_passingAllFilters_postMerge_raw_variants.vcf.gz
infile=LS_joint_allchr_Annot_Mask_Filter_passingSNPs.Scaf.vcf 
outdir=/u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/${calldate}_filtered/plinkFormat 
mkdir -p $outdir
# you need to use const-fid 0 otherwise it thinks that family name_sample name is structure of ID and tries to split it (and fails)
# allow extra chromosomes: to get it to get over the fact that chr names are non standard (make sure these wont get ignored?)
plink --vcf $indir/$infile --make-bed --keep-allele-order --const-fid 0 --allow-extra-chr -out $outdir/${infile%.vcf.gz}
### note for faststructure to work you have to filter on --maf 0.05
## -chr-set changes the chromosome set. The first parameter specifies the number of diploid autosome pairs. For intance for the rail vcf that has 35chr I used '--chr-set 35 no-x no-y no-xy no-mt' 
