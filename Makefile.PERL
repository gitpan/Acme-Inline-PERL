use ExtUtils::MakeMaker;

# Use this makefile maker if you actually wish to install Inline::PERL:
#
#        perl Makefile.PERL # Note!!
#        make
#        make test
#        make install
#

remove_acme();

WriteMakefile(
    'AUTHOR'        => 'John McNamara (jmcnamara@cpan.org)',
    'ABSTRACT'      => 'Bring the power of PERL programming to your Perl programs.',
    'NAME'          => 'Inline::PERL',
    'VERSION_FROM'  => 'PERL.pm',
    'NEEDS_LINKING' => 0,
    'PREREQ_PM'     => {Inline => 0, Inline::Files => 0},
    'dist'          => {COMPRESS => 'gzip -best', SUFFIX => 'gz'},
);


# Make a backup of PERL.pm and change the package name.
sub remove_acme {

    local $^I  = ".bak";
    local @ARGV = ('PERL.pm');

    while (<>) {
	if ($. == 1) {
	    $_ = 'package Inline::PERL;' . "\n";
	}
	print;
    }
}


