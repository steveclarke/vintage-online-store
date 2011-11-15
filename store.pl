#! /usr/bin/perl.old

do "/home/httpd/cgi-bin/cgi-lib.pl" || die "Error finding library file.";

&ReadParse;

# Assign process id.
$pid = $$;

# Get QUERY STRING from document.
$options = $ENV{QUERY_STRING};

# Parse $options for values.
($area_np, $process_np, $value_np, $pn_np, $memberid_np) = split (/&/, $options);

# Get command line values. 
($toss ,$area) = split (/=/, $area_np);
($toss, $process) = split (/=/, $process_np);
($toss, $value) = split (/=/, $value_np);
($toss, $pn) = split (/=/, $pn_np);
($toss, $memberid) = split (/=/, $memberid_np);

# Assign memberid from form.
if ($in{'memberid'}) {
	$memberid = $in{'memberid'};
}

# go to proper area and find the value for the area
if ($area eq "1") {
	&value;
	&store;
} elsif ($area eq "2") {
	$filename = "accessories.pri";
	&value;	
	&accessories;
} elsif ($area eq "3") {
	$filename = "components.pri";
	&value;
	&components;
} elsif ($area eq "4") {
	$filename = "computers.pri";
	&value;
	&computers;
} elsif ($area eq "5") {
	$filename = "peripherals.pri";
	&value;
	&peripherals;
} elsif ($area eq "6") {
	$filename = "magazines.pri";
	&value;
	&magazines;
} elsif ($area eq "7") {
	$filename = "software.pri";
	&value;
	&software;
} elsif ($area eq "8") {
	$filename = "service.pri";
	&value;
	&service;
} elsif ($area eq "9") {
	$filename = "whats_new.pri";
	&value;
	&whats_new;
} elsif ($area eq "10") {
	&value;
	&memberid;
} elsif ($area eq "11") {
	&verify_order;
} elsif ($area eq "12") {
	&order;
} elsif ($area eq "13") {
	&value;
	&checkout;
} elsif ($area eq "14") {
	&value;
	&grand_opening;
}

sub value {
	if ($value eq "buy") {
		&buy;
	} elsif ($value eq "remove") {
		&remove;
	} elsif ($value eq "refresh") {
		&refresh_basket;
	} elsif ($value eq "search") {
		&search;
	} elsif ($value eq "bdc") {
		&bdc;
	} elsif ($value eq "terms") {
		&terms;
	} elsif ($value eq "onform") {
		&online_form;
	} elsif ($value eq "form") {
		&membership_form;
	} elsif ($value eq "sendform") {
		&send_form;
	} elsif ($value eq "tryagain") {
		&tryagain;
	} elsif ($value eq "shipping") {
		&shipping;
	}
}

sub store {
	print "Content-type: text/html\n\n";
	print "<HTML>\n";
	print "<HEAD><TITLE>Avalon Software - Internet Store</TITLE></HEAD>\n";
	print "<BODY BGCOLOR=#FFFFFF>\n";
	print "<P ALIGN=CENTER><IMG SRC=\"/avalon/gifs/avalon_logo.gif\"\n";
	print "ALT=\"AVALON SOFTWARE & COMPUTERS INC.\"></P>\n";
	print "<CENTER><IMG SRC=\"/avalon/gifs/internet_store.gif\"></CENTER>\n";
	print "<P ALIGN=CENTER>22 O'Leary Ave, St. John's, Newfoundland, Canada A1B 2C7<BR>\n";
	print "<B>Phone:</B> (709) 739-0739  <B>Fax:</B> (709) 739-1739\n";
	print "<B>Email:</B><A HREF=\"mailto:info@avalon.nf.ca\"> info@avalon.nf.ca</A></P>\n";
	print "<HR>\n";
	print "<center><H1>Important Notice:</H1>\n";
	print "Our store is currently offline as pricing is being updated...<br>\n";
	print "We apologize for any inconvenience.</center>\n";
	print "<HR>\n";
	# Check and see if this page is being called from a shopping session
	# already running or else it will assign a new process id to an existing
	# session.
	if ($process) {
		$pid = $process;
	}

	print "<CENTER><H3>Welcome to Avalon Software's Internet\n";
	print "Store!</H3></CENTER>\n";
	print "<P>This web page is set up to provide you with the priviledge and convenience of\n";
	print "shopping at our store without ever walking through the doors. Have a look around\n";
	print "at our different departments. To order a particular item, simply click on its <B>BUY</B> tag.\n";
	print "To get information about any of the products listed, click the mail button\n";
	print "found at the bottom of each page to email our sales staff.</P>\n";
	print "<P>Keep in mind that this store is brand new. We are still adding some\n";
	print "products, and you may run into\n";
	print "a glitch here and there. Please send email to <A HREF=\"mailto:webmaster@avalon.nf.ca\">\n";
	print "webmaster@avalon.nf.ca </A> detailing any problems you experience. We\n";
	print "hope this store provides you a valued service, and look forward to\n";
	print "serving you in the future!</P>\n";
	print "<CENTER>\n";
	print "<B>Note: All prices on these pages are in Canadian dollars.</B>\n";
	print "<MAP NAME=store>\n";
	print "<AREA SHAPE=rect HREF=\"/cgi-bin/store?area=7&process=$pid\" COORDS=\"225,42, 435,75\">\n";
	print "<AREA SHAPE=rect HREF=\"/cgi-bin/store?area=2&process=$pid\" COORDS=\"225,81, 435,116\">\n";
	print "<AREA SHAPE=rect HREF=\"/cgi-bin/store?area=8&process=$pid\" COORDS=\"225,121, 436,156\">\n";
	print "<AREA SHAPE=rect HREF=\"/cgi-bin/store?area=9&process=$pid\" COORDS=\"225,161, 435,196\">\n";
	print "<AREA SHAPE=rect HREF=\"/cgi-bin/store?area=1&process=$pid&value=bdc\" COORDS=\"4,202, 435,235\">\n";
	print "<AREA SHAPE=rect HREF=\"/cgi-bin/store?area=6&process=$pid\" COORDS=\"4,161, 216,195\">\n";
	print "<AREA SHAPE=rect HREF=\"/cgi-bin/store?area=5&process=$pid\" COORDS=\"5,121, 215,155\">\n";
	print "<AREA SHAPE=rect HREF=\"/cgi-bin/store?area=3&process=$pid\" COORDS=\"5,82, 216,115\">\n";
	print "<AREA SHAPE=rect HREF=\"/cgi-bin/store?area=4&process=$pid\" COORDS=\"4,42, 215,75\">\n";
	print "<AREA SHAPE=default HREF=\"/cgi-bin/store?area=1&process=$pid&value=tryagain\">\n";
	print "</MAP>\n";
	print "<IMG SRC=\"/avalon/store.gif\" USEMAP=\"#store\" BORDER=0>\n";
	print "<BR>\n";
	
	# This screen is the only one we use $pid for the process id on.
	# Every other reference is now to $process.
	print "[ <A HREF=\"/cgi-bin/store?area=4&process=$pid\"> Computers</A> |\n";
	print "<A HREF=\"/cgi-bin/store?area=7&process=$pid\"> Software</A> |\n";
	print "<A HREF=\"/cgi-bin/store?area=3&process=$pid\"> Components</A> |\n";
	print "<A HREF=\"/cgi-bin/store?area=2&process=$pid\"> Accessories</A> |\n";
	print "<BR>\n";
	print "[ <A HREF=\"/cgi-bin/store?area=6&process=$pid\"> Magazines</A> |\n";
	print "<A HREF=\"/cgi-bin/store?area=5&process=$pid\"> Peripherals</A> |\n";
	print "<A HREF=\"/cgi-bin/store?area=8&process=$pid\"> Service</A> |\n";
	print "<A HREF=\"/cgi-bin/store?area=9&process=$pid\"> What's New?</A> |\n";
	print "<A HREF=\"/cgi-bin/store?area=$area&process=$pid&value=bdc\"> BDC</A> ]\n";
	print "<HR>\n";
	print "<FONT SIZE=+1>INSTANT PRODUCT SEARCH</FONT><BR>\n";
	print "<FORM METHOD=POST ACTION=\"/cgi-bin/store?area=$area&process=$pid&value=search\">\n";
	print "<INPUT TYPE=text SIZE=30 NAME=search> <INPUT TYPE=submit VALUE=\"Search\"><BR>\n";
	print "<FONT SIZE=-1><I>Type the key word in the above field for an instant search.</I></FONT>\n";
	print "<HR><P>\n";
	print "<A HREF=\"/cgi-bin/store?area=1&process=$pid&value=refresh\">\n";
	print "<IMG SRC=\"/avalon/gifs/viewbasket.gif\" BORDER=0></A>\n";	
	print "<A HREF=\"/cgi-bin/store?area=10&process=$pid\">\n";
	print "<IMG SRC=\"/avalon/gifs/check.gif\" BORDER=0></A><BR>\n";
	print "[ <A HREF=\"/cgi-bin/store?area=1&process=$pid&value=refresh\">View Basket</A> |\n";
	print "<A HREF=\"/cgi-bin/store?area=10&process=$pid\">Checkout</A> ]<P>\n";
	print "</CENTER>\n";
	print "<HR>\n";

	# Note that we don't call &footer here because from here we go back
	# to the home page.
	print "<A HREF=\"/index.html\"><IMG BORDER=0 SRC=\"/avalon/gifs/home.gif\"></A>\n";
	print "<A HREF=\"/index.html\"><IMG BORDER=0 SRC=\"/avalon/gifs/left.gif\"></A>\n";
	print "<A HREF=\"mailto:sales@avalon.nf.ca\"><IMG BORDER=0 SRC=\"/avalon/gifs/mail.gif\"></A>\n";
	print "</BODY></HTML>\n";
	exit;
}

