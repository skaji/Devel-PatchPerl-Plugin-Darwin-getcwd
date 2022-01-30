package Devel::PatchPerl::Plugin::getcwd;
use strict;
use warnings;

our $VERSION = '0.001';

use version;

sub patchperl {
    my ($class, %argv) = @_;

    if ($^O ne "darwin") {
        return 1; # OK
    }
    my $version = version->parse($argv{version});
    if ($version >= v5.30.0) {
        return 1; # OK
    }

    my ($file) = grep -f, qw(
        dist/PathTools/Cwd.pm
        dist/Cwd/Cwd.pm
        cpan/Cwd/Cwd.pm
        lib/Cwd.pm
    );
    die "Missing Cwd.pm" if !$file;

    warn "patching $file\n";

    my $find = q[my $start = @_ ? shift : '.';];
    open my $in, "<", $file or die;
    open my $out, ">", "$file.tmp" or die;
    while (my $l = <$in>) {
        print {$out} $l;
        if ($l =~ /\Q$find\E/) {
            print {$out} q[    if ($start eq ".") { return _backtick_pwd() } # XXX patched by Devel-PatchPerl-Plugin-getcwd], "\n";
        }
    }
    close $in;
    close $out;
    rename "$file.tmp", $file or die "rename $!";
    return 1;
}


1;
__END__

=encoding utf-8

=head1 NAME

Devel::PatchPerl::Plugin::getcwd - use pwd command in macOS

=head1 SYNOPSIS

  env PERL5_PATCHPERL_PLUGIN=getcwd patchperl

=head1 DESCRIPTION

macOS has a bug described in https://gist.github.com/skaji/84a4ea75480298f839f7cf4adcc109c9
As a result, building perl 5.28.0 or below constantly fails.

This plugin adds a workaround so that we use C<pwd> to get the current directory.

=head1 COPYRIGHT AND LICENSE

Copyright 2022 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
