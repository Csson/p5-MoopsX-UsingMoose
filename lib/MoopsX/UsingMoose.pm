use 5.14.0;
use strict;
use warnings;

package MoopsX::UsingMoose;

# ABSTRACT: A Moops that uses Moose
# AUTHORITY
our $VERSION = '0.0104';

use base 'Moops';

sub import {
    my $class = shift;
    my %opts = @_;

    push @{ $opts{'traits'} ||= [] } => (
        'MoopsX::TraitFor::Parser::UsingMoose',
    );
    $class->SUPER::import(%opts);
}

1;

__END__

=pod

=head1 SYNOPSIS

    use MoopsX::UsingMoose;

    class My::Class {

        # A Moose based class

    }

=head1 STATUS

Do note the inherent L<issues|Moops/"STATUS"> with using L<Moops>.

=head1 DESCRIPTION

This is a thin wrapper around L<Moops> that automatically adds C<using Moose> to C<role> and C<class> statements. It does this by applying the included L<MoopsX::TraitFor::Parser::UsingMoose> C<Moops::Parser> trait.


=head2 Rationale

While this on the surface doesn't save any keystrokes it reduces cluttering of C<role>/C<class> statements. Consider the following:

    use Moops;

    class My::Project::Class
    types Types::Standard,
          Types::Path::Tiny,
          Types::MyCustomTypes
     with This::Role
    using Moose {

        # A Moose based class

    }

That is not very nice.

The first step is to get rid of C<using Moose>:

    use MoopsX::UsingMoose;

    class My::Project::Class
    types Types::Standard,
          Types::Path::Tiny,
          Types::MyCustomTypes
     with This::Role {

        # A Moose based class

    }

A minor improvement.

However, create a project specific L<Moops wrapper|Moops/"Extending-Moops-via-imports">:

    package My::Project::Moops;
    use base 'MoopsX::UsingMoose';

    use Types::Standard();
    use Types::Path::Tiny();
    use Types::MyCustomTypes();

    sub import {
        my $class = shift;
        my %opts = @_;

        push @{ $opts{'imports'} ||= [] } => (
            'Types::Standard' => ['-types'],
            'Types::Path::Tiny' => ['-types'],
            'Types::MyCustomTypes' => ['-types'],
        );

        $class->SUPER::import(%opts);
    }

And the C<class> statement becomes:

    use My::Project::Moops;

    class My::Project::Class with This::Role {

        # A Moose based class, still with all the types

    }

Happiness ensues.

=head1 SEE ALSO

=for :list
* L<Moops>
* L<Moose>
* L<Moo>

=cut
