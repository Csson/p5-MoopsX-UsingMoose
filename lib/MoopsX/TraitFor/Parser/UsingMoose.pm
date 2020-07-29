use 5.14.0;
use strict;
use warnings;

package MoopsX::TraitFor::Parser::UsingMoose;

# ABSTRACT: A Moops::Parser traits that sets 'using Moose'
# AUTHORITY
our $VERSION = '0.0104';

use Moo::Role;

after parse => sub {
    shift->relations->{'using'} = ['Moose'];
};

1;

__END__

=pod

=head1 SYNOPSIS

    use Moops traits => ['MoopsX::TraitFor::Parser::UsingMoose'];

    class My::Class {

        # This is a Moose class

    }

=head1 DESCRIPTION

This class is a trait for L<Moops::Parser> that automatically sets 'using Moose' on C<role> and C<class> statements.

But use L<MoopX::UsingMoose> instead.

=cut
