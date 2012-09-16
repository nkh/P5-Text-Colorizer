
package Text::Colorizer ;

use strict;
use warnings ;
use Carp ;

BEGIN 
{

use Sub::Exporter -setup => 
	{
	exports => [ qw() ],
	groups  => 
		{
		all  => [ qw() ],
		}
	};
	
use vars qw ($VERSION);
$VERSION     = '0.02';
}

#-------------------------------------------------------------------------------

use English qw( -no_match_vars ) ;

use Readonly ;
Readonly my $EMPTY_STRING => q{} ;

use Carp qw(carp croak confess) ;
use Term::ANSIColor qw(colored) ;

#-------------------------------------------------------------------------------

=head1 NAME

Text::Colorizer - Create colored text from text and color descrition. An ANSI to HTML tranformation is provided

=head1 SYNOPSIS

  my $c= Text::Colorizer->new
		(
		NAME => '' ,
		INTERACTION =>
			{
			INFO => sub {print @_},
			WARN => \&Carp::carp,
			DIE => \&Carp::confess,
			}
			
		FORMAT => 'HTML' | 'ANSI' |'ASCII',

		DEFAULT_COLOR => 'bright_white on_black',
		COLOR_NAMES => 
			{
			HTML =>
				{
				white => "color:#888;",
				black => "color:#000;",
				...
				}
			ANSI => ...
			ASCII => ...
			}
		) ;

  # or 
  
  my $c= Text::Colorizer->new() ;
  
  my $colored_text = $c->color
			   (
			   'red on_black' => 'string',
			   $color => [... many strings..],
			   'user_defined_color_name' => 'string'
			   ) ;

=head1 DESCRIPTION

This module defined methods to produce colored html from ANSI color description. The generated code use I<pre> tags. 
The generated HTML can be embeded in your pod documentation.

=head1 DOCUMENTATION

Valid colors:
  
  black red  green  yellow  blue  magenta  cyan  white
  
  bright_black  bright_red      bright_green  bright_yellow
  bright_blue   bright_magenta  bright_cyan   bright_white

  on_black  on_red      on_green  on yellow
  on_blue   on_magenta  on_cyan   on_white
  
  on_bright_black  on_bright_red      on_bright_green  on_bright_yellow
  on_bright_blue   on_bright_magenta  on_bright_cyan   on_bright_white

=begin html

