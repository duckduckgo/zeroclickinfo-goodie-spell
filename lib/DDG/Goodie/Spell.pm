package DDG::Goodie::Spell;
# ABSTRACT: Spellcheck and return spelling suggestions

use DDG::Goodie;
use Text::Aspell;

triggers start => "spell", "how to spell", "how do i spell", "spellcheck";

zci is_cached => 1;

my $speller = Text::Aspell->new;
$speller->set_option('lang','en_US'); 
$speller->set_option('sug-mode','fast');

attribution 
    twitter => 'crazedpsyc',
    cpan    => 'CRZEDPSYC'
;

handle remainder => sub {
    return unless /^[a-z']+$/; # only accept letters and ' (aspell handles contractions)
    my $correct = $speller->check($_) ? "'\u$_' appears to be spelled correctly!" : "'\u$_' does not appear to be spelled correctly.";
    my $correct_html = $correct;
    $correct_html =~ s{^'(.+?)'}{<b>$1</b>};

    my @suggestions = $speller->suggest($_);
    my $end = $#suggestions >= 5 ? 5 : $#suggestions;
    my $sug = @suggestions ? "Suggestions: " . join(', ', @suggestions[0..$end]) : "No suggestions.";
    my $sug_html = $sug;
    $sug_html =~ s{Suggestions: }{<i>Suggestions: </i>};
    return "$correct  $sug.", html => "$correct_html<br/>$sug_html.";
};

1;
