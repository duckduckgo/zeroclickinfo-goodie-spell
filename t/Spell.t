#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use DDG::Test::Goodie;

zci answer_type => 'spell';
zci is_cached => 1;

ddg_goodie_test(
	[qw(
		DDG::Goodie::Spell
	)],
	'spell foo' => test_zci(qr/'Foo' appears to be spelled right!  Suggestions: .+/, html => qr|'Foo' appears to be spelled right!<br/>Suggestions: .+|),
	'how do I spell foo' => test_zci(qr/'Foo' appears to be spelled right!  Suggestions: .+/, html => qr|'Foo' appears to be spelled right!<br/>Suggestions: .+|),
	'spellcheck hllo' => test_zci(qr/'Hllo' does not appear to be spelled correctly.  Suggestions: .+/, html => qr|'Hllo' does not appear to be spelled correctly.<br/>Suggestions: .+|),
);

done_testing;

