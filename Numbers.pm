package Lingua::AF::Numbers;

$VERSION = '0.2';

use strict;

my $numbers = {
	1	=>	'een',
	2	=>	'twee',
	3	=>	'drie',
	4	=>	'vier',
	5	=>	'vyf',
	6	=>	'ses',
	7	=>	'sewe',
	8	=>	'agt',
	9	=>	'nege',
	10	=>	'tien',
	11	=>	'elf',
	12	=>	'twalf',
	13	=>	'dertien',
	17	=>	'sewentien',
	18	=>	'agtien',
	19	=>	'negentien',
	20	=>	'twintig',
	30	=>	'dertig',
	40	=>	'viertig',
	50	=>	'vyftig',
	60	=>	'sestig',
	70	=>	'sewentig',
	80	=>	'tagtig',
	90	=>	'negentig',
};

sub new
{
	my $class = shift;
	my $number = shift || '';

	my $self = {};
	bless $self, $class;

	if( $number =~ /\d+/ ) {
		return( $self->parse($number) );
	};

	return( $self );
};


sub parse 
{
	my $self = shift;
	my $number = shift;

	my $digits;

	if( defined($numbers->{$number}) ) {
		return( $numbers->{$number} );
	}
	else {
		my $ret = '';

		@{$digits} = reverse( split('', $number) );
		if( defined($digits->[2]) ) {
			$ret .= $self->_formatHundreds( $digits );
		};
		$ret .= $self->_formatTens( $digits );
	
		return( $ret );
	};

	return;
};


sub _formatTens
{
	my $self = shift;
	my $digits = shift;

	# Both digits are zero
	unless( $digits->[0] || $digits->[1] ) {
		return( '' );
	};

	if( $digits->[1] == 1 ) {
		return( "$numbers->{$digits->[0]}$numbers->{10}" );
	};

	my $temp = $digits->[1] . 0;
	return( "$numbers->{$digits->[0]} en $numbers->{$temp}" );
};


sub _formatHundreds
{
	my $self = shift;
	my $digits = shift;

	my $ret = "$numbers->{$digits->[2]} honderd";

	if( $digits->[0] && $digits->[1] ) {
		$ret .= ', ';
	}
	else {
		$ret .= ' en ';
	};

	return( $ret );
};

1;

=pod

=head1 NAME

Lingua::AF::Numbers - Perl module for converting numeric values into their Afrikaans equivalents

    
=head1 DESCRIPTION

Initial release, documentation and updates will follow.

=head1 SYNOPSIS

  use Lingua::AF::Numbers;
    
  my $numbers = Lingua::AF::Numbers->new;

  my $text = $numbers->parse( 123 );

  # prints 'een honderd, drie en twintig'
  print $text;


=head1 KNOWN BUGS

None, but that does not mean there are not any.

=head1 AUTHOR

Alistair Francis, <cpan@alizta.com>

=cut

