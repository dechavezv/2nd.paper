Hi Daniel,

Here are some scripts for filtering VCF files, running the sliding window heterozygosity tally, \
and plotting the results in R. 

I haven't changed very much with the sliding window heterozygosity scripts, \
but lately the only filter I've been applying to the output is I exclude windows \
where the number of called genotypes is <50% of the window size. I also now mostly \
use non-overlapping 1 Mb windows. You can use whatever size you want, though.

As for filtering, I have made some changes since my Isle Royale wolf project. \
I still use the standard GATK site filters, and I use a repeat mask, \
but I have made some changes to the genotype filtering. \
My genotype filtering is now mainly just filtering on depth and allele balance:

- Min depth: 1/3x mean coverage (per individual)

- Max depth: 2x mean coverage (per individual)
(these are the depth filters suggested by Heng Li in the PSMC manual, \
and they're easier to calculate than percentiles)

- Allele balance (REF/DP from the genotype FORMAT field): no more than 10% of \
reads showing the other allele at homozygotes (either 0/0 or 1/1), and for hets \
the ratio must be between 0.2 and 0.8.

Other things that I do differently lately:
- No base quality score recalibration if any samples are not the same species as the reference. 
- No filtering on total depth (DP in the INFO column).
- No filtering on GQ. Again, there is a bias in individuals that are more divergent from the reference,\
and it turns out that GQ and RGQ are not comparable.

I'm pretty lazy with commenting in scripts so let me know if you have questions. \
Or ask Chris, since I have been talking to him about a lot of this stuff lately too.