sub accessories {
	&header;
	print "<IMG SRC=\"/avalon/gifs/accessories.gif\">\n";
	print "<P>Welcome to our <B>Accessories Department</B>. Here you'll find a list of\n";
	print "accessories we carry. If the product you're looking\n";
	print "for is not listed, click on the mail button at the bottom of this page\n";
	print "to email our sales staff, and we'll see if we can source it for you.</P>\n";
	print "<P><HR>\n";
	&banner;
	print "<HR><CENTER>\n";
	print "[ <A HREF=\"#Adaptors\">Adaptors</A> |\n";
	print "<A HREF=\"#Cables\">Cables</A> |\n";
	print "<A HREF=\"#Covers\">Covers</A> |\n";
	print "<A HREF=\"#Diskettes\">Diskettes</A> |\n";
	print "<A HREF=\"#Disk Storage\">Disk Storage</A> ]<BR>\n";
	print "[ <A HREF=\"#Gender Changers\">Gender Changers</A> |\n";
	print "<A HREF=\"#Keyboards\">Keyboards</A> |\n";
	print "<A HREF=\"#Mice\">Mice</A> |\n";
	print "<A HREF=\"#Misc\">Misc</A> |\n";
	print "<A HREF=\"#Power Bars & UPS\">Power Bars & UPS</A> ]<BR>\n";
	print "[ <A HREF=\"#Printer Paper\">Printer Paper</A> |\n";
	print "<A HREF=\"#Printer Ribbons / Cartridges\">Printer Ribbons / Cartridges</A> |\n";
	print "<A HREF=\"#Speakers\">Speakers</A> |\n";
	print "<A HREF=\"#Switch Boxes\">Switch Boxes</A> ]<BR>\n";
	print "[ <A HREF=\"#Tape Cartridges\">Tape Cartridges</A> |\n";
	print "<A HREF=\"#Templates\">Templates</A> |\n";
	print "<A HREF=\"#Videos\">Videos</A> ]\n";
	print "</CENTER><HR><P>\n";
	&print_prices;
	&footer;
	exit;
}

sub components {
	&header;
	print "<IMG SRC=\"/avalon/gifs/components.gif\">\n";
	print "<P>Welcome to our <B>Components Department</B>. Here you'll find a list of\n";
	print "components we carry. If the product you're looking\n";
	print "for is not listed, click on the mail button at the bottom of this page\n";
	print "to email our sales staff, and we'll see if we can source it for you.</P>\n";
	print "<P><HR>\n";
	&banner;
	print "<HR><CENTER>\n";
	print "[ <A HREF=\"#Motherboards\">Motherboards</A> |\n";
	print "<A HREF=\"#Processors\">Processors</A> |\n";
	print "<A HREF=\"#RAM\">RAM</A> |\n";
	print "<A HREF=\"#Controllers\">Controllers</A> |\n";
	print "<A HREF=\"#Video Cards\">Video<NOBR> Cards</A> |\n";
	print "<A HREF=\"#Hard / Floppy Drives\">Hard / Floppy<NOBR> Drives</A> ]<BR>\n";
	print "[ <A HREF=\"#Multimedia Products\">Multimedia<NOBR> Products</A> |\n";
	print "<A HREF=\"#Computer Cases\">Computer<NOBR> Cases</A> |\n";
	print "<A HREF=\"#Monitors\">Monitors</A> |\n";
	print "<A HREF=\"#Mice & Keyboards\">Mice<NOBR> &<NOBR> Keyboards</A> |\n";
	print "<A HREF=\"#Miscellaneous\">Miscellaneous</A> ]\n";
	print "</CENTER><HR><P>\n";
	&print_prices;
	&footer;
	exit;
}

sub computers {
	&header;
	print "<IMG SRC=\"/avalon/gifs/computers.gif\">\n";
	print "<P>Welcome to our <B>Computer Department</B>. Here you'll find a list of\n";
	print "computers we carry. If the system you're looking\n";
	print "for is not listed, email our sales staff by clicking on the\n";
	print "mail button at the bottom of this page and we can provide a customized\n";
	print "quote for you.\n";
	print "<P><HR>\n";
	&banner;
	print "<HR><P>\n";
	&print_prices;
	&footer;
	exit;
}

sub peripherals {
	&header;
	print "<IMG SRC=\"/avalon/gifs/peripherals.gif\">\n";
	print "<P>Welcome to our <B>Peripheral Department</B>. Here you'll find a list of\n";
	print "peripherals we carry. If the product you're looking\n";
	print "for is not listed, click on the mail button at the bottom of this page\n";
	print "to email our sales staff, and we'll see if we can source it for you.</P>\n";
	print "<P><HR>\n";
	&banner;
	print "<HR><CENTER>\n";
	print "[ <A HREF=\"#Calculators\">Calculators</A> |\n";
	print "<A HREF=\"#Dot Matrix Printers\">Dot Matrix Printers</A> |\n";
	print "<A HREF=\"#Fax Machines\">Fax Machines</A> |\n";
	print "<A HREF=\"#Inkjet Printers\">Inkjet Printers</A> ]<BR>\n";
	print "[ <A HREF=\"#Joysticks\">Joysticks</A> |\n";
	print "<A HREF=\"#Laser Printers\">Laser Printers</A> |\n";
	print "<A HREF=\"#Miscellaneous\">Miscellaneous</A> |\n";
	print "<A HREF=\"#Modems\">Modems</A> ]<BR>\n";
	print "[ <A HREF=\"#Multimedia Kits\">Multimedia Kits</A> |\n";
	print "<A HREF=\"#Scanners\">Scanners</A> |\n";
	print "<A HREF=\"#Sound Cards\">Sound Cards</A> |\n";
	print "<A HREF=\"#Tape Backups\">Tape Backups</A> ]\n";
	print "</CENTER><HR><P>\n";
	&print_prices;
	&footer;
	exit;
}

