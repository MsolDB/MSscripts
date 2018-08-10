#!/usr/bin/perl -w
# print_line-v1 - linear style


###############################################################
#
# Version: 3 - Name changed from PPClean to datafix to
#              reflect more general purpose nature of script
#
# Purpose: Remove any CR or LF characters that are embedded
#          in a data record. Leave trailing CRLF unaltered.
#
# Method:  - Read line, strip CRLF and store in output buffer
#          - Read next line, if starts with "A"<TAB> then
#            write output buffer + CRLF, else write output
#            buffer with no CRLF (it was a split line). Store
#            current line in output buffer.
#          - Repeat until EOF.
#          - Write last line.
#
###############################################################


$infile = $ARGV[0];

$outfile = ">".$infile;
open(INFILE, "< $infile") or die "Can't open $infile for reading: $!\n";

#$outfile .= "_fixed.txt";
$outfile =~ s/\.txt/_fixed\.txt/ig;
open(OUTFILE, "$outfile") ||
    die "cannot open $outfile: $!";

my $field_headings = 0;
my $line = "";
my $output_buffer = "";

while (<INFILE>) {
	$line = $_;
	$found = 0;
	
	chomp($line);																	#Remove trailing CRLF - Any remaining Cr or LF characters within the line will be replaced with spaces

	if($field_headings == 0){
		#Field headings
		print OUTFILE $line."\n";														#Write out the headings
		$field_headings = 1;
	}
	else{
		$line =~ s/\n/ /ig;															#Replace CRLF with space
		$line =~ s/\x0D/ /ig;														#Replace CR with space
		$line =~ s/\x0A/ /ig;														#Replace LF with space
		
		if($line =~ /^A\x09/){														#Look for the letter A followed by <TAB> at the start of the line
			if($output_buffer =~ /\w/){ print OUTFILE $output_buffer."\n"; }		#Only write out the line if it contains [0..9], [a..z] or [A..Z] characters - no empty lines
		}
		else{
			if($output_buffer =~ /\w/){ print OUTFILE $output_buffer; }
		}
		$output_buffer = $line;
	}
}

#Write last line
if($line =~ /^A\x09/){																				#Look for the letter A followed by <TAB> at the start of the line
	if($output_buffer =~ /\w/){ print OUTFILE $output_buffer."\n"; }else{ print OUTFILE "\n"; }		#Only write out the line if it contains [0..9], [a..z] or [A..Z] characters - no empty lines
}
else{
	if($output_buffer =~ /\w/){ print OUTFILE $output_buffer; }else{ print OUTFILE "\n"; }
}

close(INFILE);
close(OUTFILE);
