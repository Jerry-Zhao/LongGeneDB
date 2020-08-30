#! /usr/local/perl -w
#
#


@chromo=("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10","chr11","chr12","chr13","chr14","chr15",
         "chr16","chr17","chr18","chr19","chrX","chrY","chrMT");

foreach $chr (@chromo)
{

print "\n\nWorking on chromosome: $chr\n";

open(INA,"Long_Gene_list_200kb.txt")||die("Can't open INA:$!\n");
open(INB,"Epigenome/mENCODE_ChIP_bedgraph/H3K27ac_RenLab_8w.txt.$chr")||die("Can't open INB:$!\n");
open(INC,"Long_Gene_list_200kb.txt")||die("Can't open INC:$!\n");


print "Working on File 1 of file 3\n";
while(<INA>)
{
 chomp;
 if(/^ENSMUSG\d+\_[\w\.\-\(\)]+\t[\w\.\-\(\)]+\t(chr\w\w?)\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-\(\)]+)\:\w+\:([+|-])$/)
 {
  if($1 eq $chr) ## Long Genes on $chr
  {
   $left=$2; $right=$3;
   for($i=$left-10005;$i<$right+10005; $i++)
   {
    $bone{$i}=0; $brown{$i}=0; $cereb{$i}=0; $cortex{$i}=0; $heart{$i}=0; $kidney{$i}=0; $liver{$i}=0; ## initial the HASH
    $lung{$i}=0; $bulb{$i}=0; $placenta{$i}=0; $small{$i}=0; $spleen{$i}=0; $testis{$i}=0; $thymus{$i}=0; ## initial the HASH
   }
  }
 }
 else{print "error1\t$_\n";}
}

print "Working on File 2 of file 3\n";
while(<INB>)
{
 chomp;
 if(/^(chr\w\w?)\_(\d+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)$/)
 {
  if($1 ne $chr){print "error wrong chromosome-$chr: $_\n";} 
  if(exists $bone{$2})
  {
   $bone{$2}=$3; $brown{$2}=$4; $cereb{$2}=$5; $cortex{$2}=$6; $heart{$2}=$7; $kidney{$2}=$8; $liver{$2}=$9; 
   $lung{$2}=$10; $bulb{$2}=$11; $placenta{$2}=$12; $small{$2}=$13; $spleen{$2}=$14; $testis{$2}=$15; $thymus{$2}=$16; 
  }
 }
 else{print "error2\t$_\n";}
}