sub magazines {
	&header;
	print "<IMG SRC=\"/avalon/gifs/magazines.gif\">\n";
	print "<P>Welcome to our <B>Magazine Department</B>. Here you'll find a list of\n";
	print "magazines we carry. If the product you're looking\n";
	print "for is not listed, click on the mail button at the bottom of this page\n";
	print "to email our sales staff, and we'll see if we can source it for you.</P>\n";
	print "<P><HR>\n";
	&banner;
	print "<HR><P>\n";
	&print_prices;
	&footer;
	exit;
}

sub software {
	&header;
	print "<IMG SRC=\"/avalon/gifs/software.gif\">\n";
	print "<P>Welcome to our <B>Software Department</B>. Here you'll find a list of\n";
	print "software we carry. If the product you're looking\n";
	print "for is not listed, click on the mail button at the bottom of this page\n";
	print "to email our sales staff, and we'll see if we can source it for you.</P>\n";
	print "<P><HR>\n";
	&banner;
	print "<HR><CENTER>\n";
	print "<FONT SIZE=+1>BUSINESS SOFTWARE</FONT><BR>\n";
	print "[ <A HREF=\"#Business - Accounting / Financial\">Accounting / Financial</A> |\n";
	print "<A HREF=\"#Business - Communications\">Communications</A> |\n";
	print "<A HREF=\"#Business - Database / Programming\">Database / Programming</A> |\n";
	print "<A HREF=\"#Business - Graphics / Publishing\">Graphics / Publishing</A> ]<BR>\n";
	print "[ <A HREF=\"#Business - Misc\">Miscellaneous</A> |\n";
	print "<A HREF=\"#Business - Operating Systems\">Operating Systems</A> |\n";
	print "<A HREF=\"#Business - Project / Contact Management\">Project / Contact Management</A> |\n";
	print "<A HREF=\"#Business - Spreadsheet\">Spreadsheet</A> ]<BR>\n";
	print "[ <A HREF=\"#Business - Suites\">Suites</A> |\n";
	print "<A HREF=\"#Business - Utilities\">Utilities</A> |\n";
	print "<A HREF=\"#Business - Word Processing\">Word Processing</A> ]<BR>\n";
	print "<FONT SIZE=+1>GAME SOFTWARE</FONT><BR>\n";
	print "[ <A HREF=\"#Game - Action\">Action</A> |\n";
	print "<A HREF=\"#Game - Adventure\">Adventure</A> |\n";
	print "<A HREF=\"#Game - Flight\">Flight</A> |\n";
	print "<A HREF=\"#Game - Leisure\">Leisure</A> |\n";
	print "<A HREF=\"#Game - Simulation\">Simulation</A> |\n";
	print "<A HREF=\"#Game - Sports\">Sports</A> |\n";
	print "<A HREF=\"#Game - Strategy\">Strategy</A> |\n";
	print "<A HREF=\"#Game - Classics\">Classics</A> ]<BR>\n";
	print "<FONT SIZE=+1>OTHER SOFTWARE</A></FONT><BR>\n";
	print "[ <A HREF=\"#Educational\">Educational</A> |\n";
	print "<A HREF=\"#Miscellaneous\">Miscellaneous</A> |\n";
	print "<A HREF=\"#Shareware CDs\">Shareware CDs</A> ]\n";
	print "</CENTER><HR><P>\n";
	&print_prices;
	&footer;
	exit;
}

sub service {
	&header;
#	&banner;
	print "<CENTER><IMG SRC=\"/avalon/gifs/construction_bar.gif\"></CENTER>\n";
#	&print_prices;
	&footer;
	exit;
}

sub whats_new {
	&header;
	&banner;
	print "<P><HR>\n";
	&print_prices;
	&footer;
	exit;
}

sub buy {
	# Check to see if its already in the basket.
	open (BASKET, "/tmp/basket.$process");
	while (<BASKET>) {
		if (/$pn/) {
			&already_in_basket;
		}
	}
	close (BASKET);

	# Add product to basket file.
	open (BASKET, ">>/tmp/basket.$process");			
	# Find the corresponding part number in the price list.
	open (PRICES, "/local/http/avalon/prices/master.pri");
	while ($line_prices = <PRICES>) {	
		($pn_prices) = split (/:/, $line_prices);
		if ($pn_prices eq $pn) {
			print BASKET $line_prices;
		}
	}
	close (PRICES);
	close (BASKET);

	# Send output.
	&header;
	&print_basket;
	&footer;
	exit;
}

sub remove {

# Create a temporary basket file for reading from.
$command = "cp /tmp/basket.$process /tmp/basket.$process.w";
system($command);

open (BASKETW, "/tmp/basket.$process.w");
open (BASKET, ">/tmp/basket.$process");

# if the part number matches, wipe out the line.
while (<BASKETW>) {
	if (/$pn/) {
		chop;
		s/.//g;
	}
	print BASKET $_;
}
# Delete the temporary file.
unlink ("/tmp/basket.$process.w");

	&header;
	&print_basket;
	&footer;
	exit;	
}

sub already_in_basket {
	&header;
	print "That Article is already in your shopping basket. You will\n";
	print "have an opportunity to enter quantities at the final checkout\n";
	print "of your selected items.<P>\n";
	&footer;
	exit;
}

sub refresh_basket {
	&header;
	&print_basket;
	&footer;
	exit;
}

