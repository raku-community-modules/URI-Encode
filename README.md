# URI::Encode [![Tests on source](https://github.com/raku-community-modules/URI-Encode/actions/workflows/test.yaml/badge.svg)](https://github.com/raku-community-modules/URI-Encode/actions/workflows/test.yaml)

A Raku module for encoding / decoding URIs

# Synopsis

    use URI::Encode;

    # for encoding whole URIs, ignores reserved chars: :/?#[]@!$&'()*+,;=
    my $encoded_uri = uri_encode('http://www.example.com/?name=john doe&age=54');

    # encode every reserved char
    my $encoded_uri_component = uri_encode_component('some text/to encode+ safely');

    # remove percent encoding
    my $decoded_uri = uri_decode('http://www.example.com/?name=john%20doe&age=54');

    # provided for symmetry, is the same as uri_decode()
    my $decoded_component = uri_decode_component('some%20text%2Fto%20%2B%20safely');

## Author

David Farrell, 2015; lately maintained by the Raku community adoption center.

## License

FreeBSD - see [LICENSE](LICENSE)

