package Hash::Subset;

# DATE
# VERSION

use strict;
use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(hash_subset hashref_subset);

sub hash_subset {
    my ($hash, $keys_src) = @_;

    my %res;
    my $ref = ref $keys_src;
    if ($ref eq 'ARRAY') {
        for (@$keys_src) {
            $res{$_} = $hash->{$_} if exists $hash->{$_};
        }
    } elsif ($ref eq 'HASH') {
        for (keys %$keys_src) {
            $res{$_} = $hash->{$_} if exists $hash->{$_};
        }
    } else {
        die "Second argument (keys_src) must be a hashref/arrayref";
    }
    %res;
}

sub hashref_subset {
    my ($hash, $keys_src) = @_;

    my $res = {};
    my $ref = ref $keys_src;
    if ($ref eq 'ARRAY') {
        for (@$keys_src) {
            $res->{$_} = $hash->{$_} if exists $hash->{$_};
        }
    } elsif ($ref eq 'HASH') {
        for (keys %$keys_src) {
            $res->{$_} = $hash->{$_} if exists $hash->{$_};
        }
    } else {
        die "Second argument (keys_src) must be a hashref/arrayref";
    }
    $res;
}

1;
# ABSTRACT: Produce subset of a hash

=head1 SYNOPSIS

 use Hash::Subset qw(hash_subset hashref_subset);

 # using keys specified from an array
 my %h = hash_subset   ({a=>1, b=>2, c=>3}, ['b','c','d']); # => (b=>2, c=>3)
 my $h = hashref_subset({a=>1, b=>2, c=>3}, ['b','c','d']); # => {b=>2, c=>3}

 # using keys specified from another hash
 my %h = hash_subset   ({a=>1, b=>2, c=>3}, {b=>20, c=>30, d=>40}); # => (b=>2, c=>3)
 my $h = hashref_subset({a=>1, b=>2, c=>3}, {b=>20, c=>30, d=>40}); # => {b=>2, c=>3}


=head1 DESCRIPTION


=head1 FUNCTIONS

None exported by default.

=head2 hash_subset

Usage:

 my %hash    = hash_subset   (\%hash, \@keys);
 my $hashref = hashref_subset(\%hash, \@keys);
 my %hash    = hash_subset   (\%hash, \%another_hash);
 my $hashref = hashref_subset(\%hash, \%another_hash);

Produce subset of C<%hash>, returning the subset hash (or hashref, in the case
of C<hashref_subset> function).

=head2 hashref_subset

See L</hash_subset>.


=head1 SEE ALSO

Some other hash utilities: L<Hash::MostUtils>

=cut