sub checkout {
	# Verify Membership ID.
	open (MEMBERFILE, "/var/apache/cgi-bin/members.avalon");
	while (<MEMBERFILE>) {
	($id, $firstname) = split (/:/);
	if (/^$in{'memberid'}/i) {			
	&header;
	print "<IMG SRC=\"/avalon/gifs/checkout_counter.gif\">\n";
	print "<P><I>Hello $firstname...\n";
	print "If necessary, please adjust your quantities now.</I><P>\n";
	print "<CENTER>\n";
	print "<HR>\n";
	print "<FORM METHOD=post ACTION=\"/cgi-bin/store?area=11&process=$process&&&id=$memberid\">\n";
	print "<TABLE BORDER=0 CELLPADDING=5>\n";
	print "<TR><TH ALIGN=LEFT>Qty.</TH>";
	print "<TH ALIGN=LEFT>P/N</TH>\n";
	print "<TH ALIGN=LEFT>Description</TH>\n";
	print "<TH>Format</TH>\n";
	print "<TH>Price</TH>\n";
	print "<TH>BDC Price</TH><TH></TH>\n";
	open (BASKET, "/tmp/basket.$process");

	# $item will be used to rack up the variable representing the
	# quantity of each item in the basket. This method had to be used
	# in order to get a different environment variable for each item
	# in the form.
	$item = 0;	

	while (<BASKET>) {
		chop;
		($partno, $pic, $desc, $specfile, $format, $regprice, $bdcprice) = split(/:/);
		unless ($format) { $format = "N/A"; }
		# Set the next quantity variable
		$item++;
		# Build totals.
		$subreg = $subreg + $regprice;
		$gstreg = $subreg * 0.12;
		$pstreg = ($subreg + $gstreg) * 0.07;
		$totalreg = $subreg + $gstreg + $pstreg;
		$subbdc = $subbdc + $bdcprice;
		$gstbdc = $subbdc * 0.12;
		$pstbdc = ($subbdc + $gstbdc) * 0.07;
		$totalbdc = $subbdc + $gstbdc + $pstbdc;

		print "<TR>\n";
		# $item is used in the selection below.
		print "<TD VALIGN=TOP><INPUT NAME=$item VALUE=1 SIZE=2></TD>\n";
		print "<TD VALIGN=TOP>$partno</TD>\n";
		# Check to see if there is a spec file.
		if ($specfile) {
			print "<TD VALIGN=TOP><A HREF=\"/avalon/specs/$specfile\">$desc</A></TD>\n";
		} else {
			print "<TD VALIGN=TOP>$desc</TD>\n";
		}
		print "<TD VALIGN=TOP ALIGN=CENTER>$format</TD>\n";
		print "<TD VALIGN=TOP ALIGN=RIGHT>\$$regprice</TD>\n";
		print "<TD VALIGN=TOP ALIGN=RIGHT><B>\$$bdcprice</B></TD>\n";
		print "</TR>\n";
	}

	# finish output and print totals
	print "<TR><TD></TD><TD></TD><TD></TD><TD ALIGN=RIGHT><B>SUBTOTAL</B></TD>\n";
	printf ("<TD ALIGN=RIGHT>\$%.2f</TD><TD ALIGN=RIGHT><B>\$%.2f</B></TD><TD></TD></TR>\n", $subreg, $subbdc);
	print "</TABLE>\n";
	print "<B>Note: All prices are in Canadian dollars. Shipping charges\n";
	print "will be added</B></CENTER>\n";
	print "<P><HR>\n";
	print "<P>Please select your preferred shipping method.\n";
	print "Click <A HREF=\"/cgi-bin/store?area=$area&process=$process&value=shipping&&id=$memberid\">\n";
	print "here</A> for shipping rates.</P>\n";
	print "<TR><TD><INPUT TYPE=radio NAME=ship VALUE=Regular CHECKED>Regular (3-4 days)\n";
	print "<TR><TD><INPUT TYPE=radio NAME=ship VALUE=Express>Express (1-2 days)\n";
	print "<TR><TD><INPUT TYPE=radio NAME=ship VALUE=Priority>Priority (Next day)\n";
	print "<HR>\n";
	print "<P>Enter your email address: <INPUT TYPE=text NAME=email SIZE=35></P>\n";
	print "If you are a BDC member enter your number here: <INPUT TYPE=text NAME=bdcno SIZE=10><BR>\n";
	print "<I>Click <A HREF=\"/cgi-bin/store?area=$area&process=$process&value=bdc&&id=$memberid\">here</A> for more info on obtaining a Buyer's Discount Club Card</I>.";
	print "<P>Before you purchase, see our <A HREF=\"/cgi-bin/store?area=$area&process=$process&value=terms&&id=$memberid\">\n";
	print "Terms of Sale</A>.</P>\n";
	print "<P>Please enter any extra instructions here:<BR>\n";
	print "<TEXTAREA NAME=comments ROWS=4 COLS=60></TEXTAREA>\n";
	print "<P><INPUT TYPE=submit VALUE=\"Submit Order\">\n";
	print "</FORM>\n";
	&footer;
	exit;
	}
	}
	# Invalid Member ID.
	$idstatus = "fail";
	&memberid;
}

sub print_prices {
	print "<CENTER><TABLE BORDER=0 CELLPADDING=3>\n";
#	print "<TR><TH></TH>\n";
#	print "<TH ALIGN=LEFT>Description</TH>\n";
#	print "<TH>Format</TH>\n";
#	print "<TH>Price</TH>\n";
#	print "<TH>BDC Price</TH><TH></TH>\n";

	# Open the proper price file and format it to html.
	open (PRICES, "/local/http/avalon/prices/$filename");
	while (<PRICES>) {
		chop;
		# Split each line on the :
		($partno, $pic, $desc, $specfile, $format, $regprice, $bdcprice) = split(/:/);
		unless ($format) { $format = "N/A"; }
		print "<TR>\n";
		if ($partno =~ /^@/) {
			$partno =~ s/@//;
			print "<TH></TH><TH ALIGN=LEFT><I><A NAME=\"$partno\">$partno</A></I></TH>\n";
			print "<TH>Format</TH>\n";
			print "<TH>Price</TH>\n";
			print "<TH>BDC Price</TH><TH></TH>\n";
		} else {
			if ($pic) {
				print "<TD VALIGN=TOP><IMG SRC=\"/avalon/specs/$pic\"></TD>\n";

				} else {
				print "<TD></TD>\n";
			}
		# Check to see if there is a spec file.
			if ($specfile) {
				if ($specfile =~/^\/\//) {
					print "<TD VALIGN=TOP><A HREF=\"http:$specfile\">$desc</A></TD>\n";				
				} else {
					print "<TD VALIGN=TOP><A HREF=\"/avalon/specs/$specfile\">$desc</A></TD>\n";
				}
			} else {
				print "<TD VALIGN=TOP>$desc</TD>\n";
			}
			print "<TD VALIGN=TOP>$format</TD>\n";
			print "<TD VALIGN=TOP ALIGN=RIGHT>\$$regprice</TD>\n";
			print "<TD VALIGN=TOP ALIGN=RIGHT><B>\$$bdcprice</B></TD>\n";
			print "<TD VALIGN=TOP><A HREF=\"/cgi-bin/store?area=$area&process=$process&value=buy&pn=$partno\"><IMG SRC=\"/avalon/gifs/buy.gif\" BORDER=0></A></TD>\n";
			print "</TR>\n";
			}
		}
		print "</TABLE></CENTER>\n";
}

sub print_basket {
	print "<H3>Your Order So Far</H3>\n";
	&banner;
	print "<CENTER><TABLE BORDER=0 CELLPADDING=5>\n";
	print "<TR><TH ALIGN=LEFT>P/N</TH>\n";
	print "<TH ALIGN=LEFT>Description</TH>\n";
	print "<TH>Format</TH>\n";
	print "<TH>Price</TH>\n";
	print "<TH>BDC Price</TH><TH></TH>\n";

	open (BASKET, "/tmp/basket.$process");
	while (<BASKET>) {
		chop;
		($partno, $pic, $desc, $specfile, $format, $regprice, $bdcprice) = split(/:/);
		unless ($format) { $format = "N/A"; }
		# Build totals.
		$subreg = $subreg + $regprice;
		$gstreg = $subreg * 0.12;
		$pstreg = ($subreg + $gstreg) * 0.07;
		$totalreg = $subreg + $gstreg + $pstreg;
		$subbdc = $subbdc + $bdcprice;
		$gstbdc = $subbdc * 0.12;
		$pstbdc = ($subbdc + $gstbdc) * 0.07;
		$totalbdc = $subbdc + $gstbdc + $pstbdc;

		print "<TR>\n";
		print "<TD VALIGN=TOP>$partno</TD>\n";
		# Check to see if there is a spec file.
		if ($specfile) {
			if ($specfile =~/^\/\//) {
				print "<TD VALIGN=TOP><A HREF=\"http:$specfile\">$desc</A></TD>\n";				
			} else {
				print "<TD VALIGN=TOP><A HREF=\"/avalon/specs/$specfile\">$desc</A></TD>\n";
			}
		} else {
			print "<TD VALIGN=TOP>$desc</TD>\n";
		}
		print "<TD VALIGN=TOP ALIGN=CENTER>$format</TD>\n";
		print "<TD VALIGN=TOP ALIGN=RIGHT>\$$regprice</TD>\n";
		print "<TD VALIGN=TOP ALIGN=RIGHT><B>\$$bdcprice</B></TD>\n";
#		if ($area !~ /[10|11|12]/) {
			print "<TD VALIGN=TOP ALIGN=RIGHT><A HREF=\"/cgi-bin/store?area=$area&process=$process&value=remove&pn=$partno\">\n";
			print "<IMG SRC=\"/avalon/gifs/remove.gif\" BORDER=0></A>\n";
#		}
		print "</TR>\n";
	}

	# finish output and print totals
	print "<TR><TD></TD><TD></TD><TD ALIGN=RIGHT><B>SUBTOTAL</B></TD>\n";
	printf ("<TD ALIGN=RIGHT>\$%.2f</TD><TD ALIGN=RIGHT><B>\$%.2f</B></TD><TD></TD></TR>\n", $subreg, $subbdc);
	print "</TABLE>\n";
	print "</CENTER><P>\n";
}

