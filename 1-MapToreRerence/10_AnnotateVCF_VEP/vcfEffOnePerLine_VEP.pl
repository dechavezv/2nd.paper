#!/usr/bin/perl

#-------------------------------------------------------------------------------
#
# Read a VCF file (via STDIN), split CSQ fields from INFO column into many lines
# leaving one line per csqect.
#
# Note: In lines having multiple csqects, all other information will be 
#       repeated. Only the 'CSQ' field will change.
#
#															Pablo Cingolani 2012
#-------------------------------------------------------------------------------

$INFO_FIELD_NUM = 7;

while( $l = <STDIN> ) {
	# Show header lines
	if( $l =~ /^#/ ) { print $l; }	
	else {
		chomp $l;

		@t = @infos = @csqs = (); # Clear arrays

		# Non-header lines: Parse fields
		@t = split /\t/, $l;

		# Get INFO column
		$info = $t[ $INFO_FIELD_NUM ];

		# Parse INFO column 
		@infos = split /;/, $info;

		# Find CSQ field
		$infStr = "";
		foreach $inf ( @infos ) {
			# Is this the CSQ field? => Find it and split it
			if( $inf =~/^CSQ=(.*)/ ) { @csqs = split /,/, $1; }
			else { $infStr .= ( $infStr eq '' ? '' : ';' ) . $inf; }
		}	

		# Print VCF line
		if( $#csqs <= 0 )	{ print "$l\n"; }	# No CSQ found, just show line
		else {
			$pre = "";
			for( $i=0 ; $i < $INFO_FIELD_NUM ; $i++ ) { $pre .= ( $i > 0 ? "\t" : "" ) . "$t[$i]"; }

			$post = "";
			for( $i=$INFO_FIELD_NUM+1 ; $i <= $#t ; $i++ ) { $post .= "\t$t[$i]"; }

			foreach $csq ( @csqs ) { print $pre . "\t" . $infStr . ( $infStr eq '' ? '' : ';' ) . "CSQ=$csq" . $post . "\n" ; }
		}
	}
}
