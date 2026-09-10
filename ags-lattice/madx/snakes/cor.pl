#!/usr/bin/perl


$dirin = "WSNK_B1.53";

opendir(DIR, "./$dirin");
@files = grep(//, readdir(DIR));


closedir(DIR);

$dirout = $dirin . "_cor";

$g = 25;


foreach $file (@files)
  {
    #print "IN LOOP $file\n";


    open(IN, "<$dirin/$file");
    open(OUT, ">$dirout/$file");

    #print "$dirout/$file\n";


    print "$file\n";

    while($line = <IN>)
      {

        $line =~ s/WSNK_MAT/WSNK/;

        print OUT $line;

      }


    close IN;
    close OUT;





  }