sub header {
	print "Content-type: text/html\n\n";
	print "<HTML>\n";
	print "<HEAD><TITLE>Avalon Software - Internet Store</TITLE></HEAD>\n";
	print "<BODY BGCOLOR=#FFFFFF>\n";
	print "<IMG SRC=\"/avalon/gifs/avalon_logo_small.gif\">\n";
	print "<HR><P>\n";
}

sub footer {
	print "<P><HR>\n";
	print "<A HREF=\"/index.html\"><IMG BORDER=0 SRC=\"/avalon/gifs/home.gif\"></A>";
	if ($area eq "11") {
		print "<A HREF=\"/cgi-bin/store?area=13&process=$process&&&id=$memberid\"><IMG BORDER=0 SRC=\"/avalon/gifs/left.gif\"></A>";
	} elsif (($area eq "13") && ($value !~ /[bdc|terms]/)) {
		print "<A HREF=\"/cgi-bin/store?area=10&process=$process&&&id=$memberid\"><IMG BORDER=0 SRC=\"/avalon/gifs/left.gif\"></A>";
	} elsif ($value =~ /[buy|remove|refresh|terms|form]/) {
		print "<A HREF=\"/cgi-bin/store?area=$area&process=$process&&&id=$memberid\"><IMG SRC=\"/avalon/gifs/left.gif\" BORDER=0></A>";
	} else {
		print "<A HREF=\"/cgi-bin/store?area=1&process=$process\"><IMG SRC=\"/avalon/gifs/left.gif\" BORDER=0></A>";
	}
	print "<A HREF=\"mailto:sales@avalon.nf.ca\"><IMG BORDER=0 SRC=\"/avalon/gifs/mail.gif\"></A>";
}

sub banner {
	print "<CENTER>\n";
	if ($value eq "search") {
		print "<A HREF=\"/cgi-bin/store?area=1&process=$process\"><IMG SRC=\"/avalon/gifs/previous.gif\" BORDER=0></A>\n";
		print "<A HREF=\"/cgi-bin/store?area=$area&process=$process&value=refresh\"><IMG SRC=\"/avalon/gifs/viewbasket.gif\" BORDER=0></A>\n";		
	} elsif ($value =~ /[buy|remove|refresh|]/) {
		print "<A HREF=\"/cgi-bin/store?area=$area&process=$process\"><IMG SRC=\"/avalon/gifs/previous.gif\" BORDER=0></A>\n";
		print "<A HREF=\"/cgi-bin/store?area=$area&process=$process&value=refresh\"><IMG SRC=\"/avalon/gifs/refresh.gif\" BORDER=0></A>\n";

	} else {
		print "<A HREF=\"/cgi-bin/store?area=1&process=$process\"><IMG SRC=\"/avalon/gifs/previous.gif\" BORDER=0></A>\n";
		print "<A HREF=\"/cgi-bin/store?area=$area&process=$process&value=refresh\"><IMG SRC=\"/avalon/gifs/viewbasket.gif\" BORDER=0></A>\n";
	}
	print "<A HREF=\"/cgi-bin/store?area=10&process=$process\"><IMG SRC=\"/avalon/gifs/check.gif\" BORDER=0></A><BR>\n";
	if ($value eq "search") {
		print "[ <A HREF=\"/cgi-bin/store?area=1&process=$process\">Previous Area</A> |\n";	
		print "<A HREF=\"/cgi-bin/store?area=$area&process=$process&value=refresh\">View Basket</A> |\n";
	} elsif ($value =~ /[buy|remove|refresh]/) {
		print "[ <A HREF=\"/cgi-bin/store?area=$area&process=$process\">Previous Area</A> |\n";	
		print "<A HREF=\"/cgi-bin/store?area=$area&process=$process&value=refresh\">Refresh Basket</A> |\n";
	} else {
		print "[ <A HREF=\"/cgi-bin/store?area=1&process=$process\">Previous Area</A> |\n";	
		print "<A HREF=\"/cgi-bin/store?area=$area&process=$process&value=refresh\">View Basket</A> |\n";
	}
	print "<A HREF=\"/cgi-bin/store?area=10&process=$process\">Checkout</A> ]\n";
	print "</CENTER>\n";
}

sub verify_order {
	&print_invoice_items;
	&print_invoice;

	&header;
	print "Here is your final order. Please verify that the following information is correct:<P>\n";
	print "<P><PRE>\n";

	open (INVOICE, "/tmp/invoice.$process");
	while (<INVOICE>) {
		print;
	}

	print "</PRE>\n";
	print "<FORM METHOD=post ACTION=\"/cgi-bin/store?area=12&process=$process\"><P>\n";
	print "<INPUT TYPE=submit VALUE=\"This Information Is Correct\"></FORM><P>\n";

	&footer;
	exit;	
}

sub print_invoice {
	open (INVOICE, ">/tmp/invoice.$process");

	# Select INVOICE to be the default print-to.
	select(INVOICE);

	print "Avalon Software & Computers, Inc.\n";
	print "P.O. Box 39008\n";
	print "St. John's, NF\n";
	print "Canada A1E 5Y7\n";
	print "Tel. (709)709-0739\n";
	print "Fax. (709)709-1739\n\n";

	print "Ship To:  Acct. Number $memberid\n";
	print "Email:    $in{'email'}\n";
	print "Shipping: $in{'ship'}\n\n";
	print "==============================================================================\n";
	print "Qty. P/N          Description                       Format   Price    Extended\n";
	print "==============================================================================\n";

	# Pull in the items listed in the temporary invoice_item.* file.
	open (INVOICEITEM, "/tmp/invoice_item.$process");
	while (<INVOICEITEM>) {
		print;
	}
	close (INVOICEITEM);

	print "==============================================================================\n";
	printf ("                                                            Subtotal \$%8.2f\n",$sub);
	printf ("                                                                 GST \$%8.2f\n",$gst);
	if ($memberid =~ /^nf/i) {
		printf ("                                                                 PST \$%8.2f\n",$pst);
	}
	printf ("                                                               TOTAL \$%8.2f\n",$total);
	print "==============================================================================\n";

	# Print the BDC number if provided.
	if ($in{'bdcno'}) {
		print "BDC Number:  $in{'bdcno'}\n";
	}

	if ($in{'comments'}) {
		print "Extra Instructions:\n";
		print "$in{'comments'}\n";
	}

	close (INVOICE);

	# Re-select STDOUT for the default print-to.
	select (STDOUT);
}

sub order {
	&header;
	$command="mail steve@avalon.nf.ca < /tmp/invoice.$process";
	system($command);
	unlink("/tmp/basket.$process");
	unlink("/tmp/invoice_item.$process");
	unlink("/tmp/invoice.$process");
	print "<H1>Order Received</H1>\n";
	print "<HR><P>\n";
	print "Your order has been received. We will process it right away.\n";
	print "<P><B>Please shop at Avalon Software & Computers again!</B>\n";
	&footer;
	exit;
}

