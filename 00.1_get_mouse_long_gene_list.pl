#! /usr/local/perl -w
#
# Obtaiin the list of long genes from the mouse genome
#
# 200kb list: Manually remove ENSMUSG00000107705_Gm45062 ENSMUSG00000030068_Gm20696 
#
#
open(INA,"/media/Data/ZhouLab/Deborah/Stress_RNAseq/Merge_DK_JAXmale_P90_nuRNAseq_mPFC_CUS_whole_gene.txt")||die("Can't open INA:$!\n");
open(OUA,">Long_Gene_list_200kb.txt")||die("Can't write OUA:$!\n");
open(OUB,">Long_Gene_list_100kb.txt")||die("Can't write OUB:$!\n");

while(<INA>)
{
 chomp;
 if(/^(chr\w\w?)\:(\d+)\-(\d+)\:(ENSMUSG\d+)\_([\w\.\-\(\)]+)\:(\w+)\:([+|-])\s+/)
 {
  $length=$3-$2+1; 
  if($6 eq "protein_coding")
  {
   if($length>200000){$a1++; print OUA "$4_$5\t$5\t$1:$2-$3:$4_$5:$6:$7\n";}
   if($length>100000){$a2++; print OUB "$4_$5\t$5\t$1:$2-$3:$4_$5:$6:$7\n";}
  }
 }
 else{print "error1\t$_\n";}
}

print ">200kb: $a1\t>100kb: $a2\n";

close INA; close OUA; close OUB;

