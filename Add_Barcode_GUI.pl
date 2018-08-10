use Win32::GUI();
use Win32::GUI::DropFiles();

my $DOS = Win32::GUI::GetPerlWindow();
Win32::GUI::Hide($DOS);

my $INPUTFILE;

$main = Win32::GUI::Window->new(
	-name => 'Main', 
	-text => 'MAILING SOLUTIONS',
    -width => 300, 
	-height => 470,
	-acceptfiles => 1,
	-onDropFiles => \&dropfiles_callback,
	-maxsize => [300,470],
	-minsize => [300,470],
#	-style    => WS_MINIMIZEBOX | WS_SYSMENU | WS_NORESIZE,
);




# Define the "Process Complete" window
$done = Win32::GUI::Window->new(
	-name => 'Done', 
	-text => 'PROCESS COMLETE',
    -width => 150, 
	-height => 150,
	-parent => $main,
	-maxsize => [150,150],
	-minsize => [150,150],
);
$done->AddButton(
                -name => "DoneButton",
                -text => "DONE",
                #-pos  => [ 10, 10 ],
);
sub DoneButton_Click { return -1; }
sub DoneButton_Terminate { return -1; }



$LEFT_MARGIN = 20;
$V_OFFSET = 40;

$ncw = $main->Width();
$nch = $main->Height();
$w = $ncw;
$h = $nch;

$font = Win32::GUI::Font->new(
            -name => "Arial", 
            -size => 12,
    );

$label1 = $main->AddLabel(
            -text => 'ADD BARCODE',
            -font => $font,
            -foreground => [0, 142, 173],
			-left => 85,
);

$label2 = $main->AddLabel(
            -text => '(Drop data file here)',
            -font => $font,
            -foreground => [0, 0, 0],
			-pos => [75, 30],
);

#########################################
#
# Option 1: Envelope Size
$label3 = $main->AddLabel(
            -text => 'Envelope Size',
            -font => $font,
            -foreground => [0, 0, 0],
			-pos => [$LEFT_MARGIN, 30+$V_OFFSET],
);

$main->AddCheckbox(
    -name     => 'Chk1',
    -text     => "DL / DLX",
    -disabled => 0,
	-pos => [$LEFT_MARGIN, 50+$V_OFFSET],
) or die "Chk1";

$main->AddCheckbox(
    -name     => 'Chk2',
    -text     => "C4",
    -disabled => 0,
	-pos => [$LEFT_MARGIN, 70+$V_OFFSET],
) or die "Chk2";

# Removed Simplex / Duplex selection. We set this in the Connect DataMapper now.
#$main->AddCheckbox(
#    -name     => 'Plex_Chk',
#    -text     => "Duplex?",
#    -disabled => 0,
#	-pos => [$LEFT_MARGIN, 100+$V_OFFSET],
#    -font => $font,
#) or die "Plex_Chk";


$main->Chk1->SetCheck(2);


#########################################
#
# Option 2: Number of pages
$label4 = $main->AddLabel(
            -text => 'Number of pages',
            -font => $font,
            -foreground => [0, 0, 0],
			-pos => [$LEFT_MARGIN+120, 30+$V_OFFSET],
);

$main->AddCombobox(     
        -name   => "combo_box1",
        -width  => 40,
        -height => 40,
        #-tabstop=> 1,
        -pos => [$LEFT_MARGIN+120, 50+$V_OFFSET],
        -dropdownlist=> 0,
);

$main->combo_box1->InsertItem("1"); $main->combo_box1->InsertItem("2");
$main->combo_box1->InsertItem("3"); $main->combo_box1->InsertItem("4");
$main->combo_box1->InsertItem("5"); $main->combo_box1->InsertItem("6");
$main->combo_box1->InsertItem("7"); $main->combo_box1->InsertItem("8");
$main->combo_box1->InsertItem("9"); $main->combo_box1->InsertItem("10");

$main->combo_box1->Select("0");

#########################################
#
# Personalised Insert Selection
$label5 = $main->AddLabel(
            -text => 'Personalised Inserts',
            -font => $font,
            -foreground => [0, 0, 0],
			-pos => [$LEFT_MARGIN, 140+$V_OFFSET],
);