sub print_invoice_items {

	# Create a temporary file to hold the individual line items of the
	# invoice.
	open (INVOICEITEM, ">/tmp/invoice_item.$process");
	open (BASKET, "/tmp/basket.$process");

	# See "sub checkout" for an explanation of the use of $item.
	$item = 0;

	# Open the basket file and read it's contents into the INVOICEITEM
	# file.
	while (<BASKET>) {
		chop;
		($partno, $pic, $desc, $specfile, $format, $regprice, $bdcprice) = split(/:/);
		unless ($format) { $format = "N/A"; }
		$item++;
		$qty = $in{$item};

		# Build totals. If the users has supplied a BDC number, use
		# the BDC price, otherwise use the regular price.
		if ($in{'bdcno'}) {
			$price = $bdcprice;
		} else {
			$price = $regprice;
		}		

		$amt = sprintf ("%.2f",($price * $qty));
		$sub = $sub + $amt;
		$gst = $sub * 0.07;

		if ($memberid =~ /^nf/i) {
			$pst = ($sub + $gst) * 0.12;
			$total = $sub + $gst + $pst;
		} else {
			$total = $sub + $gst;	
		}
		write INVOICEITEM;
	}
	close (INVOICEITEM);
}

sub bdc {
	&header;
	print "<IMG ALIGN=MIDDLE SRC=\"/avalon/gifs/bdcshade.gif\">\n";
	print "<FONT SIZE=+2>Buyer's Discount Club Info.</FONT>\n";
	print "<HR>\n";
	print "<P>Owning a Buyer's Discount Club card entitles you to the following\n";
	print "discounts at Avalon Software & Computers: *\n";
	print "<UL>\n";
	print "<LI>5%  OFF software\n";
	print "<LI>5%  OFF accessories\n";
	print "<LI>15% OFF computer servicing\n";
	print "<LI>5%  OFF computer components\n";
	print "<LI>Extra 5 hours per month for Internet accounts\n";
	print "</UL>\n";
	print "<P><I><B>FREE</B> \"30 Day Trial\" Buyer's Discount Club cards may be obtained at our store</I>.\n";
	print "<P>The Buyer's Discount Club card entitles you to discounts at hundreds\n";
	print "of other stores across the province of Newfoundland for only <B>\$26.75</B>\n";
	print "per year. This will be the best \$26.75 you've ever invested!\n";
	print "<P>To receive a one year membership into the Buyer's Discount Club, <B>call 753-SAVE</B> (7283).\n";
	print "<P><FONT SIZE=-1><I>* some exceptions may apply</I></FONT>\n";
	&footer;
	&exit;
}

sub terms {
	&header;


	print "<H3>Terms of Sale</H3></A>\n";
	print "<UL>\n";
	print "<LI>We accept Visa and MasterCard orders only.\n";
	print "<LI>Credit cards will not be billed until orders are shipped.\n";
	print "<LI>Canadian orders subject to 7% Goods & Services Tax (GST).\n";
	print "<LI>Newfoundland orders also subject to 12% Provincial Sales Tax (PST).\n";
	print "<LI>Products are subject to availability. Prices subject to change\n";
	print "without notice. You will be notified either through email or by\n";
	print "telephone of any availability problems or rise in price before your order is shipped.\n";
	print "<LI>All prices are F.O.B. Avalon Software & Computers Inc., St. John's.\n";
	print "<LI>Shipments will carry no insurance coverage, unless specified\n";
	print "at the time of your order. Loss or damage of product during shipment\n";
	print "is the sole responsibility of the purchaser.\n";
	print "</UL>\n";
	&footer;
	exit;
}

sub memberid {
	&header;
	print "<CENTER><FORM METHOD=post ACTION=\"/cgi-bin/store?area=13&process=$process\">\n";
	if ($idstatus eq "fail") {
		print "<FONT SIZE=+1><B>The previously entered Membership ID was invalid.</B></FONT><BR>";
	}
	print "<FONT SIZE=+1><B>Please Enter Your Membership ID:</B></FONT>\n";
	print "<P><INPUT TYPE=text NAME=memberid SIZE=20 MAXLENGTH=25>\n";
        print "<INPUT TYPE=submit VALUE=Continue></FORM></CENTER>\n";
	print "<P><HR>\n";
	print "<P><B>You must be a member to order. If you are not a member, you can\n";
	print "join right now! Membership is FREE. All that is required is a\n";
	print "Visa or MasterCard number. Here's how to join:</B>\n";
	print "<UL>\n";
#	print "<LI><B>ONLINE:</B> Click <A HREF=\"/cgi-bin/store?area=$area&process=$process&value=onform\">here</A> to fill out our on-line form.\n";
	print "<LI><B>CALL:</B> 1-709-739-0739 from 9am to 9pm weekdays and 9am\n";
	print "to 6pm Saturdays Newfoundland time and give us your billing\n";
	print "information. You will receive a membership number immediately\n";
	print "and you can continue your order.\n";
	print "<LI><B>FAX or MAIL</B>: You can print and fill out this <A HREF=\"/cgi-bin/store?area=$area&process=$process&value=form\">membership form</A>\n";
	print "and fax or mail it back to us. We will process your form and\n";
	print "email you with your membership number.\n";
	print "</UL>\n";
	&footer;
	exit;
}

sub online_form {
	&header;
	print "<H3>Avalon Software Internet Store Membership Application</H3>\n";
	print "<HR>\n";
	print "<P><B>Instructions:</B><BR>\n";
	print "Please fill out all of the information below and click the\n";
	print "\"Submit Form\" button when done. This will email the application\n";
	print "back to us. We will process your application and email you a\n";
	print "membership number within 1 working day. <B>There is no charge or\n";
	print "obligation to join. All information will be kept in confidence.</B>\n";
	print "<HR>\n";
	print "<FORM METHOD=post ACTION=\"/cgi-bin/store?area=$area&process=$process&value=sendform\">\n";
	print "<PRE>";
	print "First Name:    <INPUT TYPE=text SIZE=35 NAME=firstname>\n";
	print "Last Name:     <INPUT TYPE=text SIZE=35 NAME=lastname>\n";
	print "Company Name:  <INPUT TYPE=text SIZE=35 NAME=company>\n\n";
	print "Address:       <INPUT TYPE=text SIZE=35 NAME=address1>\n";
	print "               <INPUT TYPE=text SIZE=35 NAME=address2>\n"; 
	print "               <INPUT TYPE=text SIZE=35 NAME=address3>\n";
	print "City:          <INPUT TYPE=text SIZE=35 NAME=city>\n";
	print "Province:      <SELECT NAME=prov>";
	print "<OPTION>NF<OPTION>NS<OPTION>PEI<OPTION>NB<OPTION>PQ<OPTION>ON\n";
	print "<OPTION>MB<OPTION>SK<OPTION>AB<OPTION>BC<OPTION>NWT<OPTION>YK</SELECT>\n";
	print "Country:       <INPUT NAME=country VALUE=Canada SIZE=17><BR>";
	print "Postal Code:   <INPUT TYPE=text SIZE=7 NAME=pcode>\n\n";
	print "Email Address: <INPUT TYPE=text SIZE=35 NAME=email>\n\n";	
	print "Telephone:     <INPUT TYPE=text SIZE=14 NAME=phone>\n";
	print "Fax:           <INPUT TYPE=text SIZE=14 NAME=fax>\n";
	print "Ship Via:      <SELECT NAME=ship><OPTION>Canada Post\n";
	print "<OPTION>Purolator Courier<OPTION>Midland Courier<OPTION>Sameday Courier</SELECT><BR>\n";
	print "Pay By:        <INPUT TYPE=radio NAME=payby VALUE=Visa CHECKED>Visa ";
	print "<INPUT TYPE=radio NAME=payby VALUE=MasterCard> MasterCard\n";
	print "Card Number:   <INPUT TYPE=text NAME=cardno SIZE=35>\n";
	print "Expiry Date:   <INPUT TYPE=text NAME=expiry SIZE=6>\n";
	print "Name on card:  <INPUT TYPE=text NAME=cardname SIZE=35><P>";
	print "BDC Number:    <INPUT TYPE=text SIZE=10 NAME=bdcno> Expiry: <INPUT TYPE=text SIZE=20 NAME=bdcexp>\n";
	print "<I>(Please fax us a photocopy of your BDC card as proof of membership.\n";
	print " Our fax number is 1-709-739-1739.)</I>\n\n";
	print "<INPUT TYPE=reset VALUE=\"Reset Form\"><INPUT TYPE=submit VALUE=\"Submit Form\">\n";
	print "</FORM>";
	&footer;
	exit;
}

