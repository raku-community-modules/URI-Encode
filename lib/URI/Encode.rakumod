use v6.c;  # required for correct execution

my $RFC3986_unreserved := rx/<[0..9A..Za..z\-.~_]>/;
my $RFC3986_reserved   := rx/<[:/?#\[\]@!$&'()*+,;=]>/;

# for uri_decode
my %escapes = (^256).map: {
    sprintf("%%%02X", $_) => chr($_)
      unless chr($_) ~~ /$RFC3986_unreserved/;
}

my sub enc (Str:D $m) {
    $m.encode.list.map(*.fmt('%%%02X')).join
}

sub uri_encode (Str:D $text) is export {
    $text.comb.map({
        if $RFC3986_unreserved || $RFC3986_reserved {
            $_
        }
        else {
            &enc($_)
        }
    }).join
}

sub uri_encode_component (Str:D $text) is export {
    $text.comb.map({
        if $RFC3986_unreserved {
            $_
        }
        else {
            enc($_)
        }
    }).join
}

my sub dec ($m) {
    Buf.new($m<bit>.list.map({:16($_.Str)})).decode
}

sub uri_decode (Str:D $text) is export {
    $text.subst(/[\%$<bit>=[<[0..9A..Fa..f]>** 2]]+/, &dec, :g)
}

sub uri_decode_component (Str:D $text) is export {
    $text.subst(/[\%$<bit>=[<[0..9A..Fa..f]>** 2]]+/, &dec, :g)
}

=begin pod

=head1 NAME

URI::Encode - a Raku module for encoding / decoding URIs

=head1 SYNOPSIS

=begin code :lang<raku>

use URI::Encode;

# for encoding whole URIs, ignores reserved chars: :/?#[]@!$&'()*+,;=
my $encoded_uri = uri_encode('http://www.example.com/?name=john doe&age=54');

# encode every reserved char
my $encoded_uri_component = uri_encode_component('some text/to encode+ safely');

# remove percent encoding
my $decoded_uri = uri_decode('http://www.example.com/?name=john%20doe&age=54');

# provided for symmetry, is the same as uri_decode()
my $decoded_component = uri_decode_component('some%20text%2Fto%20%2B%20safely');

=end code

=head1 DESCRIPTION

URI::Encode is a module that exports four subroutines:

=item uri_encode - encode a whole URI
=item uri_encode_component - encode every reserved char
=item uri_decode - decode a whole URI
=item uri_decode_component - decode every reserved char

=head1 SEE ALSo

L<C<URI>|https://raku.land/github:raku-community-modules/URI> is another
implementation that covers this area, including encoding and decoding of
URIs.

=head1 AUTHOR

David Farrell

=head1 COPYRIGHT AND LICENSE

Copyright 2014 - 2015 David Farrell

Copyright 2016 - 2024 Raku Community

This library is free software; you can redistribute it and/or modify it under the FreeBSD license.

=end pod

# vim: expandtab shiftwidth=4