<pre style ="font-family: monospace; background-color: #000 ;">
<span style = ' color:#fff; '>
</span><span style = ''>                </span><span style = ' color:#fff; '>on_white        </span><span style = ' color:#fff; '>on_black        </span><span style = ' color:#fff; '>on_green        </span><span style = ' color:#fff; '>on_yellow       </span><span style = ' color:#fff; '>on_cyan         </span><span style = ' color:#fff; '>on_red          </span><span style = ' color:#fff; '>on_blue         </span><span style = ' color:#fff; '>on_magenta      </span><span style = ' color:#fff; '>
</span><span style = ' color:#fff; '>white           </span><span style = ' color:#888;  background-color:#888; '>text            </span><span style = ' color:#888;  background-color:#000; '>text            </span><span style = ' color:#888;  background-color:#080; '>text            </span><span style = ' color:#888;  background-color:#880; '>text            </span><span style = ' color:#888;  background-color:#088; '>text            </span><span style = ' color:#888;  background-color:#800; '>text            </span><span style = ' color:#888;  background-color:#008; '>text            </span><span style = ' color:#888;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>black           </span><span style = ' color:#000;  background-color:#888; '>text            </span><span style = ' color:#000;  background-color:#000; '>text            </span><span style = ' color:#000;  background-color:#080; '>text            </span><span style = ' color:#000;  background-color:#880; '>text            </span><span style = ' color:#000;  background-color:#088; '>text            </span><span style = ' color:#000;  background-color:#800; '>text            </span><span style = ' color:#000;  background-color:#008; '>text            </span><span style = ' color:#000;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>green           </span><span style = ' color:#080;  background-color:#888; '>text            </span><span style = ' color:#080;  background-color:#000; '>text            </span><span style = ' color:#080;  background-color:#080; '>text            </span><span style = ' color:#080;  background-color:#880; '>text            </span><span style = ' color:#080;  background-color:#088; '>text            </span><span style = ' color:#080;  background-color:#800; '>text            </span><span style = ' color:#080;  background-color:#008; '>text            </span><span style = ' color:#080;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>yellow          </span><span style = ' color:#880;  background-color:#888; '>text            </span><span style = ' color:#880;  background-color:#000; '>text            </span><span style = ' color:#880;  background-color:#080; '>text            </span><span style = ' color:#880;  background-color:#880; '>text            </span><span style = ' color:#880;  background-color:#088; '>text            </span><span style = ' color:#880;  background-color:#800; '>text            </span><span style = ' color:#880;  background-color:#008; '>text            </span><span style = ' color:#880;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>cyan            </span><span style = ' color:#088;  background-color:#888; '>text            </span><span style = ' color:#088;  background-color:#000; '>text            </span><span style = ' color:#088;  background-color:#080; '>text            </span><span style = ' color:#088;  background-color:#880; '>text            </span><span style = ' color:#088;  background-color:#088; '>text            </span><span style = ' color:#088;  background-color:#800; '>text            </span><span style = ' color:#088;  background-color:#008; '>text            </span><span style = ' color:#088;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>red             </span><span style = ' color:#800;  background-color:#888; '>text            </span><span style = ' color:#800;  background-color:#000; '>text            </span><span style = ' color:#800;  background-color:#080; '>text            </span><span style = ' color:#800;  background-color:#880; '>text            </span><span style = ' color:#800;  background-color:#088; '>text            </span><span style = ' color:#800;  background-color:#800; '>text            </span><span style = ' color:#800;  background-color:#008; '>text            </span><span style = ' color:#800;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>blue            </span><span style = ' color:#008;  background-color:#888; '>text            </span><span style = ' color:#008;  background-color:#000; '>text            </span><span style = ' color:#008;  background-color:#080; '>text            </span><span style = ' color:#008;  background-color:#880; '>text            </span><span style = ' color:#008;  background-color:#088; '>text            </span><span style = ' color:#008;  background-color:#800; '>text            </span><span style = ' color:#008;  background-color:#008; '>text            </span><span style = ' color:#008;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>magenta         </span><span style = ' color:#808;  background-color:#888; '>text            </span><span style = ' color:#808;  background-color:#000; '>text            </span><span style = ' color:#808;  background-color:#080; '>text            </span><span style = ' color:#808;  background-color:#880; '>text            </span><span style = ' color:#808;  background-color:#088; '>text            </span><span style = ' color:#808;  background-color:#800; '>text            </span><span style = ' color:#808;  background-color:#008; '>text            </span><span style = ' color:#808;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_white    </span><span style = ' color:#fff;  background-color:#888; '>text            </span><span style = ' color:#fff;  background-color:#000; '>text            </span><span style = ' color:#fff;  background-color:#080; '>text            </span><span style = ' color:#fff;  background-color:#880; '>text            </span><span style = ' color:#fff;  background-color:#088; '>text            </span><span style = ' color:#fff;  background-color:#800; '>text            </span><span style = ' color:#fff;  background-color:#008; '>text            </span><span style = ' color:#fff;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_black    </span><span style = ' color:#000;  background-color:#888; '>text            </span><span style = ' color:#000;  background-color:#000; '>text            </span><span style = ' color:#000;  background-color:#080; '>text            </span><span style = ' color:#000;  background-color:#880; '>text            </span><span style = ' color:#000;  background-color:#088; '>text            </span><span style = ' color:#000;  background-color:#800; '>text            </span><span style = ' color:#000;  background-color:#008; '>text            </span><span style = ' color:#000;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_green    </span><span style = ' color:#0f0;  background-color:#888; '>text            </span><span style = ' color:#0f0;  background-color:#000; '>text            </span><span style = ' color:#0f0;  background-color:#080; '>text            </span><span style = ' color:#0f0;  background-color:#880; '>text            </span><span style = ' color:#0f0;  background-color:#088; '>text            </span><span style = ' color:#0f0;  background-color:#800; '>text            </span><span style = ' color:#0f0;  background-color:#008; '>text            </span><span style = ' color:#0f0;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_yellow   </span><span style = ' color:#ff0;  background-color:#888; '>text            </span><span style = ' color:#ff0;  background-color:#000; '>text            </span><span style = ' color:#ff0;  background-color:#080; '>text            </span><span style = ' color:#ff0;  background-color:#880; '>text            </span><span style = ' color:#ff0;  background-color:#088; '>text            </span><span style = ' color:#ff0;  background-color:#800; '>text            </span><span style = ' color:#ff0;  background-color:#008; '>text            </span><span style = ' color:#ff0;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_cyan     </span><span style = ' color:#0ff;  background-color:#888; '>text            </span><span style = ' color:#0ff;  background-color:#000; '>text            </span><span style = ' color:#0ff;  background-color:#080; '>text            </span><span style = ' color:#0ff;  background-color:#880; '>text            </span><span style = ' color:#0ff;  background-color:#088; '>text            </span><span style = ' color:#0ff;  background-color:#800; '>text            </span><span style = ' color:#0ff;  background-color:#008; '>text            </span><span style = ' color:#0ff;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_red      </span><span style = ' color:#f00;  background-color:#888; '>text            </span><span style = ' color:#f00;  background-color:#000; '>text            </span><span style = ' color:#f00;  background-color:#080; '>text            </span><span style = ' color:#f00;  background-color:#880; '>text            </span><span style = ' color:#f00;  background-color:#088; '>text            </span><span style = ' color:#f00;  background-color:#800; '>text            </span><span style = ' color:#f00;  background-color:#008; '>text            </span><span style = ' color:#f00;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_blue     </span><span style = ' color:#00f;  background-color:#888; '>text            </span><span style = ' color:#00f;  background-color:#000; '>text            </span><span style = ' color:#00f;  background-color:#080; '>text            </span><span style = ' color:#00f;  background-color:#880; '>text            </span><span style = ' color:#00f;  background-color:#088; '>text            </span><span style = ' color:#00f;  background-color:#800; '>text            </span><span style = ' color:#00f;  background-color:#008; '>text            </span><span style = ' color:#00f;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_magenta  </span><span style = ' color:#f0f;  background-color:#888; '>text            </span><span style = ' color:#f0f;  background-color:#000; '>text            </span><span style = ' color:#f0f;  background-color:#080; '>text            </span><span style = ' color:#f0f;  background-color:#880; '>text            </span><span style = ' color:#f0f;  background-color:#088; '>text            </span><span style = ' color:#f0f;  background-color:#800; '>text            </span><span style = ' color:#f0f;  background-color:#008; '>text            </span><span style = ' color:#f0f;  background-color:#808; '>text            </span><span style = ''>
</span><span style = ''>
</span><span style = ' color:#fff; '>
</span><span style = ''>                </span><span style = ' color:#fff; '>on_bright_white </span><span style = ' color:#fff; '>on_bright_black </span><span style = ' color:#fff; '>on_bright_green </span><span style = ' color:#fff; '>on_bright_yellow</span><span style = ' color:#fff; '>on_bright_cyan  </span><span style = ' color:#fff; '>on_bright_red   </span><span style = ' color:#fff; '>on_bright_blue  </span><span style = ' color:#fff; '>on_bright_magent</span><span style = ' color:#fff; '>
</span><span style = ' color:#fff; '>white           </span><span style = ' color:#888;  background-color:#fff; '>text            </span><span style = ' color:#888;  background-color:#000; '>text            </span><span style = ' color:#888;  background-color:#0f0; '>text            </span><span style = ' color:#888;  background-color:#ff0; '>text            </span><span style = ' color:#888;  background-color:#0ff; '>text            </span><span style = ' color:#888;  background-color:#f00; '>text            </span><span style = ' color:#888;  background-color:#00f; '>text            </span><span style = ' color:#888;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>black           </span><span style = ' color:#000;  background-color:#fff; '>text            </span><span style = ' color:#000;  background-color:#000; '>text            </span><span style = ' color:#000;  background-color:#0f0; '>text            </span><span style = ' color:#000;  background-color:#ff0; '>text            </span><span style = ' color:#000;  background-color:#0ff; '>text            </span><span style = ' color:#000;  background-color:#f00; '>text            </span><span style = ' color:#000;  background-color:#00f; '>text            </span><span style = ' color:#000;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>green           </span><span style = ' color:#080;  background-color:#fff; '>text            </span><span style = ' color:#080;  background-color:#000; '>text            </span><span style = ' color:#080;  background-color:#0f0; '>text            </span><span style = ' color:#080;  background-color:#ff0; '>text            </span><span style = ' color:#080;  background-color:#0ff; '>text            </span><span style = ' color:#080;  background-color:#f00; '>text            </span><span style = ' color:#080;  background-color:#00f; '>text            </span><span style = ' color:#080;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>yellow          </span><span style = ' color:#880;  background-color:#fff; '>text            </span><span style = ' color:#880;  background-color:#000; '>text            </span><span style = ' color:#880;  background-color:#0f0; '>text            </span><span style = ' color:#880;  background-color:#ff0; '>text            </span><span style = ' color:#880;  background-color:#0ff; '>text            </span><span style = ' color:#880;  background-color:#f00; '>text            </span><span style = ' color:#880;  background-color:#00f; '>text            </span><span style = ' color:#880;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>cyan            </span><span style = ' color:#088;  background-color:#fff; '>text            </span><span style = ' color:#088;  background-color:#000; '>text            </span><span style = ' color:#088;  background-color:#0f0; '>text            </span><span style = ' color:#088;  background-color:#ff0; '>text            </span><span style = ' color:#088;  background-color:#0ff; '>text            </span><span style = ' color:#088;  background-color:#f00; '>text            </span><span style = ' color:#088;  background-color:#00f; '>text            </span><span style = ' color:#088;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>red             </span><span style = ' color:#800;  background-color:#fff; '>text            </span><span style = ' color:#800;  background-color:#000; '>text            </span><span style = ' color:#800;  background-color:#0f0; '>text            </span><span style = ' color:#800;  background-color:#ff0; '>text            </span><span style = ' color:#800;  background-color:#0ff; '>text            </span><span style = ' color:#800;  background-color:#f00; '>text            </span><span style = ' color:#800;  background-color:#00f; '>text            </span><span style = ' color:#800;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>blue            </span><span style = ' color:#008;  background-color:#fff; '>text            </span><span style = ' color:#008;  background-color:#000; '>text            </span><span style = ' color:#008;  background-color:#0f0; '>text            </span><span style = ' color:#008;  background-color:#ff0; '>text            </span><span style = ' color:#008;  background-color:#0ff; '>text            </span><span style = ' color:#008;  background-color:#f00; '>text            </span><span style = ' color:#008;  background-color:#00f; '>text            </span><span style = ' color:#008;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>magenta         </span><span style = ' color:#808;  background-color:#fff; '>text            </span><span style = ' color:#808;  background-color:#000; '>text            </span><span style = ' color:#808;  background-color:#0f0; '>text            </span><span style = ' color:#808;  background-color:#ff0; '>text            </span><span style = ' color:#808;  background-color:#0ff; '>text            </span><span style = ' color:#808;  background-color:#f00; '>text            </span><span style = ' color:#808;  background-color:#00f; '>text            </span><span style = ' color:#808;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_white    </span><span style = ' color:#fff;  background-color:#fff; '>text            </span><span style = ' color:#fff;  background-color:#000; '>text            </span><span style = ' color:#fff;  background-color:#0f0; '>text            </span><span style = ' color:#fff;  background-color:#ff0; '>text            </span><span style = ' color:#fff;  background-color:#0ff; '>text            </span><span style = ' color:#fff;  background-color:#f00; '>text            </span><span style = ' color:#fff;  background-color:#00f; '>text            </span><span style = ' color:#fff;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_black    </span><span style = ' color:#000;  background-color:#fff; '>text            </span><span style = ' color:#000;  background-color:#000; '>text            </span><span style = ' color:#000;  background-color:#0f0; '>text            </span><span style = ' color:#000;  background-color:#ff0; '>text            </span><span style = ' color:#000;  background-color:#0ff; '>text            </span><span style = ' color:#000;  background-color:#f00; '>text            </span><span style = ' color:#000;  background-color:#00f; '>text            </span><span style = ' color:#000;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_green    </span><span style = ' color:#0f0;  background-color:#fff; '>text            </span><span style = ' color:#0f0;  background-color:#000; '>text            </span><span style = ' color:#0f0;  background-color:#0f0; '>text            </span><span style = ' color:#0f0;  background-color:#ff0; '>text            </span><span style = ' color:#0f0;  background-color:#0ff; '>text            </span><span style = ' color:#0f0;  background-color:#f00; '>text            </span><span style = ' color:#0f0;  background-color:#00f; '>text            </span><span style = ' color:#0f0;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_yellow   </span><span style = ' color:#ff0;  background-color:#fff; '>text            </span><span style = ' color:#ff0;  background-color:#000; '>text            </span><span style = ' color:#ff0;  background-color:#0f0; '>text            </span><span style = ' color:#ff0;  background-color:#ff0; '>text            </span><span style = ' color:#ff0;  background-color:#0ff; '>text            </span><span style = ' color:#ff0;  background-color:#f00; '>text            </span><span style = ' color:#ff0;  background-color:#00f; '>text            </span><span style = ' color:#ff0;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_cyan     </span><span style = ' color:#0ff;  background-color:#fff; '>text            </span><span style = ' color:#0ff;  background-color:#000; '>text            </span><span style = ' color:#0ff;  background-color:#0f0; '>text            </span><span style = ' color:#0ff;  background-color:#ff0; '>text            </span><span style = ' color:#0ff;  background-color:#0ff; '>text            </span><span style = ' color:#0ff;  background-color:#f00; '>text            </span><span style = ' color:#0ff;  background-color:#00f; '>text            </span><span style = ' color:#0ff;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_red      </span><span style = ' color:#f00;  background-color:#fff; '>text            </span><span style = ' color:#f00;  background-color:#000; '>text            </span><span style = ' color:#f00;  background-color:#0f0; '>text            </span><span style = ' color:#f00;  background-color:#ff0; '>text            </span><span style = ' color:#f00;  background-color:#0ff; '>text            </span><span style = ' color:#f00;  background-color:#f00; '>text            </span><span style = ' color:#f00;  background-color:#00f; '>text            </span><span style = ' color:#f00;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_blue     </span><span style = ' color:#00f;  background-color:#fff; '>text            </span><span style = ' color:#00f;  background-color:#000; '>text            </span><span style = ' color:#00f;  background-color:#0f0; '>text            </span><span style = ' color:#00f;  background-color:#ff0; '>text            </span><span style = ' color:#00f;  background-color:#0ff; '>text            </span><span style = ' color:#00f;  background-color:#f00; '>text            </span><span style = ' color:#00f;  background-color:#00f; '>text            </span><span style = ' color:#00f;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ' color:#fff; '>bright_magenta  </span><span style = ' color:#f0f;  background-color:#fff; '>text            </span><span style = ' color:#f0f;  background-color:#000; '>text            </span><span style = ' color:#f0f;  background-color:#0f0; '>text            </span><span style = ' color:#f0f;  background-color:#ff0; '>text            </span><span style = ' color:#f0f;  background-color:#0ff; '>text            </span><span style = ' color:#f0f;  background-color:#f00; '>text            </span><span style = ' color:#f0f;  background-color:#00f; '>text            </span><span style = ' color:#f0f;  background-color:#f0f; '>text            </span><span style = ''>
</span><span style = ''>
</span>
</pre>

