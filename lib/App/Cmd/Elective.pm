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

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
