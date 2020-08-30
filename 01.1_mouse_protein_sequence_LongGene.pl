#! /usr/local/perl -w
# Obtain the longest protein isoform of the LongGenes
#
open(INA,"/media/Project/Genome/Ensembl_93/Protein/Mus_musculus.GRCm38.pep.all.fa")||die("Can't open INA:$!\n");
open(INB,"Long_Gene_list_200kb.txt")||die("Can't open INB:$!\n");
open(OUT,">Length/Long_Gene_list_200kb_protein.txt")||die("Can't write OUT:$!\n");

my $id="ABCD_ABC"; $seq="abcdefg";
while(<INA>)
{
 chomp;
 if(/^>ENSMUSP\d+\.\d+\s+pep\s+[\w\:\-\.]+\s+gene\:(ENSMUSG\d+)\.\d+.*gene_symbol:([\w\.\-]+)\s*/)
 {
  if(exists $protein{$id}){if(length($seq) > length($protein{$id})){$protein{$id}=$seq;}} ## other isoforms of previous gene; longest isoform
  else{$protein{$id}=$seq;} ## first isoform of previous gene

  $id="$1\_$2"; $seq=""; ## current gene
 }
 elsif(/^[A-Z\*]+$/)
 {
  $seq.=$_;
 }
 else{print "error1\t$_\n";}
}

if(exists $protein{$id}){if(length($seq) > length($protein{$id})){$protein{$id}=$seq;}} ## other isoforms of the last gene; longest isoform
else{$protein{$id}=$seq;} ## first isoform of the last gene

my $a1=$a2=0; 
while(<INB>)
{
 chomp;
 if(/^(ENSMUSG\d+\_[\w\.\-]+)\s+[\w\.\-]+\s+chr/)
 {
  $a1++;
  if(exists $protein{$1}){$a2++; print OUT ">$1\n$protein{$1}\n"; if($a2%30==0){print OUT "\n\n\n\n\n\n\n\n\n\n\n";}}
 }
 else{print "error2\t$_\n";}
}

print "Total-LongGenes; $a1\tOutput: $a2\n";

close INA; close INB;
close OUT;