=end html

=head2 Default background color

B<bright_white on_black>

=head1 SUBROUTINES/METHODS

=cut


#-------------------------------------------------------------------------------

Readonly my $NEW_ARGUMENTS => [qw(NAME INTERACTION VERBOSE JOIN JOIN_FLAT FORMAT DEFAULT_COLOR COLORS)] ;

sub new
{

=head2 new(NAMED_ARGUMENTS)

Create a Text::Colorizer object.  

  my $c= Text::Colorizer->new() ;

I<Arguments> - a list of pairs - Option => Value

=over 2 

=item * NAME - String - Name of the Data::HexDump::Range object, set to 'Anonymous' by default

=item * INTERACTION - Hash reference - Set of subs that are used to display information to the user

Useful if you use Data::HexDump::Range in an application without terminal.

=item * VERBOSE - Boolean - Display information about the creation of the object. Default is I<false>

=item * JOIN - String - string used to join colored elements. Default is an empty string.

=item * JOIN_FLAT - String - string used to join colored elements passed in array references. Default is an empty string.

=item * FORMAT - String - format of the dump string generated by Data::HexDump::Range.

Default is B<ANSI> which allows for colors. Other formats are 'ASCII' and 'HTML'.

=item * DEFAULT_COLOR -  the color used if no color is defined

	DEFAULT_COLOR => {ANSI => 'bright_white', HTML => 'color:#aaa; '} ;

=item * COLOR - String 'bw' or 'cycle'.

Ranges for which no color has been defined, in 'ANSI' or 'HTML' format mode, will be rendered in
black and white or with a color picked from a cyclic color list. Default is 'bw'.

=item * COLOR_NAMES - A hash reference or a file name

	{
	HTML =>
		{
		white => "color:#888;",
		black => "color:#000;",
		...
		}
	ANSI => ...
	ASCII => ...
	}

=back

I<Returns> - Text::Colorizer

I<Exceptions> - Dies if the color description are not valid

=cut

my ($invocant, @setup_data) = @_ ;

my $class = ref($invocant) || $invocant ;
confess 'Invalid constructor call!' unless defined $class ;

my $object = {} ;

my ($package, $file_name, $line) = caller() ;
bless $object, $class ;

$object->Setup($package, $file_name, $line, @setup_data) ;

return($object) ;
}

