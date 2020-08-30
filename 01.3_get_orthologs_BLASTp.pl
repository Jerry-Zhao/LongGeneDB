#! /usr/local/perl -w
# Manually check for all "NA" genes, eg genes that has no BLASTp hit
# Ensembl and NCBI website BLASTp
# Manually add these three chicken genes in the output file
# Chicken: Trdn:  ENSGALP00000045329  ENSGALG00000014848
# Chicken Mlip:   ENSGALP00000064915  ENSGALG00000016301
# Chicken Ofcc1:  ENSGALP00000036456  ENSGALG00000022976
#
#
open(INA,"Length/Human_result.out")||die("Can't open INA:$!\n");
open(INB,"Length/Pig_result.out")||die("Can't open INB:$!\n");
open(INC,"Length/Chicken_result.out")||die("Can't open INC:$!\n");
open(IND,"Length/Frog_result.out")||die("Can't open IND:$!\n");
open(INE,"Length/Fruitfly_result.out")||die("Can't open INE:$!\n");
open(INF,"Length/Celegans_result.out")||die("Can't open INF:$!\n");
open(ING,"Long_Gene_list_200kb.txt")||die("Can't open ING:$!\n");

open(OUT,">Length/Long_Gene_list_orthologs.xls")||die("Can't write OUT:$!\n");

my $a1=$a2=$a3=$a4=$a5=$a6=$a7=0; 
while(<INA>)
{
 chomp;
 if(/^Query=\s+(ENSMUSG\d+\_[\w\.\-]+)\s*/)
 {
  $a1++; $label=0; $id=$1;
  $human{$id}="NA\tNA\tNA";  #  print "$id\n";
 }
 elsif(/^>(ENSP\d+)\.\d.*gene:(ENSG\d+)\.\d/)
 {
  if($label==0){$protein=$1; $gene=$2; } ## the first match, protein and gene names
 }
 elsif(/gene_symbol:([\w\.\-]+)\s*/)
 {
  if($label==0)  ## the first match, symbol
  {
   $name=$1; $human{$id}="$protein\t$gene\t$name"; 
#   print "$protein\t$gene\t$name\n";
  }
  $label++;
 }
}


while(<INB>)
{
 chomp;
 if(/^Query=\s+(ENSMUSG\d+\_[\w\.\-]+)\s*/)
 {
  $a2++; $label=0; $id=$1;
  $pig{$id}="NA\tNA\tNA";  #  print "$id\n";
 }
 elsif(/^>(ENSSSCP\d+)\.\d.*gene:(ENSSSCG\d+)\.\d/)
 {
  if($label==0){$protein=$1; $gene=$2; } ## the first match, protein and gene names
 }
 elsif(/gene_symbol:([\w\.\-]+)\s*/)
 {
  if($label==0)  ## the first match, symbol
  {
   $name=$1; $pig{$id}="$protein\t$gene\t$name";
  }
  $label++;
 }
}


while(<INC>)
{
 chomp;
 if(/^Query=\s+(ENSMUSG\d+\_[\w\.\-]+)\s*/)
 {
  $a3++; $label=0; $id=$1;
  $chicken{$id}="NA\tNA\tNA";  #  print "$id\n";
 }
 elsif(/^>(ENSGALP\d+)\.\d.*gene:(ENSGALG\d+)\.\d/)
 {
  if($label==0){$protein=$1; $gene=$2; } ## the first match, protein and gene names
 }
 elsif(/gene_symbol:([\w\.\-]+)\s*/)
 {
  if($label==0)  ## the first match, symbol
  {
   $name=$1; $chicken{$id}="$protein\t$gene\t$name";
  }
  $label++;
 }
}


while(<IND>)
{
 chomp;
 if(/^Query=\s+(ENSMUSG\d+\_[\w\.\-]+)\s*/)
 {
  $a4++; $label=0; $id=$1;
  $frog{$id}="NA\tNA\tNA";  #  print "$id\n";
 }
 elsif(/^>(ENSXETP\d+)\.\d/)
 {
  if($label==0){$protein=$1;} ## the first match, protein name
 }
 elsif(/gene:(ENSXETG\d+)\.\d/)
 {
  if($label==0){$gene=$1; } ## the first match, gene name
 }
 elsif(/gene_symbol:([\w\.\-]+)\s*/)
 {
  if($label==0)  ## the first match, symbol
  {
   $name=$1; $frog{$id}="$protein\t$gene\t$name";
  }
  $label++;
 }
}


while(<INE>)
{
 chomp;
 if(/^Query=\s+(ENSMUSG\d+\_[\w\.\-]+)\s*/)
 {
  $a5++; $label=0; $id=$1;
  $fly{$id}="NA\tNA\tNA";  #  print "$id\n";
 }
 elsif(/^>(FBpp\d+)\s+.*gene:(FBgn\d+)/)
 {
  if($label==0){$protein=$1; $gene=$2; } ## the first match, protein and gene names
 }
 elsif(/gene_symbol:([\w\.\-]+)\s*/)
 {
  if($label==0)  ## the first match, symbol
  {
   $name=$1; $fly{$id}="$protein\t$gene\t$name";
  }
  $label++;
 }
}


while(<INF>)
{
 chomp;
 if(/^Query=\s+(ENSMUSG\d+\_[\w\.\-]+)\s*/)
 {
  $a6++; $label=0; $id=$1;
  $worm{$id}="NA\tNA\tNA";  #  print "$id\n";
 }
 elsif(/^>([\w\.]+)\s+.*gene:(WBGene\d+)\.\d/)
 {
  if($label==0){$protein=$1; $gene=$2; } ## the first match, protein and gene names
 }
 elsif(/gene_symbol:([\w\.\-]+)\s*/)
 {
  if($label==0)  ## the first match, symbol
  {
   $name=$1; $worm{$id}="$protein\t$gene\t$name";
  }
  $label++;
 }
}



print OUT "\tHuman\t\t\tPig\t\t\tChicken\t\t\tFrog\t\t\tFly\t\t\tWorm\t\t\n";
while(<ING>)
{
 chomp;
 if(/^(ENSMUSG\d+\_[\w\.\-]+)\s+/)
 {
  $a7++;
  print OUT "$1\t$human{$1}\t$pig{$1}\t$chicken{$1}\t$frog{$1}\t$fly{$1}\t$worm{$1}\n";
 }
 else{print "error LongGene list: $_\n";}
}

print "Total LongGenes: $a1 $a2 $a3 $a4 $a5 $a6 $a7\n";

close INA; close INB; close INC; close IND; close INE; close INF; close ING;
close OUT;

