##########################################################################
Here is list of what you need to run msmc

You need a vcf for each chromsome with all your final callable bialllelic SNP sites \
(homozygous reference, homozygous alternate and heterozygous) that have passed all your filters (make sure there are no indels left in).

Once you have your vcf files, you can use my script Step_1_PrepMSMCMAGIC.concise.sh to prepare your vcf for MSMC.

For MSMC your input should look like:
<Chromosome Name > 	<Position> <Bp since last heterozygote> <Genotype on each haplotype — for a single individual there should NOT be more than two letters here. If there are, indels are messing stuff up>
Example line: 
GL897065.1	18452	33	AG

Then run MSMC using the following scripts: 
MSMC: Step_2_runMSMC.sh1

For MSMC, you can then convert to years and Ne and plot using: Step_3_plotMSMCResults.R


#################################################################
Instructions to install MSMC in Hoffman2

1. start an interactive session with qrsh:

qrsh -l i,h_data=1g

2. load the latests gdc
module load gdc/4.9.3

3. download the source:
wget https://github.com/stschiff/msmc/archive/master.zip

4. unpack:
unzip master.zip
cd msmc-master

5. edit the Makefile so that it will be:
###
# Set this variable to your static gsl libraries
#GSL = /usr/local/lib/libgsl.a /usr/local/lib/libgslcblas.a
GSL = -lgsl -lgslcblas

build/msmc : model/*.d powell.d brent.d maximization_step.d expectation_step.d msmc.d branchlength.d logger.d
#dmd -O ${GSL} -odbuild -ofbuild/msmc $^
gdc -O ${GSL} -o msmc $^

build/maximize : model/*.d powell.d brent.d maximization_step.d logger.d maximize.d
#dmd -O ${GSL} -odbuild -ofbuild/maximize $^
gdc -O ${GSL} -o maximize $^

build/test/msmc : model/*.d powell.d brent.d maximization_step.d expectation_step.d msmc.d branchlength.d logger.d
#dmd -O ${GSL} -odbuild/test -ofbuild/test/msmc $^
gdc -O ${GSL} -o test/msmc $^

build/test : model/*.d test.d
#dmd ${GSL} -odbuild -ofbuild/test $^
gdc ${GSL} -o test $^

build/decode : model/*.d decode.d branchlength.d
#dmd ${GSL} -odbuild -ofbuild/decode $^
gdc ${GSL} -o decode $^

build/decodeStates : model/*.d decodeStates.d branchlength.d
#dmd ${GSL} -odbuild -ofbuild/decodeStates $^
gdc ${GSL} -o decodeStates $^

.PHONY : unittest testcoverage clean

testcoverage : model/*.d unittest.d powell.d brent.d maximization_step.d expectation_step.d amoeba.d logger.d
mkdir -p code_coverage
#dmd -unittest -cov ${GSL} -odbuild -ofbuild/unittest $^
gdc ${GSL} -o unittest $^
build/unittest
mv *.lst code_coverage/

unittest : model/*.d unittest.d powell.d brent.d maximization_step.d expectation_step.d logger.d branchlength.d
#dmd -unittest ${GSL} -odbuild -ofbuild/unittest $^
ls

build/unittest

clean :
find build -type f -delete
### 

6. Now to make msmc issue:

make build/msmc