#-------------------------------------------------------------------------------

sub Setup
{

=head2 Setup

Helper sub called by new. This is a private sub.

=cut

my ($self, $package, $file_name, $line, @setup_data) = @_ ;

if (@setup_data % 2)
	{
	croak "Invalid number of argument '$file_name, $line'!" ;
	}

my %valid_argument = map {$_ => 1} @{$NEW_ARGUMENTS} ;

$self->{INTERACTION}{INFO} ||= sub {print @_} ;
$self->{INTERACTION}{WARN} ||= \&Carp::carp ;
$self->{INTERACTION}{DIE}  ||= \&Carp::croak ;
$self->{NAME} = 'Anonymous';
$self->{FILE} = $file_name ;
$self->{LINE} = $line ;

$self->CheckOptionNames(\%valid_argument, @setup_data) ;

%{$self} = 
	(
	NAME                   => 'Anonymous',
	FILE                   => $file_name,
	LINE                   => $line,
	
	JOIN => $EMPTY_STRING,
	JOIN_FLAT => $EMPTY_STRING,
	
	FORMAT => 'ANSI',
	DEFAULT_COLOR => {ANSI => 'bright_white', HTML => 'color:#fff; '},
	
	COLORS => 
		{
		ANSI =>
			{
			# you can defined aliases too
			# alarm => 'bright_red on_bright_yellwo',
			reset => 'reset',
			
			white => 'white',
			black => 'black',
			green => 'green',
			yellow => 'yellow',
			cyan => 'cyan',
			red => 'red',
			blue => 'blue',
			magenta => 'magenta',
			
			bright_white => 'bright_white',
			bright_black => 'bright_black',
			bright_green => 'bright_green',
			bright_yellow => 'bright_yellow',
			bright_cyan => 'bright_cyan',
			bright_red => 'bright_red',
			bright_blue => 'bright_blue',
			bright_magenta => 'bright_magenta',
			
			on_white => 'on_white',
			on_black => 'on_black',
			on_green => 'on_green',
			on_yellow => 'on_yellow',
			on_cyan => 'on_cyan',
			on_red => 'on_red',
			on_blue => 'on_blue',
			on_magenta => 'on_magenta',
			
			on_bright_white => 'on_bright_white',
			on_bright_black => 'on_bright_black',
			on_bright_green => 'on_bright_green',
			on_bright_yellow => 'on_bright_yellow',
			on_bright_cyan => 'on_bright_cyan',
			on_bright_red => 'on_bright_red',
			on_bright_blue => 'on_bright_blue',
			on_bright_magenta => 'on_bright_magenta',
			},
			
		HTML =>
			{
			# any attribute you can put in a span
			reset => '',
			
			white => 'color:#aaa; ',
			black => 'color:#000; ',
			green => 'color:#0a0; ',
			yellow => 'color:#aa0; ',
			cyan => 'color:#0aa; ',
			red => 'color:#a00; ',
			blue => 'color:#00a; ',
			magenta => 'color:#a0a; ',
			
			bright_white => 'color:#fff; ',
			bright_black => 'color:#000; ',
			bright_green => 'color:#0f0; ',
			bright_yellow => 'color:#ff0; ',
			bright_cyan => 'color:#0ff; ',
			bright_red => 'color:#f00; ',
			bright_blue => 'color:#00f; ',
			bright_magenta => 'color:#f0f; ',

			on_white => 'background-color:#aaa; ',
			on_black => 'background-color:#000; ',
			on_green => 'background-color:#0a0; ',
			on_yellow => 'background-color:#aa0; ',
			on_cyan => 'background-color:#0aa; ',
			on_red => 'background-color:#a00; ',
			on_blue => 'background-color:#00a; ',
			on_magenta => 'background-color:#a0a; ',
			
			on_bright_white => 'background-color:#fff; ',
			on_bright_black => 'background-color:#000; ',
			on_bright_green => 'background-color:#0f0; ',
			on_bright_yellow => 'background-color:#ff0; ',
			on_bright_cyan => 'background-color:#0ff; ',
			on_bright_red => 'background-color:#f00; ',
			on_bright_blue => 'background-color:#00f; ',
			on_bright_magenta => 'background-color:#f0f; ',
			},
		},

	@setup_data,
	) ;

my $location = "$self->{FILE}:$self->{LINE}" ;

$self->{INTERACTION}{INFO} ||= sub {print @_} ;
$self->{INTERACTION}{WARN} ||= \&Carp::carp ;
$self->{INTERACTION}{DIE}  ||= \&Carp::confess ;

if($self->{VERBOSE})
	{
	$self->{INTERACTION}{INFO}('Creating ' . ref($self) . " '$self->{NAME}' at $location.\n") ;
	}

if('HASH' ne ref $self->{COLORS})
	{
	my $colors = do $self->{COLORS} 
		or  $self->{INTERACTION}{DIE}("Can't load color file '$self->{COLORS}'.\n") ;
		
	'HASH' eq ref $colors
		or  $self->{INTERACTION}{DIE}("Invalid color file '$self->{COLORS}'.\n") ;
	
	$self->{COLORS} = $colors ;
	}

return ;
}

