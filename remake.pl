#!/usr/bin/perl -w
# print_line-v1 - linear style

##################################################################################
#
#  1. Create a remakes folder in the job directory
#
#  2. Copy the required output file to the remakes directory
#
#  3. copy build_reprint_file_simple.pl from S:\admin\programming\remakes\
#     to your job\remakes folder
#
#  4. Create a text file called 'remake_list.txt'
#
#  5. type in the record numbers that you want to
#     reprint, 1 record per line
#
#  6. Open a command window (Start->Run... 'cmd') and cd to the remake folder
#
#  7. run 'perl build_reprint_file_simple.pl <Your_File_Name.txt>
#
#  8. The programme will create a remakes file called 
#     <Your_File_Name.txt>_remakes.txt
#
##################################################################################

$infile = $ARGV[0];

$remake_file = 'remake.txt';

$outfile = ">".$infile;
$outfile .= "_remakes.txt";

open(RMKFILE, "< $remake_file") or die "Can't open $remake_file for reading: $!\n";
@line_numbers = <RMKFILE>;

open(OUTFILE, "$outfile") ||
    die "cannot open $outfile: $!";

open(INFILE, "< $infile") or die "Can't open $infile for reading: $!\n";

$line_number = '';
my $field_headings = 0;
while (<INFILE>) {
	$line = $_;
	$x = 0;

	if($field_headings == 0){
		#Field headings
		print OUTFILE "$_";
		$field_headings = 1;
	}

	foreach(@line_numbers){
		$line_number = $line_numbers[$x]+1;
		if($. == $line_number){
			print OUTFILE $line;
		}
		$x++;
	}
}

close(INFILE);
close(OUTFILE);
close(RMKFILE);

