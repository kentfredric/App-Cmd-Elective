use strict;
use warnings;

package App::Cmd::Base::Elective;
BEGIN {
  $App::Cmd::Base::Elective::AUTHORITY = 'cpan:KENTNL';
}
{
  $App::Cmd::Base::Elective::VERSION = '0.1.0';
}

use parent 'App::Cmd';

use Module::Runtime qw( compose_module_name module_notional_filename );

my $scanner;
sub _inc_scanner {
    return $scanner if defined $scanner;
    require Path::ScanINC;
    return ( $scanner = Path::ScanINC->new() );
}
sub _expand_plugin_name {
    my ( $self, $plugin_name ) = @_;
    my ( @search_path ) = @{ $self->plugin_search_path };
    my ( @tried ) = ();
    for my $search_path_element ( @search_path ) { 
        my $module_name = compose_module_name( $search_path_element, $plugin );
        my $nn          = module_notional_filename( $module_name );
        push @tried, $module_name;
        if ( exists $INC{$nn} ){
            return $module_name;
        }
         my $first_file  = $self->_inc_scanner->first_file(split '/', module_notational_filename( $module_name ) );
         if ( defined $first_file and -e $first_file ) {
            return $module_name;
         }
    }
    my $message = 'Sorry, no plugin named <<' . $plugin_name . qq[>> could be found\n];
    $message .= qq[We tried the following expansions:\n];
    $message .= qq[\t$_\n] for @tried;
    $message .= qq[\@INC contains:\n];
    $message .= qq[\t$_\n] for @{ $self->_inc_scanner->inc };
    require Carp;
    Carp::croak($message);
}



my %plugins_for;

sub _plugins {
    my ( $self ) = @_; 
    my $class = ref $self || $self;

    return @{ $plugins_for{$class}} if $plugins_for{ $class };

    if ( not $class->can('app_plugins') ) {
        require Carp;
        Carp::croak('Class <<' . $class . '>> lacks required method << app_plugins >>');
    }
    my $scanner = Path::ScanINC->new( );

    my @plugins;
    my ( @search_path ) = @{ $self->plugin_search_path };
    for my $plugin ( $self->app_plugins ) {
        push @plugins, $self->_expand_plugin_name( $plugin );
    }
    return @plugins; 
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

App::Cmd::Base::Elective

=head1 VERSION

version 0.1.0

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
