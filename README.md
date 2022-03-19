[![Actions Status](https://github.com/skaji/Devel-PatchPerl-Plugin-Darwin-getcwd/actions/workflows/test.yml/badge.svg)](https://github.com/skaji/Devel-PatchPerl-Plugin-Darwin-getcwd/actions)

# NAME

Devel::PatchPerl::Plugin::Darwin::getcwd - (DEPRECATED) a workaround for getcwd in macOS

# SYNOPSIS

    env PERL5_PATCHPERL_PLUGIN=Darwin::getcwd patchperl

If you use [plenv](https://github.com/tokuhirom/plenv)
with [Perl-Build](https://github.com/tokuhirom/Perl-Build) then,

    env PERL5_PATCHPERL_PLUGIN=Darwin::getcwd plenv install 5.28.3

# DESCRIPTION

**UPDATE**: It seems that the bug has been fixed in macOS 12.3, so we don't need this module anymore.

macOS has a bug described in [https://gist.github.com/skaji/84a4ea75480298f839f7cf4adcc109c9](https://gist.github.com/skaji/84a4ea75480298f839f7cf4adcc109c9)

As a result, building perl 5.28 or below often fails:

    Running Makefile.PL in cpan/libnet
    ../../miniperl -I../../lib Makefile.PL INSTALLDIRS=perl INSTALLMAN1DIR=none INSTALLMAN3DIR=none PERL_CORE=1 LIBPERL_A=libperl.a
    readdir(./../../../../../../../../..): No such file or directory at /Users/skaji/env/plenv/build/perl-5.18.4-QBrBC/lib/File/Find.pm line 484.
    Use of chdir('') or chdir(undef) as chdir() is deprecated at /Users/skaji/env/plenv/build/perl-5.18.4-QBrBC/lib/File/Find.pm line 624.
    Writing Makefile for Net
    Warning: No Makefile!
    make[2]: *** No rule to make target `config'.  Stop.
     /Applications/Xcode.app/Contents/Developer/usr/bin/make config PERL_CORE=1 LIBPERL_A=libperl.a failed, continuing anyway...
    Making all in cpan/libnet
     /Applications/Xcode.app/Contents/Developer/usr/bin/make all PERL_CORE=1 LIBPERL_A=libperl.a
    make[2]: *** No rule to make target `all'.  Stop.
    Unsuccessful make(cpan/libnet): code=512 at make_ext.pl line 490.
    make[1]: *** [cpan/libnet/pm_to_blib] Error 2
    make: *** [install] Error 2

This plugin adds a workaround so that we use `pwd` to get the current directory.

# COPYRIGHT AND LICENSE

Copyright 2022 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
