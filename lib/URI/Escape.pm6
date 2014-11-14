module URI::Escape
{
    # build two arrays of reserved encoded chars
    # use arrays because straight-up hash transliteration only
    # replaces 1 char on either side. E.g. " " becomes % not %20
    my $RFC3986_unreserved = /<[0..9A..Za..z\-.~]>/;

    my (@escape_chars, @escape_encoding);
    for (0..255) {
        next if chr($_) ~~ /$RFC3986_unreserved/;
        @escape_chars.push(chr($_));
        @escape_encoding.push(sprintf("%%%02X", $_));
    }

    sub uri_escape ($text!) is export
    {
        return $text.trans(@escape_chars => @escape_encoding);
    }
}
