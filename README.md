[![Actions Status](https://github.com/skaji/Devel-PatchPerl-Plugin-Darwin-getcwd/workflows/test/badge.svg)](https://github.com/skaji/Devel-PatchPerl-Plugin-Darwin-getcwd/actions)

# NAME

Devel::PatchPerl::Plugin::Darwin::getcwd - use pwd command in macOS

# SYNOPSIS

    env PERL5_PATCHPERL_PLUGIN=Darwin::getcwd patchperl

# DESCRIPTION

macOS has a bug described in https://gist.github.com/skaji/84a4ea75480298f839f7cf4adcc109c9

As a result, building perl 5.28.0 or below constantly fails.

This plugin adds a workaround so that we use `pwd` to get the current directory.

# COPYRIGHT AND LICENSE

Copyright 2022 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
