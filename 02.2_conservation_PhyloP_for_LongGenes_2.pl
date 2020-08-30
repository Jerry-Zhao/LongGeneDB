#! /usr/local/perl -w
#
#
# mm10.phyloP.glire - the glire subset:
#          mm10 cavPor3 dipOrd1 hetGla2 ochPri2 oryCun2 rn5 speTri2
# mm10.phyloP.euarchontoglire - the euarchontoglire subset: including glire subset above plus:
#           tupBel1 calJac3 gorGor3 hg19 micMur1 nomLeu2 otoGar3 panTro4 papHam1
#           ponAbe2 rheMac3 saiBol1 tarSyr1
# mm10.phyloP.placental - the placental subset: glire and euarchontoglire subsets above plus:
#           ailMel1 bosTau7 canFam3 choHof1 dasNov3 echTel1 equCab2 eriEur1
#           felCat5 loxAfr3 myoLuc2 oviAri1 proCap1 pteVam1 sorAra1 susScr3
#           triMan1 turTru2 vicPac1
# mm10.phyloP.60way.mod - phyloP tree model with branch lengths for all 60 species:
#         the glire, euarchontoglire and placental sets above plus:
#           anoCar2 chrPic1 danRer7 fr3 gadMor1 galGal4 gasAcu1 latCha1
#           macEug2 melGal1 melUnd1 monDom5 oreNil2 ornAna1 oryLat2 petMar1
#           sarHar1 taeGut1 tetNig2 xenTro3
#
#
open(INAA,"Long_Gene_list_200kb.txt")||die("Can't open INAA:$!\n");
open(INA,"/media/Project/Genome/phyloP/mm10_phyloP60way.glire.txt")||die("Can't open INA:$!\n");
open(INB,"/media/Project/Genome/phyloP/mm10_phyloP60way.euarchontoglires.txt")||die("Can't open INB:$!\n");
open(INC,"/media/Project/Genome/phyloP/mm10_phyloP60way.placental.txt")||die("Can't open INC:$!\n");
open(IND,"/media/Project/Genome/phyloP/mm10_phyloP60way.txt")||die("Can't open IND:$!\n");
open(INE,"Long_Gene_list_200kb.txt")||die("Can't open INE:$!\n");

print "Working on File 1 of file 6\n";
my $count=0; 
while(<INAA>)
{
 chomp;
 if(/^ENSMUSG\d+\_[\w\.\-\(\)]+\t[\w\.\-\(\)]+\tchr(\w\w?)\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-\(\)]+)\:\w+\:([+|-])$/)
 {
  $count++; print "$count\n";

  if(($count>300) and($count<=650)) ## part 1: 300-650 0f 992 genes; not enough memory
  {
   $chr=$1; $left=$2; $right=$3; $strand=$5; $gene_id=$4; 
   for($i=$left-10005;$i<$right+10005; $i++)
   {
    $id2="$chr\_$i"; $all{$id2}=0; $placenta{$id2}=0; $glire{$id2}=0; $euarch{$id2}=0; ## initial the HASH
   }
  }
 }
 else{print "errorAA\t$_\n";}
}

print "Working on File 2 of file 6\n";
while(<INA>){chomp;if(/^(\w\w?)\t(\d+)\t([\d\.\-]+)$/){$id="$1_$2"; if(exists $glire{$id}){$glire{$id}=$3;}}else{print "error1\t$_\n";}}

print "Working on File 3 of file 6\n";
while(<INB>){chomp;if(/^(\w\w?)\t(\d+)\t([\d\.\-]+)$/){$id="$1_$2"; if(exists $euarch{$id}){$euarch{$id}=$3;}}else{print "error1\t$_\n";}}

print "Working on File 4 of file 6\n";
while(<INC>){chomp;if(/^(\w\w?)\t(\d+)\t([\d\.\-]+)$/){$id="$1_$2";if(exists $placenta{$id}){$placenta{$id}=$3;}}else{print "error2\t$_\n";}}

print "Working on File 5 of file 6\n";
while(<IND>){chomp;if(/^(\w\w?)\t(\d+)\t([\d\.\-]+)$/){$id="$1_$2"; if(exists $all{$id}){$all{$id}=$3;}}else{print "error1\t$_\n";}}

print "Working on File 6 of file 6: output\n";
my $count2=0; 
while(<INE>)
{
 chomp;
 if(/^ENSMUSG\d+\_[\w\.\-\(\)]+\t[\w\.\-\(\)]+\tchr(\w\w?)\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-\(\)]+)\:\w+\:([+|-])$/)
 {
  $count2++; print "$count2\n";

  if(($count2>300) and ($count2<=650)) ## part 1: 300-650 0f 992 genes; not enough memory
  {
   $chr=$1; $left=$2; $right=$3; $strand=$5; $gene_id=$4; 
   
   open(OUT, ">Conservation/score/$gene_id\_mm10_phyloP60way.txt")||die("Can't write OUT:$!\n");
 
   if($strand eq "+")
   { 
    print OUT "Glire";      for($i=$left-10000;$i<$right+10000; $i++){$id2="$chr\_$i"; print OUT "\t$glire{$id2}";}    print OUT "\n";
    print OUT "Euarchonto"; for($i=$left-10000;$i<$right+10000; $i++){$id2="$chr\_$i"; print OUT "\t$euarch{$id2}";}   print OUT "\n";
    print OUT "Placental";  for($i=$left-10000;$i<$right+10000; $i++){$id2="$chr\_$i"; print OUT "\t$placenta{$id2}";} print OUT "\n";
    print OUT "All60";      for($i=$left-10000;$i<$right+10000; $i++){$id2="$chr\_$i"; print OUT "\t$all{$id2}";}      print OUT "\n";
   }
   elsif($strand eq "-")
   {
    print OUT "Glire";      for($i=$right+10000;$i>$left-10000; $i--){$id2="$chr\_$i"; print OUT "\t$glire{$id2}";}    print OUT "\n";
    print OUT "Euarchonto"; for($i=$right+10000;$i>$left-10000; $i--){$id2="$chr\_$i"; print OUT "\t$euarch{$id2}";}   print OUT "\n";
    print OUT "Placental";  for($i=$right+10000;$i>$left-10000; $i--){$id2="$chr\_$i"; print OUT "\t$placenta{$id2}";} print OUT "\n";
    print OUT "All60";      for($i=$right+10000;$i>$left-10000; $i--){$id2="$chr\_$i"; print OUT "\t$all{$id2}";}      print OUT "\n";
   }
   else{print "error strand: $strand $_\n";}
  
   close OUT;   
  }
 }
 else{print "errorAA\t$_\n";}
}

close INA; close INB; close INC; close INAA;