#-------------------------------------------------------------------------------

sub CheckOptionNames
{

=head2 CheckOptionNames

Verifies the named options passed to the members of this class. Calls B<{INTERACTION}{DIE}> in case
of error. This shall not be used directly.

=cut

my ($self, $valid_options, @options) = @_ ;

if (@options % 2)
	{
	$self->{INTERACTION}{DIE}->('Invalid number of argument!') ;
	}

if('HASH' eq ref $valid_options)
	{
	# OK
	}
elsif('ARRAY' eq ref $valid_options)
	{
	$valid_options = map{$_ => 1} @{$valid_options} ;
	}
else
	{
	$self->{INTERACTION}{DIE}->("Invalid argument '$valid_options'!") ;
	}

my %options = @options ;

for my $option_name (keys %options)
	{
	unless(exists $valid_options->{$option_name})
		{
		$self->{INTERACTION}{DIE}->("$self->{NAME}: Invalid Option '$option_name' at '$self->{FILE}:$self->{LINE}'!")  ;
		}
	}

if
	(
	   (defined $options{FILE} && ! defined $options{LINE})
	|| (!defined $options{FILE} && defined $options{LINE})
	)
	{
	$self->{INTERACTION}{DIE}->("$self->{NAME}: Incomplete option FILE::LINE!") ;
	}

return(1) ;
}

