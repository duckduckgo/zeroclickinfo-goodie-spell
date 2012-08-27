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
	'spell foo' => test_zci(qr/'Foo' appears to be spelled correctly!  Suggestions: .+/, html => qr|<b>Foo</b> appears to be spelled correctly!<br/><i>Suggestions: </i>.+|),
	'how do I spell foo' => test_zci(qr/'Foo' appears to be spelled correctly!  Suggestions: .+/, html => qr|<b>Foo</b> appears to be spelled correctly!<br/><i>Suggestions: </i>.+|),
	'spellcheck hllo' => test_zci(qr/'Hllo' does not appear to be spelled correctly.  Suggestions: .+/, html => qr|<b>Hllo</b> does not appear to be spelled correctly.<br/><i>Suggestions: </i>.+|),
);

done_testing;

