
use strict ;
use warnings ;

use lib qw(lib) ;

use Text::Colorizer  qw() ;
 
my $c = Text::Colorizer->new
		(
		FORMAT => 'HTML',
		#~ FORMAT => 'ANSI',
		#~ JOIN => "\n",
		) ;


sub get_color_description_for_bg
{
my (@bg_colors) = @_ ;

my @color_and_text ;

push @color_and_text, 'bright_white', "\n" ;
push @color_and_text, '', ' ' x  16 ;

for my $bg (@bg_colors)
	{
	push @color_and_text, 'bright_white', sprintf("%-16.16s" ,  $bg)  ;
	}
push @color_and_text, 'bright_white', "\n" ;

for my $fg
	(
	'white', 'black', 'green', 'yellow', 'cyan', 'red', 'blue', 'magenta', 
	'bright_white', 'bright_black', 'bright_green', 'bright_yellow', 'bright_cyan', 'bright_red', 'bright_blue', 'bright_magenta',
	)
	{
	push @color_and_text, 'bright_white',  sprintf('%-16.16s', $fg) ;
	
	for my $bg(@bg_colors)
		{
		my $bg_length = length($bg) ;
		
		push @color_and_text, "$fg $bg", sprintf("%-16.16s" ,  'text')  ;
		}
	push @color_and_text, '', "\n" ;
	}

push @color_and_text, '', "\n" ;

return @color_and_text ;
}


my @color_and_text = get_color_description_for_bg('on_white', 'on_black', 'on_green', 'on_yellow', 'on_cyan', 'on_red', 'on_blue', 'on_magenta') ;
push @color_and_text, get_color_description_for_bg('on_bright_white', 'on_bright_black', 'on_bright_green', 'on_bright_yellow', 'on_bright_cyan', 'on_bright_red', 'on_bright_blue', 'on_bright_magenta') ;

my $colored =  $c->color(@color_and_text) ;

print "$colored\n" ;



