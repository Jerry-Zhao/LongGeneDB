#! /usr/local/perl -w
#
# Test whether all long genes are captured by scRNAseq
# Manually rename 10 genes with updated names of similar expression profiles
#
# Total-LongGene: 994     Overlap: 986    Non-overlap: 8
# Pcdha4   --> Cnr1
# Gm37013  --> Cnr1
# Gm37388  --> Cnr1
# Gm42416  --> Cnr1
# Gm3383   --> Gm14461    ## almost all 0 in 22 tissues
# Pcdha2   --> Cnr1
# Pcdha7   --> Cnr1
# Pcdha6   --> Cnr1



open(INA,"Expression/FPKM_merged_mENCODE_exonic_gene_Jerry.xls")||die("Can't open INA:$!\n");
open(INB,"Long_Gene_list_200kb.txt")||die("Can't open INB:$!\n");

while(<INA>){chomp;if(/^(ENSMUSG\d+\_[\w\.\-\(\)]+)\s+/){$fpkm{$1}=1;}else{print "error1\t$_\n";}}

my $a1=$a2=$a3=0;
while(<INB>)
{
 chomp;
 if(/^(ENSMUSG\d+\_[\w\.\-\(\)]+)\s+[\w\.\-\(\)]+\s+/)
 {
  $a1++;
  if(exists $fpkm{$1}){$a2++;}
  else{$a3++; print "$1\n";}
 }
 else{print "error2\t$_\n";}
}

print "Total-LongGene: $a1\tOverlap: $a2\tNon-overlap: $a3\n";



