
use strict ;
use warnings ;

use lib qw(lib) ;

use Text::Colorizer  qw() ;
 
my $c= Text::Colorizer->new
		(
		#~ FORMAT => 'HTML',
		FORMAT => 'ANSI',
		JOIN => "\n",
		JOIN_FLAT => "\n",
		) ;
  
my $colored =  $c->color
				(
				'bright_red on_black' => 'string',
				'on_bright_red' => 'string',
				'on_bright_yellow' => [ 'A1', 'A2', [ ['A3', 'A4'], 'A5', ['A6'], [[]]], 'A7'],
				) ;

print "$colored\n" ;


$colored =  $c->color_with
				(
				{
				HTML =>
					{
					my_grey => 'color:#888; ',
					my_yellow => 'color:#0ff; ',
					my_fg => 'color:#f80; ',
					my_bg => 'background-color:#484 ',
					},
				ANSI =>
					{
					my_grey => 'white ',
					my_yellow => 'bright_yellow ',
					my_fg => 'red ',
					my_bg => 'on_green ',
					},
				},
				
				'my_grey' => 'string',
				'my_yellow' => 'string',
				'my_fg my_bg' => [ 'A1', 'A2', [ ['A3', 'A4'], 'A5', ['A6'], [[]]], 'A7'],
				) ;


print "$colored\n" ;


my $colored =  $c->color_all
				(
				'blue on_bright_yellow' => 
					'my_grey',
					'string',
					'my_yellow',
					[ 'A1', 'A2', [ ['A3', 'A4'], 'A5', ['A6'], [[]]], 'A7'],
				) ;

print "$colored\n" ;

