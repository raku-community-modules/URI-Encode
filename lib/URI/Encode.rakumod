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

# vim: expandtab shiftwidth=4
