#! /usr/local/perl -w
#
#
#open(INA,"/media/Project/03_LongGeneDB/Long_Gene_list_200kb_test.txt")||die("Can't open IN:$!\n");
open(INA,"/media/Project/03_LongGeneDB/Long_Gene_list_200kb.txt")||die("Can't open IN:$!\n");

my $a1=$a2=$a3=0;
while(<INA>)
{
 chomp;
 if(/^ENSMUSG\d+\_[\w\.\-]+\s+[\w\.\-]+\s+(chr\w\w?)\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-]+)\:\w+\:([+|-])\s*$/)
 {
  $chr=$1; $left=$2-100000; $right=$3+100000; $gene=$4; $strand=$5;
  $loci="$chr:$left-$right";

  $a1++; print "\n\nWorking on gene $a1: $gene\n";
  if($strand eq "+") ## gene at plus strand
  {
   $a2++;
   system ("analyzeHiC RenLab_HiC_8w_cortex -pos $loci -res 2000 -window 10000 -balance -cpu 40 -corr -o LongGene/$gene\_HiC2k10k_corr.txt");
  }
  elsif($strand eq "-") ## genes at minus strand
  {
   $a3++;
   system ("analyzeHiC RenLab_HiC_8w_cortex -pos $loci -res 2000 -window 10000 -balance -cpu 40 -corr -o LongGene/reverse/$gene\_HiC2k10k_corr_r.txt");

   print "\n\n Working on reverse the files. gene $a1\n\n";
   ## Reverse the matrix for genes on the - strand
   open(INB,"LongGene/reverse/$gene\_HiC2k10k_corr_r.txt")||die("Can't open INB:$!\n");
   open(OUT,">LongGene/$gene\_HiC2k10k_corr.txt")||die("Can't write OUT:$!\n");

   my $i=0;
   while(<INB>)
   {
    chomp;
    if(/^(HiCMatrix\s\(directory=RenLab_HiC_8w_cortex\)\tRegions)\t(chr.*)$/){$i++;$first{$i}=$1; $second{$i}=$2;}
    elsif(/^(chr\w\w?\-\d+\tchr\w\w?\-\d+)\t(.*)$/){$i++;$first{$i}=$1; $second{$i}=$2;}
    else{print "error reverse files: $_\n";}
   }

   ## the First line; should still be the first line
   print OUT "$first{'1'}\t";
   my @array1 = split("\t", $second{'1'}); print OUT join("\t", reverse @array1), "\n";

   ## For other lines 
   for($j=$i;$j>1;$j--)
   {
    print OUT "$first{$j}\t";
    my @array1 = split("\t", $second{$j}); print OUT join("\t", reverse @array1), "\n";
   }

   close INB; close OUT;
   ### End of the reverse - gene files

  }
  else{print "error strand: $_\n";}
 }
 else{print "error1\t$_\n";}
}

print "Total-genes:$a1\t+ gene: $a2\t -gene: $a3\n";
close INA;

