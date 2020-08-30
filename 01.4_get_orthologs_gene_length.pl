#! /usr/local/perl -w
#
open(INA,"/media/Project/Genome/BLAST/Ensembl99/Homo_sapiens.GRCh38.99.chr_patch_hapl_scaff.gtf.gene")||die("Can't open INA:$!\n");
open(INB,"/media/Project/Genome/BLAST/Ensembl99/Sus_scrofa.Sscrofa11.1.99.gtf.gene")||die("Can't open INB:$!\n");
open(INC,"/media/Project/Genome/BLAST/Ensembl99/Gallus_gallus.GRCg6a.99.gtf.gene")||die("Can't open INC:$!\n");
open(IND,"/media/Project/Genome/BLAST/Ensembl99/Xenopus_tropicalis.Xenopus_tropicalis_v9.1.99.gtf.gene")||die("Can't open IND:$!\n");
open(INE,"/media/Project/Genome/BLAST/Ensembl99/Drosophila_melanogaster.BDGP6.28.99.gtf.gene")||die("Can't open INE:$!\n");
open(INF,"/media/Project/Genome/BLAST/Ensembl99/Caenorhabditis_elegans.WBcel235.99.gtf.gene")||die("Can't open INF:$!\n");

open(ING,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf.gene")||die("Can't open ING:$!\n");

open(INH,"Length/Long_Gene_list_orthologs.xls")||die("Can't open INB:$!\n");
 

open(OUT,">Length/Long_Gene_list_orthologs_length.xls")||die("Can't write OUT:$!\n");
 
while(<INA>){chomp;if(/^\w+\t\w+\tgene\t(\d+)\t(\d+)\t[+|-]\t(\w+)\t/){$len=$2-$1+1; $human{$3}=$len;}else{print "error1\t$_\n";}}
while(<INB>){chomp;if(/^[\w\.]+\t\w+\tgene\t(\d+)\t(\d+)\t[+|-]\t(\w+)/){$len=$2-$1+1; $pig{$3}=$len;}else{print "error2\t$_\n";}}
while(<INC>){chomp;if(/^[\w\.]+\t\w+\tgene\t(\d+)\t(\d+)\t[+|-]\t(\w+)/){$len=$2-$1+1; $chicken{$3}=$len;}else{print "error3\t$_\n";}}
while(<IND>){chomp;if(/^[\w\.]+\t\w+\tgene\t(\d+)\t(\d+)\t[+|-]\t(\w+)/){$len=$2-$1+1; $frog{$3}=$len;}else{print "error4\t$_\n";}}
while(<INE>){chomp;if(/^\w+\t\w+\tgene\t(\d+)\t(\d+)\t[+|-]\t(\w+)/){$len=$2-$1+1; $fly{$3}=$len;}else{print "error5\t$_\n";}}
while(<INF>){chomp;if(/^\w+\t\w+\tgene\t(\d+)\t(\d+)\t[+|-]\t(\w+)/){$len=$2-$1+1; $worm{$3}=$len;}else{print "error6\t$_\n";}}
while(<ING>){chomp;if(/^\w\w?\t\w+\tgene\t(\d+)\t(\d+)\t[+|-]\t(\w+)\t/){$len=$2-$1+1; $mouse{$3}=$len;}else{print "error7\t$_\n";}}
 

print OUT "\tHuman\tMouse\tPig\tChicken\tFrog\tFly\tWorm\tHumanID\tMouseID\tPigID\tChickenID\tFrogID\tFlyID\tWormID\n";
while(<INH>)
{
 chomp;
 if(/(ENSMUSG\d+)\_([\w\.\-]+)\t\w+\t(\w+)\t[\w\.\-]+\t\w+\t(\w+)\t[\w\.\-]+\t\w+\t(\w+)\t[\w\.\-]+\t\w+\t(\w+)\t[\w\.\-]+\t\w+\t(\w+)\t[\w\.\-]+\t[\w\.]+\t(\w+)\t[\w\.\-]+$/)
 {
  print OUT "$1_$2\t";
  if(exists $human{$3}){  print OUT "$human{$3}\t";}else{  if($3 eq "NA") {print OUT "0\t";}else{print "error not exists Human: $3\n";}}
  if(exists $mouse{$1}){  print OUT "$mouse{$1}\t";}else{  print "error not exists Mouse: $1\n";}
  if(exists $pig{$4}){    print OUT "$pig{$4}\t";}else{    if($4 eq "NA") {print OUT "0\t";}else{print "error not exists Pig: $4\n";}}
  if(exists $chicken{$5}){print OUT "$chicken{$5}\t";}else{if($5 eq "NA") {print OUT "0\t";}else{print "error not exists Chicken: $5\n";}}
  if(exists $frog{$6}){   print OUT "$frog{$6}\t";}else{   if($6 eq "NA") {print OUT "0\t";}else{print "error not exists Frog: $6\n";}}
  if(exists $fly{$7}){    print OUT "$fly{$7}\t";}else{    if($7 eq "NA") {print OUT "0\t";}else{print "error not exists Fly: $7\n";}}
  if(exists $worm{$8}){   print OUT "$worm{$8}\t";}else{   if($8 eq "NA") {print OUT "0\t";}else{print "error not exists Worm: $8\n";}}
 
  print OUT "$3\t$1\t$4\t$5\t$6\t$7\t$8\n"
 }
 else{print "error8\t$_\n";}
}

close OUT;


