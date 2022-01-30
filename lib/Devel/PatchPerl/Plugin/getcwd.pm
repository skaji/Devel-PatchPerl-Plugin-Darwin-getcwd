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

Devel::PatchPerl::Plugin::getcwd - blah blah blah

=head1 SYNOPSIS

  use Devel::PatchPerl::Plugin::getcwd;

=head1 DESCRIPTION

Devel::PatchPerl::Plugin::getcwd is

=head1 COPYRIGHT AND LICENSE

Copyright 2022 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
