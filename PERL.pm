package Acme::Inline::PERL;

###############################################################################
#
# Inline::PERL - Bring the power of PERL programming to your Perl programs.
#
# John McNamara, jmcnamara@cpan.org
#
# Documentation after __END__
#


$VERSION = '0.01';
require Inline;
@ISA = qw(Inline);
use Carp;


sub register {
    return {
	    language => 'PERL',
	    aliases  => ['PEARL', 'CGI'],
	    type     => 'interpreted',
	    suffix   => 'PL',
	   };
}


sub build {
    my $o = shift;
    my $code = $o->{API}{code};

    if ($code =~ /use strict;/) {
	carp 'Your code contains "use strict;". Please be aware that '.
	     'this may provide you with too much of a clue';
    }

    sleep 1; # imitate compile delay
    {
	package PERL::Tester;
	eval $code;
    }

    croak "PERL build failed:\n$@" if $@;
    my $path = "$o->{API}{install_lib}/auto/$o->{API}{modpname}";
    my $obj = $o->{API}{location};
    $o->mkpath($path) unless -d $path;
    open PERL_OBJ, "> $obj" or croak "Can't open $obj for output\n$!";
    print PERL_OBJ $code;
    close \*PERL_OBJ;
}


sub load {
    my $o = shift;
    my $obj = $o->{API}{location};
    open PERL_OBJ, "< $obj" or croak "Can't open $obj for output\n$!";
    my $code = join '', <PERL_OBJ>;
    close \*PERL_OBJ;
    eval "package $o->{API}{pkg};\n$code";
    croak "Unable to load PERL module $obj:\n$@" if $@;
}


sub validate {
    my $o = shift;
    # Place holder
}


sub info {
    my $o = shift;
    # Place holder
}


1;


__END__

=head1 NAME

Inline::PERL - Bring the power of PERL programming to your Perl programs.


=head1 SYNOPSIS

    use Inline::Files;
    use Inline PERL;


    greeting("PERL");


    __PERL__
    sub greeting {

	$foo = shift @_ || $_[0];

	$! = 1; # Turn buffering off

	for ($i=1, $i<=10, $i++) {
	    @a[$i] = $i;
	}

	local $length = @a.length;

	print "Hello, $foo\n";
    }


=head1 DESCRIPTION

Inline::PERL gives you the power of the PERL programming language from
within your Perl programs. This gives you instant access to hundreds
of pre-coded applications such as bulletin boards, hit counters and
shopping carts.

PERL is a programming language for writing CGI applications. It's main
strength is that it doesn't have any unnecessary warnings or strictures.
It is a direct descendent of Perl, a programming language which was
used mainly by programmers. However, the original language required
too much reading and thinking and so PERL was developed as a language
which was more in tune with the requirements of the Internet age.


=head1 PERL DOCUMENTATION

Unfortunately there is no documentation for PERL (believe me I've
looked everywhere). Therefore, the best thing to do is to go straight
to comp.lang.perl.misc and ask your questions there.


=head1 PERFORMANCE

Your Inline::Perl program will run slowly the first few times that you
run it. After that you will get used to it.


=head1 AUTHOR

John McNamara jmcnamara@cpan.org

When I set out to write this I discovered that everything that I
needed was already in the Inline::Foo module. Curse you, Brian
Ingerson, you are making life *too* easy.

My apologies to Brian, the Inline community and, er, the PERL community.


=head1 INLINE API

If you are interested in writing a genuine Inline add-in you should
have a look at the Inline-API documentation and the Foo.pm example
that come with Inline.


=head1 COPYRIGHT

© MMI, John McNamara.

All Rights Reserved. This module is free software. It may be used,
redistributed and/or modified under the same terms as Perl itself.