print "Working on File 3 of file 3: output\n";
while(<INC>)
{
 chomp;
 if(/^ENSMUSG\d+\_[\w\.\-\(\)]+\t[\w\.\-\(\)]+\t(chr\w\w?)\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-\(\)]+)\:\w+\:([+|-])$/)
 {
  if($1 eq $chr) ##  Long Genes on $chr
  {
   $left=$2; $right=$3; $strand=$5; $gene_id=$4; 
   
   open(OUT, ">Epigenome/value/$gene_id\_H3K27ac.txt")||die("Can't write OUT:$!\n");
 
   if($strand eq "+")
   { 
    print OUT "Bone_Marrow";    for($i=$left-10000;$i<$right+10000; $i++){print OUT "\t$bone{$i}";}    print OUT "\n";
    print OUT "Brown_Adipose";  for($i=$left-10000;$i<$right+10000; $i++){print OUT "\t$brown{$i}";}    print OUT "\n";
    print OUT "Cerebellum";     for($i=$left-10000;$i<$right+10000; $i++){print OUT "\t$cereb{$i}";}    print OUT "\n";
    print OUT "Cortex";         for($i=$left-10000;$i<$right+10000; $i++){print OUT "\t$cortex{$i}";}    print OUT "\n";
    print OUT "Heart";          for($i=$left-10000;$i<$right+10000; $i++){print OUT "\t$heart{$i}";}    print OUT "\n";

    print OUT "Kidney";         for($i=$left-10000;$i<$right+10000; $i++){print OUT "\t$kidney{$i}";}    print OUT "\n";
    print OUT "Liver";          for($i=$left-10000;$i<$right+10000; $i++){print OUT "\t$liver{$i}";}    print OUT "\n";
    print OUT "Lung";           for($i=$left-10000;$i<$right+10000; $i++){print OUT "\t$lung{$i}";}    print OUT "\n";
    print OUT "Olfactory_Bulb"; for($i=$left-10000;$i<$right+10000; $i++){print OUT "\t$bulb{$i}";}    print OUT "\n";
    print OUT "Placenta";       for($i=$left-10000;$i<$right+10000; $i++){print OUT "\t$placenta{$i}";}    print OUT "\n";

    print OUT "Small_Intestine";for($i=$left-10000;$i<$right+10000; $i++){print OUT "\t$small{$i}";}    print OUT "\n";
    print OUT "Spleen";         for($i=$left-10000;$i<$right+10000; $i++){print OUT "\t$spleen{$i}";}    print OUT "\n";
    print OUT "Testis";         for($i=$left-10000;$i<$right+10000; $i++){print OUT "\t$testis{$i}";}    print OUT "\n";
    print OUT "Thymus";         for($i=$left-10000;$i<$right+10000; $i++){print OUT "\t$thymus{$i}";}    print OUT "\n";
   }
   elsif($strand eq "-")
   {
    print OUT "Bone_Marrow";    for($i=$right+10000;$i>$left-10000; $i--){print OUT "\t$bone{$i}";}    print OUT "\n";
    print OUT "Brown_Adipose";  for($i=$right+10000;$i>$left-10000; $i--){print OUT "\t$brown{$i}";}    print OUT "\n";
    print OUT "Cerebellum";     for($i=$right+10000;$i>$left-10000; $i--){print OUT "\t$cereb{$i}";}    print OUT "\n";
    print OUT "Cortex";         for($i=$right+10000;$i>$left-10000; $i--){print OUT "\t$cortex{$i}";}    print OUT "\n";
    print OUT "Heart";          for($i=$right+10000;$i>$left-10000; $i--){print OUT "\t$heart{$i}";}    print OUT "\n";

    print OUT "Kidney";         for($i=$right+10000;$i>$left-10000; $i--){print OUT "\t$kidney{$i}";}    print OUT "\n";
    print OUT "Liver";          for($i=$right+10000;$i>$left-10000; $i--){print OUT "\t$liver{$i}";}    print OUT "\n";
    print OUT "Lung";           for($i=$right+10000;$i>$left-10000; $i--){print OUT "\t$lung{$i}";}    print OUT "\n";
    print OUT "Olfactory_Bulb"; for($i=$right+10000;$i>$left-10000; $i--){print OUT "\t$bulb{$i}";}    print OUT "\n";
    print OUT "Placenta";       for($i=$right+10000;$i>$left-10000; $i--){print OUT "\t$placenta{$i}";}    print OUT "\n";

    print OUT "Small_Intestine";for($i=$right+10000;$i>$left-10000; $i--){print OUT "\t$small{$i}";}    print OUT "\n";
    print OUT "Spleen";         for($i=$right+10000;$i>$left-10000; $i--){print OUT "\t$spleen{$i}";}    print OUT "\n";
    print OUT "Testis";         for($i=$right+10000;$i>$left-10000; $i--){print OUT "\t$testis{$i}";}    print OUT "\n";
    print OUT "Thymus";         for($i=$right+10000;$i>$left-10000; $i--){print OUT "\t$thymus{$i}";}    print OUT "\n";

   }
   else{print "error strand: $strand $_\n";}

   close OUT;   
  }
 }
 else{print "error3\t$_\n";}
}

## delete HASH for this chromosome
print "Delete HASH for this chromosome.\n"; 
foreach (keys %bone)
{
  delete $bone{$_};   delete $brown{$_};  delete $cereb{$_};  delete $cortex{$_}; delete $heart{$_}; 
  delete $kidney{$_}; delete $liver{$_};  delete $lung{$_};   delete $bulb{$_};   delete $placenta{$_}; 
  delete $small{$_};  delete $spleen{$_}; delete $testis{$_}; delete $thymus{$_}; 
}

close INA; close INB; close INC;
}

