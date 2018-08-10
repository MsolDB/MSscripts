#!/usr/bin/perl Ðw




#------------------------------oOo------------------------------
#
# Date:        15/03/2018
#
# Changes:     Updated to work with new 
#              PrintPost rules being introduced 
#              on Monday 19/03/2018
#
# Description: 
#              Slipsheet allocation
#              New slipsheet on Product change (R|A|P)
#              RESIDUE         - New slipsheet on STATE change
#              AREA DIRECT     - New slipsheet on BSP change
#              POSTCODE DIRECT - New slipsheet on postcode change
#              
#              No longer requires separate scripts
#              for LH and non-LH jobs.
#              
#------------------------------oOo------------------------------



#----------------oOo----------------
# Setup constants

$infile = $ARGV[0];

$outfile = ">".$infile;
$outfile =~ s/SORTED/OUTPUT/g;
$outfile =~ s/\.txt//ig;
$outfile .= "_slipsheet.txt";

$line_count  = 0;

my $field_count;
my $field_contents;
my $converted_amount;
$field_count = 1;

open(OUTFILE, "$outfile") ||
    die "cannot open $outfile: $!";
	
$break_code     = '';
$BSP_Break      = '';
$State_Break    = '';
$Postcode_Break = '';
$Product_Break  = '';
$ProductName    = '';

my $overseas_flag = 0;

$pp_sort_type = '';

while (<>) {

    chomp;

	
    $linecount++;
    if($linecount == 1){

		$field_count         = 0;
		$Dt_Sort_Code_offset = 0;

		@fields = split(/\t/, $_);
		foreach $field_name (@fields) {
			if( ($field_name =~ /Dt PP Sort Code/) || ($field_name =~ /Dt LH Sort Code/) ){
				if( ($field_name =~ /Dt LH Sort Code/) ){
					$pp_sort_type = "LH";
				}else{
					$pp_sort_type = "PP";
				}
				$Dt_Sort_Code_offset = $field_count;
			}
			if($field_name =~ /Address Line 1/){
				$Address_offset = $field_count;
			}
			$field_count++;
		}
		print OUTFILE "$_\tMediaSelect\n";
		print "\n\nDt Sort Code is in field $Dt_Sort_Code_offset\n\n";
    }
    else{

		@fields = split(/\t/, $_);							#Extract Sort Code field
		$Dt_Sort_Code = $fields[$Dt_Sort_Code_offset];
		$Dt_Sort_Code =~ s/\"//g;

		if($Dt_Sort_Code =~ /^xOTHER$/ || $Dt_Sort_Code =~ /^[0-9]{3}_xOTHER$/){
			$overseas_flag = 1;
		}

		@Sort_Code = split(/_/,$Dt_Sort_Code);				#Extract elements from Sort Code field

#Fix change (BUG) introduced in DataTools update 467 - Mon 19/03/2018 (removed 1 field from start of sort code
		if($overseas_flag == 1){
			$Product  = "I";
			$BSP      = "";
			$State    = "";
			$Postcode = "";
		}
		elsif($pp_sort_type =~ /LH/){
			$Product  = $Sort_Code[5];
			$BSP      = $Sort_Code[2];
			$State    = $Sort_Code[1];
			$Postcode = $Sort_Code[4];
		}else{
			$Product  = $Sort_Code[4];
			$BSP      = $Sort_Code[1];
			$State    = $Sort_Code[0];
			$Postcode = $Sort_Code[3];
		}

#		print"\n\n$Product\n$BSP\n$State\n$Postcode\n\n";
		
		if( ($Product !~ $Product_Break) || 
		  ( ($Product =~ /P/) && ($Postcode !~ $Postcode_Break) ) || 
		  ( ($Product =~ /A/) && ($BSP !~ $BSP_Break) ) || 
		  ( ($Product =~ /R/) && ($State !~ $State_Break) ) ){

			if($Product eq "I"){
				$tabs = ( "\t" x $Address_offset );
				print OUTFILE $tabs;
				$tabs = ( "\t" x ($field_count-$Address_offset) );
				print OUTFILE "International".$tabs."Sort Break\n";
			}
			else{
				if   ($Product =~ /P/){ $ProductName = "Postcode Direct - ".$Postcode; }
				elsif($Product =~ /A/){ $ProductName = "Area Direct - ".$BSP; }
				elsif($Product =~ /R/){ $ProductName = "Residue - ".$State; }

				$tabs = ( "\t" x $Address_offset );
				print OUTFILE $tabs;
				$tabs = ( "\t" x ($field_count-$Address_offset) );
				print OUTFILE $ProductName.$tabs."Sort Break\n";
			}
		}
		else{
			#error
		}

		print OUTFILE "$_\t\n";

		$break_code     = $Dt_Sort_Code;
		$BSP_Break      = $BSP;
		$State_Break    = $State;
		$Postcode_Break = $Postcode;
		$Product_Break  = $Product;
		$overseas_flag  = 0;
	}
}

$linecount--;
print "\n\n$linecount records processed...\n\n";

close(OUTFILE);