sub membership_form {
	&header;
	print "<PRE>";
	print "AVALON SOFTWARE INTERNET STORE MEMBERSHIP APPLICATION\n\n";
	print "Instructions:\n";
	print "   You may call us from 9am to 9pm weekdays and 9am to 6pm\n";
	print "Saturdays to become a member immediately. At all other times you\n";
	print "can fill out this form.  Please fill out all of the information\n";
	print "and fax it back to us at 1-709-739-1739 or mail it to the address\n";
	print "below.  We will process your application and email you a member-\n";
	print "ship number within 1 working day. THERE IS NO CHARGE OR OBLIGATION\n";
	print "TO JOIN. ALL INFORMATION WILL BE KEPT IN CONFIDENCE.\n\n";
	print "------------------------------------------------------------------\n\n";
	print "Full Name:    ____________________________________________________\n";
	print "              Last,                       First\n\n";
	print "Company Name: ____________________________________________________\n\n";
	print "Address:      ____________________________________________________\n\n";
	print "City:         ___________________________ Province: ______________\n\n";
	print "Postal Code:  ___________________________ Country:  ______________\n\n";
	print "Telephone:    ___________________________ Fax: ___________________\n\n";
	print "Ship Via: \n";
	print "              ___ Regular Mail     ___ Priority Courier\n";
	print "              ___ Express Post     ___ Other _____________________\n\n";
	print "Pay By:       ___ Visa               ___ MasterCard\n\n";
	print "Card Number:  _______________________________ Expiry: ____________\n\n";
	print "Name on Card: _______________________________\n\n";
	print "I agree to abide by the terms of my credit card agreement.\n\n";
	print "              _______________________________               \n";
	print "              Signature\n\n";
	print "BDC Number:   _______________ Expiry: ____________ (optional)\n";
	print "(Please fax a photocopy of your BDC card as proof of membership.)\n\n";
	print "PLEASE FAX BACK TO 1-709-739-1739.  Thank You.\n\n";
	print "AVALON SOFTWARE & COMPUTERS INC.\n";
	print "22 O'Leary Avenue, St. John's, NF Canada A1B 2C7\n";
	print "Tel. 1-709-739-0739\n\n";
	print "------------------------------------------------------------------\n\n";
	print "OFFICE USE ONLY                     Account Number: ______________\n\n";
	&footer;
	exit;
}	

sub send_form {
#	open (MEMBERFORM, ">/tmp/memberform.$process");
#	select (MEMBERFORM);
#	print MEMBERFORM  "AVALON SOFTWARE INTERNET STORE MEMBERSHIP APPLICATION\n\n";
#	print MEMBERFORM  "------------------------------------------------------------------\n\n";
#	print MEMBERFORM  "Full Name:    $in{'lastname'}             $in{'firstname'}\n";
#	print MEMBERFORM  "              Last,                       First\n\n";
#	print MEMBERFORM  "Company Name: $in{'company'}\n\n";
#	print MEMBERFORM  "Address:      $in{'address1'}\n";
#	if ($in{'address2'}) {
#		print MEMBERFORM  "              $in{'address2'}\n";
#	}
#	if ($in{'address3'}) {
#		print MEMBERFORM  "              $in{'address3'}\n";
#	}	
#	print MEMBERFORM  "City:         $in{'city'}                 Province: $in{'prov'}\n\n";
#	print MEMBERFORM  "Postal Code:  $in{'code'}                 Country:  $in{'country'}\n\n";
#	print MEMBERFORM  "Telephone:    $in{'phone'}                Fax:      $in{'fax'}\n\n";
#	print MEMBERFORM  "Ship Via:     $in{'shipvia'}\n";
#	print MEMBERFORM  "Pay By:       $in{'payvia'}\n";
#	print MEMBERFORM  "Card Number:  $in{'cardno'}                Expiry:  $in{'expiry'\}n\n";
#	print MEMBERFORM  "Name on Card: $in{'cardname'}\n\n";
#	print MEMBERFORM  "BDC Number:   $in{'bdcno'}                 Expiry:  $in{'bdcexpire'}\n";
#	print MEMBERFORM  "------------------------------------------------------------------\n\n";
#	print MEMBERFORM  "OFFICE USE ONLY                     Account Number: ______________\n\n";
#	select (STDOUT);
#	$command = "mail steve@avalon.nf.ca < /tmp/memberform.$process";
#	system ($command);
#	close (MEMBERFORM);
#	unlink ("/tmp/memberform.$process");
	&header;
	print "Your application was received.\n";
	&footer;
	exit;
}

sub search {
	&header;
	&banner;
	print "<CENTER><P><FONT SIZE=+1><B>Here are the results of your search:</B></FONT></CENTER>\n";
	print "<CENTER><TABLE BORDER=0 CELLPADDING=3>\n";
	print "<TR><TD VALIGN=TOP></TD>\n";
	print "<TD VALIGN=TOP><B>Description</B></TD>\n";
	print "<TD VALIGN=TOP><B>Format</B></TD>\n";
	print "<TD VALIGN=TOP><B>Price</B></TD>\n";
	print "<TD VALIGN=TOP><B>BDC<NOBR>Price</B></TD><TD></TD>\n";
	@items = split(/ /, $in{'search'});
	open (SEARCHFILE, "/local/http/avalon/prices/master.pri");
	while (<SEARCHFILE>) {
		chop;	
		if (/@items/i) {
			$result++;
			# Split each line on the :
			($partno, $pic, $desc, $specfile, $format, $regprice, $bdcprice) = split(/:/);
			unless ($format) { $format = "N/A"; }
			print "<TR>\n";
			if ($partno =~ /^@/) {
				$partno =~ s/@//;
				print "<TD></TD><TD><B><I><FONT SIZE=+1><A NAME=\"$partno\">$partno</A></FONT></I></B></TD><TD></TD><TD></TD>\n";
			} else {
				if ($pic) {
					print "<TD VALIGN=TOP><IMG SRC=\"/avalon/specs/$pic\"></TD>\n";

				} else {
					print "<TD></TD>\n";
				}
			}
			# Check to see if there is a spec file.
			if ($specfile) {
				print "<TD VALIGN=TOP><A HREF=\"/avalon/specs/$specfile\">$desc</A></TD>\n";
			} else {
				print "<TD VALIGN=TOP>$desc</TD>\n";
			}

			print "<TD VALIGN=TOP>$format</TD>\n";
			print "<TD VALIGN=TOP ALIGN=RIGHT>\$$regprice</TD>\n";
			print "<TD VALIGN=TOP ALIGN=RIGHT><B>\$$bdcprice</B></TD>\n";
			print "<TD VALIGN=TOP><A HREF=\"/cgi-bin/store?area=$area&process=$process&value=buy&pn=$partno\"><IMG SRC=\"/avalon/gifs/buy.gif\" BORDER=0></A></TD>\n";
			print "</TR>\n";
		}

	}

	if ($result < 1) {
		print "<TR><TD></TD><TD><I>Found nothing that matched</I>.</TD><TD></TD><TD></TD><TD></TD></TR>\n";
	}

	print "</TABLE></CENTER>\n";
	&footer;
	exit;
}

