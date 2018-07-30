#!/usr/bin/perl

use strict;

my $flag = shift(@ARGV) or die "Zero Flags Given!! Try ./tf2.pl vel\n";

my $filecounter;
my $linecounter;

my $datadir = "../StatBallistics/";

my $files =  `find . |grep -U -a "Track.csv"`;

my $OF = "output.tsv";

my @filelines = split /\n/, $files;

print "I am about to process $#filelines file(s)\n";
print "Ok? (Y/n): ";
my $ok = <STDIN>;
if ($ok =~ /n/) { die "killed.\n"; }
if ($ok =~ /p/) { foreach my $elm (@filelines) { $elm =~ s/\r\n\z//; print "$elm\n"; } }

my $IF;
my %ShotSeries;

while ($IF = shift @filelines)
 {
   $IF =~ s/\r\n\z//; #Cuts all the extra BS
   #my $OF = shift; #this may not be used, not sure yet, lets see about printing data structures first

   open(IF, "$IF") || die "Couldn't open $IF\n";
   #print "Opened $IF\n";
   my($dev,$series,$shot);
   my @lines;
   my %points; #this is a hash that points to an array of data identified as {$dev-$series-$shot}
 
   while (my $line = <IF>)
    {
      $line =~ s/\r\n\z//;
      my @linejunk = split /;/, $line;
      if ($line =~ /^Device/) 	{ $dev = $linejunk[1]; }
      if ($line =~ /^Series/) 	{ $series = $linejunk[1]; }
      if ($line =~ /^Shot/)   	{ $shot = int($linejunk[1]); } 
      if ($line =~ /^\d/)		{ push @lines, $line; }
	  $linecounter++;
    }
	
   
   
   
  foreach my $elm (@lines)
    {
     my ($time,$vel,$dist,$snr) = split /;/,$elm;
	 if ($flag =~ /snr/) { $ShotSeries{$series}{$time}[$shot] = $snr; }
	 if ($flag =~ /vel/) { $ShotSeries{$series}{$time}[$shot] = $vel; }
	 if ($flag =~ /dist/) { $ShotSeries{$series}{$time}[$shot] = $dist; }
     #print "$time $ShotSeries{$series}{$time}[$shot]\n";
    }
   $filecounter++;
   
 }
 
 foreach my $elm (sort keys(%ShotSeries))
  { 
   my $filename = $datadir . "$flag-" . $elm . ".csv";
   open(OF, ">", $filename);
   print "Processing Series $elm\n";
   print OF "Time(s)\tShot 1\tShot 2\tShot 3\tShot 4\tShot 5\tShot 6\tShot 7\tShot 8\tShot 9\tShot 10\tShot 11\tShot 12\tShot 13\tShot 14\tShot 15\tShot 16\tShot 17\tShot 18\tShot 19\tShot 20\n";
   foreach my $time (sort keys(%{$ShotSeries{$elm}}))
    {
	 print OF "$time";
	 for (my $i = 1; $i < 20; $i++)
	  {
	   print OF "\t$ShotSeries{$elm}{$time}[$i]";
	  }
	  print OF "\n";
	}
   close(OF);
  }
 

#close(OF) ;
print "I processed $linecounter lines from $filecounter file(s)\n\n";