$main->AddCheckbox(
    -name     => 'P1_Chk',
    -text     => "Personalised in Hopper 1",
    -disabled => 0,
	-pos => [$LEFT_MARGIN, 160+$V_OFFSET],
) or die "P1_Chk";

$main->AddCheckbox(
    -name     => 'P2_Chk',
    -text     => "Personalised in Hopper 2",
    -disabled => 0,
	-pos => [$LEFT_MARGIN, 180+$V_OFFSET],
) or die "P2_Chk";


#########################################
#
# Selective Insert Selection
$label6 = $main->AddLabel(
            -text => 'Selective Inserts',
            -font => $font,
            -foreground => [0, 0, 0],
			-pos => [$LEFT_MARGIN, 230+$V_OFFSET],
);

$main->AddCheckbox(
    -name     => 'H1_Chk',
    -text     => "Hopper 1",
    -disabled => 0,
	-pos => [$LEFT_MARGIN, 250+$V_OFFSET],
) or die "H1_Chk";

$main->AddCheckbox(
    -name     => 'H2_Chk',
    -text     => "Hopper 2",
    -disabled => 0,
	-pos => [$LEFT_MARGIN, 270+$V_OFFSET],
) or die "H2_Chk";

$main->AddCheckbox(
    -name     => 'H3_Chk',
    -text     => "Hopper 3",
    -disabled => 0,
	-pos => [$LEFT_MARGIN, 290+$V_OFFSET],
) or die "H3_Chk";


$main->AddCheckbox(
    -name     => 'H4_Chk',
    -text     => "Hopper 4",
    -disabled => 0,
	-pos => [$LEFT_MARGIN+120, 250+$V_OFFSET],
) or die "H4_Chk";

$main->AddCheckbox(
    -name     => 'H5_Chk',
    -text     => "Hopper 5",
    -disabled => 0,
	-pos => [$LEFT_MARGIN+120, 270+$V_OFFSET],
) or die "H5_Chk";

$main->AddCheckbox(
    -name     => 'H6_Chk',
    -text     => "Hopper 6",
    -disabled => 0,
	-pos => [$LEFT_MARGIN+120, 290+$V_OFFSET],
) or die "H6_Chk";



#########################################
#
# Apply current selections to data file
$main->AddButton(
    -name     => 'BUT',
    -text     => "APPLY",
    -disabled => 1,
    -onClick  => \&add_barcode,
    -tabstop  => 1,
) or die "Button";

$main->BUT->Left( (300/2) - ($main->BUT->Width()/2) );
$main->BUT->Top(330+$V_OFFSET);

$desk = Win32::GUI::GetDesktopWindow();

$dw = Win32::GUI::Width($desk);
$dh = Win32::GUI::Height($desk);
$x = ($dw - $w) / 2;
$y = ($dh - $h) / 2;

my $sb = $main->AddStatusBar();
$sb->Text( "File name: No file loaded..." );

$main->Resize($w,$h);
$main->Move($x,$y);

$main->Show();

$done->Resize($w,$h);
$done->Move($x,$y);


#########################################
#
# Only move on to Dialog phase after
# we've finished creating all our windows
# and controls
Win32::GUI::Dialog();

Win32::GUI::Show($DOS);

exit(0);


sub Main_Terminate {
    return -1;
}

sub Chk1_Click {
	$main->Chk1->SetCheck(1);
	$main->Chk2->SetCheck(0);
	return 0;
}

sub Chk2_Click {
	$main->Chk1->SetCheck(0);
	$main->Chk2->SetCheck(1);
	return 0;
}

sub P1_Chk_Click {
	$main->H1_Chk->SetCheck(0);
	return 0;
}

sub P2_Chk_Click {
	$main->H2_Chk->SetCheck(0);
	return 0;
}

sub H1_Chk_Click {
	$main->P1_Chk->SetCheck(0);
	return 0;
}

sub H2_Chk_Click {
	$main->P2_Chk->SetCheck(0);
	return 0;
}