sub tryagain {
	&header;
	print"<P>You have not selected a valid choice from the menu. Please go back and\n";
	print "re-select an option.</P>\n";
	&footer;
	exit;
}

sub grand_opening {
	print "Content-type: text/html\n\n";
	print "<HTML>\n";
	print "<HEAD><TITLE>Avalon Software - Internet Store</TITLE></HEAD>\n";
	print "<BODY BACKGROUND=\"/avalon/gifs/grand_opening.gif\" BGCOLOR=#FFFFFF>\n";
	print "<CENTER><IMG SRC=\"/avalon/gifs/avalon_logo.gif\"><BR><IMG SRC=\"/avalon/gifs/internet_store.gif\">\n";
	print "<HR>\n";
	print "<IMG SRC=\"/avalon/gifs/grand_opening_logo.gif\"></CENTER>\n";
	print "<P>\n";
	print "<CENTER><TABLE COLSPEC=\"L20 L20\" CELLPADDING=5>\n";

	print "<TR ALIGN=CENTER>\n";
	print "<TD><IMG SRC=\"/avalon/specs/logos/usrobot.gif\"><BR>\n";
	print "<FONT SIZE=+1>US Robotics 144 Si</FONT><BR>\n";
	print "External Fax/Modem<BR>\n";
	print "<FONT SIZE=+2>\$94.95</FONT></TD>\n";
	print "<TD><A HREF=\"/cgi-bin/store?area=$area&process=$process&value=buy&pn=MDM-USRSPOSI\">\n";
	print "<IMG SRC=\"/avalon/gifs/buy.gif\" BORDER=0></A></TD>\n";

	print "<TD><IMG SRC=\"/avalon/specs/logos/creative.gif\"><BR>\n";
	print "<FONT SIZE=+1>Sound Blaster Value CD 4X</FONT><BR>\n";
	print "Multimedia Upgrade Kit<BR>\n";
	print "<FONT SIZE=+2>\$394.95</FONT></TD>\n";
	print "<TD><A HREF=\"/cgi-bin/store?area=$area&process=$process&value=buy&pn=CDR-SBVALUE\">\n";
	print "<IMG SRC=\"/avalon/gifs/buy.gif\" BORDER=0></A></TD>\n";
	print "</TR>\n";

	print "<TR ALIGN=CENTER>\n";
	print "<TD><IMG SRC=\"/avalon/specs/logos/magitronic_logo.gif\"><BR>\n";
	print "<FONT SIZE=+1>Magitronic DX4/120</FONT><BR>\n";
	print "Motherboard, CPU, 256k Cache<BR>\n";
	print "<FONT SIZE=+2>\$349.95</FONT></TD>\n";
	print "<TD><A HREF=\"/cgi-bin/store?area=$area&process=$process&value=buy&pn=BRD-MAGDX120\">\n";
	print "<IMG SRC=\"/avalon/gifs/buy.gif\" BORDER=0></A></TD>\n";


	print "<TD><IMG SRC=\"/avalon/specs/logos/canon.gif\"><BR>\n";
	print "<FONT SIZE=+1>Canon BJC-4000</FONT><BR>\n";
	print "Color Bubble Jet Printer<BR>\n";
	print "<FONT SIZE=+2>\$429.95</FONT></TD>\n";
	print "<TD><A HREF=\"/cgi-bin/store?area=$area&process=$process&value=buy&pn=PRN-BJC-4000\">\n";
	print "<IMG SRC=\"/avalon/gifs/buy.gif\" BORDER=0></A></TD>\n";
	print "</TR>\n";

	print "<TR ALIGN=CENTER>\n";
	print "<TD><IMG SRC=\"/avalon/specs/software/ent/nhl96.jpg\"><BR>\n";
	print "<FONT SIZE=+1>NHL Hockey 96</FONT><BR>\n";
	print "DOS CD-ROM<BR>\n";
	print "<FONT SIZE=+2>\$62.69</FONT></TD>\n";
	print "<TD><A HREF=\"/cgi-bin/store?area=$area&process=$process&value=buy&pn=CDG-NHL96CDR\">\n";
	print "<IMG SRC=\"/avalon/gifs/buy.gif\" BORDER=0></A></TD>\n";

	print "<TD><IMG SRC=\"/avalon/specs/software/bus/works4.gif\"><BR>\n";
	print "<FONT SIZE=+1>MS Works 4.0 w/Bookshelf</FONT><BR>\n";
	print "WIN95 CD-ROM<BR>\n";
	print "<FONT SIZE=+2>\$96.75</FONT></TD>\n";
	print "<TD><A HREF=\"/cgi-bin/store?area=$area&process=$process&value=buy&pn=BUS-WORKS95\">\n";
	print "<IMG SRC=\"/avalon/gifs/buy.gif\" BORDER=0></A></TD>\n";
	print "</TR>\n";

	print "<TR ALIGN=CENTER>\n";
	print "<TD><FONT SIZE=+3><B>FUNAI</B></FONT><BR>\n";
	print "<FONT SIZE=+1>2X CD-ROM Drive</FONT><BR>\n";
	print "100% Panasonic Compatible<BR>\n";
	print "<FONT SIZE=+2>\$75.95</FONT></TD>\n";
	print "<TD><A HREF=\"/cgi-bin/store?area=$area&process=$process&value=buy&pn=CDR-PAN5622X\">\n";
	print "<IMG SRC=\"/avalon/gifs/buy.gif\" BORDER=0></A></TD>\n";

	print "<TD><FONT SIZE=+3><B><I>ACER</I></B></FONT><BR>\n";
	print "<FONT SIZE=+1>5X CD-ROM Drive</FONT><BR>\n";
	print "IDE Interface<BR>\n";
	print "<FONT SIZE=+2>\$189.95</FONT></TD>\n";
	print "<TD><A HREF=\"/cgi-bin/store?area=$area&process=$process&value=buy&pn=CDR-ACER5XCD\">\n";
	print "<IMG SRC=\"/avalon/gifs/buy.gif\" BORDER=0></A></TD>\n";
	print "</TR>\n";
	print "</TABLE></CENTER>\n";

	print "<CENTER><P><I>Note: All applicable discounts have been applied to the above items.</I></CENTER>\n";

	&footer;
	exit;
}

sub shipping {
	&header;
	print "<CENTER><IMG SRC=\"/avalon/gifs/construction_bar.gif\"></CENTER>\n";
	print "<P>Call (709) 739-0739 or email <A HREF=\"mailto:sales@avalon.nf.ca\">\n";
	print "sales@avalon.nf.ca</A> for shipping rates...\n";
	print "<P>A complete list of rates will be available within the next few\n";
	print "days.\n";
	&footer;
	exit;
}



format INVOICEITEM =
@<<< @<<<<<<<<<<< ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @<<<<< $@>>>>>>> $@>>>>>>>
$qty,$partno,     $desc,                            $format,$price,  $amt
~~                ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 
                  $desc
.

format COMMENTS =
   ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   $in{'comments'}
~~ ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   $in{'comments'}
.