#-------------------------------------------------------------------------------

sub get_colors
{

=head2 get_colors( )

Returns the  colors defined in the object

 my $colors = $c->get_colors( ) ;

I<Arguments> - None

I<Returns> -  A hash reference

I<Exceptions> - None

=cut

my ($self) = @_ ;

return $self->{COLORS} ;
}

#-------------------------------------------------------------------------------

sub set_colors
{

=head2 set_colors(\%colors)

Copies 

  my %colors =
  	(
 	HTML =>
 		{
		white => "style='color:#888;'",
		black => "style='color:#000;'",
		...
		bright_white => "style='color:#fff;'",
		bright_black => "style='color:#000;'",
		bright_green => "style='color:#0f0;'",
		...
		}
	) ;
	
  $c->set_color(\%colors) ;

I<Arguments> 

=over 2 

=item * \%colors - A hash reference

=back

I<Returns> - Nothing

I<Exceptions> - dies if the color definitions are invalid

=cut

my ($self, $colors) = @_ ;

$self->{COLORS} = $colors ;

return ;
}

#-------------------------------------------------------------------------------

sub flatten 
{ 
	
=head2 [P] flatten($scalar || \@array)

Transforms array references to a flat list

I<Arguments> - 

=over 2 

=item * $scalar - 

=back

I<Returns> - a lsit of scalars

=cut

map 
	{
	my  $description = $_ ;
	
	if(ref($description) eq 'ARRAY')
		{
		flatten(@{$description}) ;
		}
	else
		{
		$description
		}
	} @_ 
}