# In the DropFiles callback
sub dropfiles_callback {
  my ($self, $dropObj) = @_;

  # Get the number of dropped files
  my $count = $dropObj->GetDroppedFiles();

  # Get a list of the dropped file names
  my @files = $dropObj->GetDroppedFiles();

  # Get a particular file name (0 based index)
  my $file  = $dropObj->GetDroppedFile($count-1);
  
  # determine if the drop happened in the client or
  # non-client area of the window
#  my $clientarea = $dropObj->GetDropPos();

  # get the mouse co-ordinates of the drop point,
  # in client co-ordinates
#  my ($x, $y) = $dropObj->GetDropPos();

  # get the drop point and (non-)client area information
#  my ($x, $y, $client) = $dropObj->GetDropPos();

	#Show dropped file name in status bar (remove leading directory path)
	my $short_name = $file;
	$short_name =~ s{^.*\\}{  };
	$sb->Text( "File name: " . $short_name );
	$label2->Text( "FILE LOADED" );
    $label2->Left(90);
    $label2->Top(30);

	$main->BUT->Enable(1);

	$INPUTFILE = $file;

  return 0;
}


sub add_barcode{

	#This is where we basically replicate the functionality of the old Add_Barcode script
	#Input file name is in $INFILE
	
	my $i, $num_pages, $env_size;
	my $p1, $p2, $h1, $h2, $h3, $h4, $h5, $h6;
#	my $plex;
	
	$p1 = "NO";
	$p2 = "NO";
	$h1 = "NO";
	$h2 = "NO";
	$h3 = "NO";
	$h4 = "NO";
	$h5 = "NO";
	$h6 = "NO";
#	$plex = "SIMPLEX";
	
	$i = $main->combo_box1->GetCurSel();
	$num_pages = $main->combo_box1->GetString($i);

	if( $main->Chk1->Checked() == 1 ){
		$env_size = "DLX";
	}
	else{
		$env_size = "C4";
	}

	if( $main->P1_Chk->Checked() == 1 ){ $p1 = "YES"; }
	if( $main->P2_Chk->Checked() == 1 ){ $p2 = "YES"; }
	if( $main->H1_Chk->Checked() == 1 ){ $h1 = "YES"; }
	if( $main->H2_Chk->Checked() == 1 ){ $h2 = "YES"; }
	if( $main->H3_Chk->Checked() == 1 ){ $h3 = "YES"; }
	if( $main->H4_Chk->Checked() == 1 ){ $h4 = "YES"; }
	if( $main->H5_Chk->Checked() == 1 ){ $h5 = "YES"; }
	if( $main->H6_Chk->Checked() == 1 ){ $h6 = "YES"; }

#	if( $main->Plex_Chk->Checked() == 1 ){ $plex = "DUPLEX"; }

	
####################################################################
# At this point we have all the parameters for generating our
# VAF barcodes.
# If any of the hoppers have been set as selective and/or 
# personalised then we need to check that there is a matching 
# field defined in the data file.

# Get input file
	$INPUTFILE =~ s/\\/\//g;
	my $infile = "<".$INPUTFILE;
	open($INFILE_FH, $infile) || die "cannot open $infile: $! for reading";

# define output file naming
	$outfile = ">".$INPUTFILE;
	$outfile =~ s/SORTED/OUTPUT/ig;
	$outfile =~ s/\.txt//ig;
	$outfile .= "_".$env_size."_intel.txt";
	open($OUTFILE_FH, $outfile) || die "cannot open $outfile: $! for writing";
	
	if($p1 =~ /YES/i){
		$p1file = ">".$INPUTFILE;
		$p1file =~ s/SORTED FILE/BARCODE FILE/ig;
		$p1file =~ s/\.txt//ig;
		$p1file .= "_Hopper_1.txt";
		open($P1FILE_FH, $p1file) || die "cannot open $p1file: $! for writing";
		printf "\n\n$p1file\n\n";
	}

	if($p2 =~ /YES/i){
		$p2file = ">".$INPUTFILE;
		$p2file =~ s/SORTED FILE/BARCODE FILE/ig;
		$p2file =~ s/\.txt//ig;
		$p2file .= "_Hopper_2.txt";
		open($P2FILE_FH, $p2file) || die "cannot open $p2file: $! for writing";
	}

	@p1_lines = ( );
	@p2_lines = ( );

	$set_count = 0;
	$inline = "";
	while (<$INFILE_FH>) {					# process every line in the data file
		chomp;
		$inline = $_;
		$index = 0;

	#	print "\n\nSet Count = $set_count\t\tNum Pages = $num_pages\t\tIndex = $index\n\n";
		
		if($set_count == 0){										# Print header line to file
			print $OUTFILE_FH "$_";
			print $OUTFILE_FH "\tHopper_Selection";					#Add a new field to list hopper selections for use in OL Connect
			if($env_size =~ /C4/i){
				while($index < $num_pages){					# Print C4 headers
					$index++;
					print $OUTFILE_FH "\tPage$index\_Barcode";
				}
			}
			else{
				my $barcode_count = $num_pages;
				while($index < $num_pages){					# Print DL/DLX/C5 headers
					$index++;
					print $OUTFILE_FH "\tPage$barcode_count\_Barcode";
					$barcode_count--;
				}
			}
			print $OUTFILE_FH "\n";
			$index = 0;

			# save headings for printing to barcode files later
			#if($p1 =~ /YES/i){ print $P1FILE_FH "Hopper 1 Barcode\t$_\n"; }
			#if($p2 =~ /YES/i){ print $P2FILE_FH "Hopper 2 Barcode\t$_\n"; }
			#if($p1 =~ /YES/i){ push(@p1_lines, "Hopper 1 Barcode\t$_" ); }
			#if($p2 =~ /YES/i){ push(@p2_lines, "Hopper 2 Barcode\t$_" ); }
			$p1_field_headings = "Hopper 1 Barcode\tHopper_Selection\t$_";
			$p2_field_headings = "Hopper 2 Barcode\tHopper_Selection\t$_";
			
			
			# Check whether or not selective / personalised options have been specified
			# If they have we need to grab the location of those fields in the data

			@fields = split(/\t/, $_);								#split record line in to seperate fields
			my $n = 0;
			foreach my $heading (@fields) {
				if($heading =~ /P1/i){ $p1_offset = $n; }
				if($heading =~ /P2/i){ $p2_offset = $n; }
				if($heading =~ /H1/i){ $h1_offset = $n; }
				if($heading =~ /H2/i){ $h2_offset = $n; }
				if($heading =~ /H3/i){ $h3_offset = $n; }
				if($heading =~ /H4/i){ $h4_offset = $n; }
				if($heading =~ /H5/i){ $h5_offset = $n; }
				if($heading =~ /H6/i){ $h6_offset = $n; }
				$n++;
			}
			if ( (! defined $p1_offset) && ($p1 =~ /YES/) ){ die "\n\n*ERROR* Personalised insert 1 selected in config but no P1 field in data file.\n\n"};
			if ( (! defined $p2_offset) && ($p2 =~ /YES/) ){ die "\n\n*ERROR* Personalised insert 2 selected in config but no P2 field in data file.\n\n"};
			if ( (! defined $h1_offset) && ($h1 =~ /YES/) ){ die "\n\n*ERROR* Selective insert 1 selected in config but no H1 field in data file.\n\n"};
			if ( (! defined $h2_offset) && ($h2 =~ /YES/) ){ die "\n\n*ERROR* Selective insert 2 selected in config but no H2 field in data file.\n\n"};
			if ( (! defined $h3_offset) && ($h3 =~ /YES/) ){ die "\n\n*ERROR* Selective insert 3 selected in config but no H3 field in data file.\n\n"};
			if ( (! defined $h4_offset) && ($h4 =~ /YES/) ){ die "\n\n*ERROR* Selective insert 4 selected in config but no H4 field in data file.\n\n"};
			if ( (! defined $h5_offset) && ($h5 =~ /YES/) ){ die "\n\n*ERROR* Selective insert 5 selected in config but no H5 field in data file.\n\n"};
			if ( (! defined $h6_offset) && ($h6 =~ /YES/) ){ die "\n\n*ERROR* Selective insert 6 selected in config but no H6 field in data file.\n\n"};
		}


		else{

			@fields = split(/\t/, $_);								#split record line in to separate fields
			$selective_insert_string = "";
	#		if( (($p1 =~ /YES/)||($h1 =~ /YES/)) && ( (@fields[$p1_offset] =~ /x/i) || (@fields[$h1_offset] =~ /x/i) ) ){ $selective_insert_string .= "1"; }
	#		if( (($p2 =~ /YES/)||($h2 =~ /YES/)) && ( (@fields[$p2_offset] =~ /x/i) || (@fields[$h2_offset] =~ /x/i) ) ){ $selective_insert_string .= "2"; }

			if( (($h1 =~ /YES/) && (@fields[$h1_offset] =~ /x/i)) || (($p1 =~ /YES/) && (@fields[$p1_offset] =~ /x/i)) ){ $selective_insert_string .= "1"; }
			if( (($h2 =~ /YES/) && (@fields[$h2_offset] =~ /x/i)) || (($p2 =~ /YES/) && (@fields[$p2_offset] =~ /x/i)) ){ $selective_insert_string .= "2"; }

			if( ($h3 =~ /YES/) && (@fields[$h3_offset] =~ /x/i) ){ $selective_insert_string .= "3"; }
			if( ($h4 =~ /YES/) && (@fields[$h4_offset] =~ /x/i) ){ $selective_insert_string .= "4"; }
			if( ($h5 =~ /YES/) && (@fields[$h5_offset] =~ /x/i) ){ $selective_insert_string .= "5"; }
			if( ($h6 =~ /YES/) && (@fields[$h6_offset] =~ /x/i) ){ $selective_insert_string .= "6"; }
		
			if( ($p1 =~ /YES/i) && (@fields[$p1_offset] =~ /x/i) ){
				$p1_count++;
				push @p1_lines, sprintf "\*S%06d\*\t%s\t%s",$set_count,$selective_insert_string,$_;
			}
			if( ($p2 =~ /YES/i) && (@fields[$p2_offset] =~ /x/i) ){
				$p2_count++;
				push @p2_lines, sprintf "\*S%06d\*\t%s\t%s",$set_count,$selective_insert_string,$_;
			}
		
			while($index < $num_pages){
				if($num_pages == 1){														# Single page mailpack (easy!)
					printf $OUTFILE_FH "$_\t$selective_insert_string\t\*S%06d%sQ%03d\*",$set_count,$selective_insert_string,$num_pages;
				}
				else{
					if($index == 0){															# Print Multi-page set
						# Print Master Page
						printf $OUTFILE_FH "$_\t$selective_insert_string\t\*M%06d%sQ%03d\*",$set_count,$selective_insert_string,$num_pages;
					}
					elsif($index == $num_pages - 1){
						# Print Last Page
						printf $OUTFILE_FH "\t\*L%06d\*",$set_count;
					}
					else{
						# Print Intermediate Page
						printf $OUTFILE_FH "\t\*I%06d%02d\*",$set_count,$index;
					}
				}
				$index++;
			}
			print $OUTFILE_FH "\n";
		}
		$set_count++;
	}

	# Print records to separate barcode file in reverse order
	if( ($p1 =~ /YES/i) && (@fields[$p1_offset] =~ /x/i) ){
		print $P1FILE_FH "$p1_field_headings\n";
		while ($line = pop @p1_lines){
			print $P1FILE_FH "$line\n";
		}
	}
	if( ($p2 =~ /YES/i) && (@fields[$p2_offset] =~ /x/i) ){
		print $P2FILE_FH "$p2_field_headings\n";
		while ($line = pop @p2_lines){
			print $P2FILE_FH "$line\n";
		}
	}
	
	close( $OUTFILE_FH );
	close( $INFILE_FH );
	close( $P1FILE_FH );
	close( $P2FILE_FH );
	
	$done->DoModal();

	return 0;
}
