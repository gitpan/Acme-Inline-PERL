use ExtUtils::MakeMaker;

WriteMakefile(
    'AUTHOR'        => 'John McNamara (jmcnamara@cpan.org)',
    'ABSTRACT'      => 'Bring the power of PERL programming to your Perl programs.',
    'NAME'          => 'Acme::Inline::PERL',
    'VERSION_FROM'  => 'PERL.pm',
    'NEEDS_LINKING' => 0,
    'PREREQ_PM'     => {Inline => 0, Inline::Files => 0},
    'dist'          => {COMPRESS => 'gzip -best', SUFFIX => 'gz'},
);
