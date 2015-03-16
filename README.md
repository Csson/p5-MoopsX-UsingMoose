# NAME

MoopsX::UsingMoose - A Moops that uses Moose

# VERSION

Version 0.0001, released 2015-03-16.

# SYNOPSIS

    use MoopsX::UsingMoose;

    class My::Class {

        # A Moose based class

    }

# DESCRIPTION

This is a thin wrapper around [Moops](https://metacpan.org/pod/Moops) that automatically adds `using Moose` to `role` and `class` statements. It does this by applying the included [MoopsX::TraitFor::Parser::UsingMoose](https://metacpan.org/pod/MoopsX::TraitFor::Parser::UsingMoose) `Moops::Parser` trait.

## Rationale

While this on the surface doesn't save any keystrokes it reduces cluttering of `role`/`class` statements. Consider the following:

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

The first step is to get rid of `using Moose`:

    use MoopsX::UsingMoose;

    class My::Project::Class
    types Types::Standard,
          Types::Path::Tiny,
          Types::MyCustomTypes
     with This::Role {

        # A Moose based class

    }

A minor improvement.

However, create a project specific [Moops wrapper](https://metacpan.org/pod/Moops#Extending-Moops-via-imports):

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

And the `class` statement becomes:

    use My::Project::Moops;

    class My::Project::Class with This::Role {

        # A Moose based class, still with all the types

    }

Happiness ensues.

# SEE ALSO

- [Moops](https://metacpan.org/pod/Moops)
- [Moose](https://metacpan.org/pod/Moose)
- [Moo](https://metacpan.org/pod/Moo)

# SOURCE

[https://github.com/Csson/p5-MoopsX-UsingMoose](https://github.com/Csson/p5-MoopsX-UsingMoose)

# HOMEPAGE

[https://metacpan.org/release/MoopsX-UsingMoose](https://metacpan.org/release/MoopsX-UsingMoose)

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Erik Carlsson <info@code301.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
