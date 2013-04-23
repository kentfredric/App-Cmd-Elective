use strict;
use warnings;

package App::Cmd::Elective;
BEGIN {
  $App::Cmd::Elective::AUTHORITY = 'cpan:KENTNL';
}
{
  $App::Cmd::Elective::VERSION = '0.1.0';
}

# ABSTRACT: load only ::Command::* from a whitelist

use parent 'App::Cmd::Setup';
use Moose::Util;

require App::Cmd::Base::Elective;

sub _app_base_class { 'App::Cmd::Base::Elective' }



1;

__END__

=pod

=encoding utf-8

=head1 NAME

App::Cmd::Elective - load only ::Command::* from a whitelist

=head1 VERSION

version 0.1.0

=head1 SYNOPSIS

If you have an existing App which uses App::Cmd and you want to add whitelist only
support, a simple change is required:

    diff:

    -use App::Cmd::Setup -app
    +use App::Cmd::Elective -app

    +sub app_commands {
    +   qw( foo bar )
    +}

The function C<app_commands> returns a list of commandlets to load. ( In additional to any defaults provided by App::Cmd ).

Note: Note these are B<NOT> nessecarily the same as the CLI command names, but these are the "providing module" names, which are expanded based upon the value of L<< C<plugin_search_path>|App::Cmd/plugin_search_path >>, and then the resulting command name is based on the individual modules values of L<< C<command_names>|App::Cmd::Command/command_names >>

Otherwise, except for this minor difference, usage should be identical to that of App::Cmd's standard behaviour

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