#-------------------------------------------------------------------------------

sub color
{

=head2 color($color_name, $text, $color_name, \@many_text_strings, ...) ;

Returns colored text. according to the object setting. Default is HTML color coded.

  my $colored_text = $c->color
			   (
			   'red on_black' => 'string',
			   $color => [... many strings..]
			   'user_defined_color_name' => 'string'
			   ) ;
				   
I<Arguments>  - A list of colors and text pairs

=over 2 

=item * $color - 

=item * $text - 

=back

I<Returns> - A single string

I<Exceptions> - Dies if the color is invalid

=cut

my ($self) = shift @_ ;

my ($header, $footer, $colorizer)  = ('', '') ;

my %ascii_to_html =
	(
	'<' => '&lt;',
	'>' => '&gt;',
	'&' => '&amp;',
	"'" => '&apos;',
	'"' => '&quot;',
	) ;

for ($self->{FORMAT})
	{
	/ASCII/ and do
		{
		$colorizer = 
			sub 
				{
				#~ my ($text, $color) = @_ ; 
				#~ return $text ;
				
				$_[0] ;
				} ;
			
		last ;
		} ;
		
	/ANSI/ and do
		{
		$colorizer = sub { my ($text, $color) = @_ ; (defined $color && $color ne '') ? colored($text, $color) : $text ; } ;
			
		last ;
		} ;
		
	/HTML/ and do
		{
		$header = qq~<pre style ="font-family: monospace; background-color: #000 ;">\n~ ;
		$colorizer = 
			sub 
			{ 
			my ($text, $color) = @_ ; 
			
			$text =~ s/(<|>|&|\'|\")/$ascii_to_html{$1}/eg ;
			
			"<span style = '$color'>" . $text . "</span>" ;
			} ;
			
		$footer .= "\n</pre>\n" ;
		
		last ;
		} ;
		
	$self->{INTERACTION}{DIE}("Error: Invalid format '$self->{FORMAT}'.\n");
	}

$self->{INTERACTION}{DIE}("Error: number of elements in argument list'.\n") if @_ % 2 ;

my @formated ;

while(@_)
	{
	my ($color_tag, $text) = (shift, shift) ;
	my $colors = $self->{DEFAULT_COLOR}{$self->{FORMAT}} ;
	
	if(defined $color_tag && $self->{FORMAT} ne 'ASCII')
		{
		for my $color_tag_component (split /\s+/, $color_tag)
			{
			$color_tag_component =~ s/\s+//g ;
			
			my $color = $self->{COLORS}{$self->{FORMAT}}{$color_tag_component} ;
			
			$self->{INTERACTION}{DIE}("Error: Invalid color componenent '$self->{FORMAT}::$color_tag_component'.\n") unless defined $color ;
			
			$colors .= ' ' . $color ;
			}
		}
		
	push @formated, join $self->{JOIN_FLAT}, map {$colorizer->($_, $colors)} flatten($text) ;
	}

return $header . join($self->{JOIN}, @formated) . $footer ;
}

#-------------------------------------------------------------------------------

sub color_all
{

=head2 color_all($color, $string, \@many_text_strings, ...)

Uses a single color to colorize all the strings

  my $colored_text = $c->color_all($color, $string, \@many_text_strings, ...) ;

I<Arguments>

=over 2 

=item * $xxx - 

=back

I<Returns> - Nothing

I<Exceptions>

=cut

my ($self, $color) = (shift @_, shift @_) ;

#todo: verify colors

return $self->color(map{$color, $_} @_) ;
}

#-------------------------------------------------------------------------------

sub color_with
{

=head2 color_with(\%color_definitions, 'color' => 'text', $color => \@many_text_strings, ...) ;

Colors a text, temporarely overridding the colors defined in the object.

  my %colors =
  	{
 	HTML =>
 		{
		white => "style='color:#888;'",
		black => "style='color:#000;'",
		...
		bright_white => "style='color:#fff;'",
		bright_black => "style='color:#000;'",
		bright_green => "style='color:#0f0;'",
		...
		}
	},
	
  my $colored_text = $c->color
			   (
			   'red on_black' => 'string',
			   'blue on_yellow' => [... many strings..]
			   'user_defined_color_name' => 'string'
			   ) ;

I<Arguments>

=over 2 

=item * $ - 

=item * $color - 

=item * $xxx - 

=back

I<Returns> - Nothing

I<Exceptions> -  Dies if  any argument is invalid

=cut

my ($self, $colors) = (shift @_, shift @_) ;

local $self->{COLORS} = $colors ;
return $self->color(@_) ;
}

#-------------------------------------------------------------------------------

sub color_all_with
{

=head2 color_all_with($temporary_colors, $color, $text | \@many_text_string, ...) ;

Uses a single color to colorize all the strings, using a temporary color definition

  my $temporary_colors =
  	{
 	HTML =>
 		{
		white => "style='color:#888;'",
		black => "style='color:#000;'",
		...
		bright_white => "style='color:#fff;'",
		bright_black => "style='color:#000;'",
		bright_green => "style='color:#0f0;'",
		...
		}
	},
	
  my $colored_text = $c->color_all_with($temporary_colors, $color, 'string', [... many strings..], ...) ;

I<Arguments>

=over 2 

=item * $xxx - 

=back

I<Returns> - A colorized string

I<Exceptions> Dies if invalid input is received

=cut

my ($self, $colors) = (shift @_, shift @_) ;

local $self->{COLORS} = $colors ;
return $self->color_all(@_) ;
}

#-------------------------------------------------------------------------------

1 ;

=head1 BUGS AND LIMITATIONS

None so far.

=head1 AUTHOR

	Nadim ibn hamouda el Khemir
	CPAN ID: NKH
	mailto: nadim@cpan.org

=head1 COPYRIGHT & LICENSE

Copyright 2010 Nadim Khemir.

This program is free software; you can redistribute it and/or
modify it under the terms of either:

=over 4

=item * the GNU General Public License as published by the Free
Software Foundation; either version 1, or (at your option) any
later version, or

=item * the Artistic License version 2.0.

=back

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Text::Colorizer

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Color::ANSI-ToHTML>

=item * RT: CPAN's request tracker

Please report any bugs or feature requests to  L <bug-Color::ANSI-tohtml@rt.cpan.org>.

We will be notified, and then you'll automatically be notified of progress on
your bug as we make changes.

=item * Search CPAN

L<http://search.cpan.org/dist/Color::ANSI-ToHTML>

=back

=head1 SEE ALSO

L<HTML::FromANSI first>

=cut
