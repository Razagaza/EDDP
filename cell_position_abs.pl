#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc = $Documents{"adenosine_Fe.xsd"};

my $element;
for (@{$doc->DisplayRange->Atoms}) {
	push @{$element->{$_->ElementSymbol}}, $_->XYZ;
}

for my $k (sort(keys %$element)) {
	for (@{$element->{$k}}) {
		print "$k $_->{X} $_->{Y} $_->{Z} # 1-ade\n"
	}
}
