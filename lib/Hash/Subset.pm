package Hash::Subset;

# DATE
# VERSION

use strict;
use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(hash_subset hashref_subset);

sub hash_subset {
    my ($hash, $keys_src) = @_;

    my %subset;
    my $ref = ref $keys_src;
    if ($ref eq 'ARRAY') {
        for (@$keys_src) {
            $subset{$_} = $hash->{$_} if exists $hash->{$_};
        }
    } elsif ($ref eq 'HASH') {
        for (keys %$keys_src) {
            $subset{$_} = $hash->{$_} if exists $hash->{$_};
        }
    } else {
        die "Second argument (keys_src) must be a hashref/arrayref";
    }
    %subset;
}

sub hashref_subset {
    my ($hash, $keys_src) = @_;

    my $subset = {};
    my $ref = ref $keys_src;
    if ($ref eq 'ARRAY') {
        for (@$keys_src) {
            $subset->{$_} = $hash->{$_} if exists $hash->{$_};
        }
    } elsif ($ref eq 'HASH') {
        for (keys %$keys_src) {
            $subset->{$_} = $hash->{$_} if exists $hash->{$_};
        }
    } else {
        die "Second argument (keys_src) must be a hashref/arrayref";
    }
    $subset;
}

1;
# ABSTRACT: Produce subset of a hash

=head1 SYNOPSIS

 use Hash::Subset qw(hash_subset hashref_subset);

 # using keys specified in an array
 my %subset = hash_subset   ({a=>1, b=>2, c=>3}, ['b','c','d']); # => (b=>2, c=>3)
 my $subset = hashref_subset({a=>1, b=>2, c=>3}, ['b','c','d']); # => {b=>2, c=>3}

 # using keys specified in another hash
 my %subset = hash_subset   ({a=>1, b=>2, c=>3}, {b=>20, c=>30, d=>40}); # => (b=>2, c=>3)
 my $subset = hashref_subset({a=>1, b=>2, c=>3}, {b=>20, c=>30, d=>40}); # => {b=>2, c=>3}


=head1 DESCRIPTION


=head1 FUNCTIONS

None exported by default.

=head2 hash_subset

Usage:

 my %subset  = hash_subset   (\%hash, \@keys);
 my $subset  = hashref_subset(\%hash, \@keys);
 my %subset  = hash_subset   (\%hash, \%another_hash);
 my $subset  = hashref_subset(\%hash, \%another_hash);

Produce subset of C<%hash>, returning the subset hash (or hashref, in the case
of C<hashref_subset> function).

Perl lets you produce a hash subset using the hash slice notation:

 my %subset = %hash{"b","c","d"};

The difference with C<hash_subset> is: 1) hash slice is only available since
perl 5.20 (in previous versions, only array slice is available); 2) when the key
does not exist in the array, perl will create it for you with C<undef> as the
value:

 my %hash   = (a=>1, b=>2, c=>3);
 my %subset = %hash{"b","c","d"}; # => (b=>2, c=>3, d=>undef)

So basically C<hash_subset> is equivalent to:

 my %subset = %hash{grep {exists $hash{$_}} "b","c","d"}; # => (b=>2, c=>3)

and available for perl earlier than 5.20.


=head2 hashref_subset

See L</hash_subset>.


=head1 SEE ALSO

Some other hash utilities: L<Hash::MostUtils>

=cut
