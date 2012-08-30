#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Fatal;

use mop;

=pod

...

=cut

class Foo {
    has $bar;
    method bar { $bar }

    method has_bar      { defined $bar }
    method set_bar ($b) { $bar = $b  }
    method init_bar     { $bar = 200 }
    method clear_bar    { undef $bar }
}

{
    my $foo = Foo->new;
    ok( $foo->isa( Foo ), '... the object is from class Foo' );

    ok(!$foo->has_bar, '... no bar is set');
    is($foo->bar, undef, '... values are undefined when they are not initialized');

    is(exception{ $foo->init_bar }, undef, '... initialized bar without error');
    ok($foo->has_bar, '... bar is set');
    is($foo->bar, 200, '... value is initialized by the init_bar method');

    is(exception{ $foo->set_bar(1000) }, undef, '... set bar without error');
    ok($foo->has_bar, '... bar is set');
    is($foo->bar, 1000, '... value is set by the set_bar method');

    is(exception{ $foo->clear_bar }, undef, '... set bar without error');
    ok(!$foo->has_bar, '... no bar is set');
    is($foo->bar, undef, '... values has been cleared');
}

{
    my $foo = Foo->new( bar => 10 );
    ok( $foo->isa( Foo ), '... the object is from class Foo' );

    ok($foo->has_bar, '... a bar is set');
    is($foo->bar, 10, '... values are initialized via the constructor');

    is(exception{ $foo->init_bar }, undef, '... initialized bar without error');
    ok($foo->has_bar, '... bar is set');
    is($foo->bar, 200, '... value is initialized by the init_bar method');

    is(exception{ $foo->set_bar(1000) }, undef, '... set bar without error');
    ok($foo->has_bar, '... bar is set');
    is($foo->bar, 1000, '... value is set by the set_bar method');

    is(exception{ $foo->clear_bar }, undef, '... set bar without error');
    ok(!$foo->has_bar, '... no bar is set');
    is($foo->bar, undef, '... values has been cleared');
}


done_testing;
