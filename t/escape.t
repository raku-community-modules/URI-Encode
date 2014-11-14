use v6;
use Test;
use lib './lib';
use URI::Encode;

plan 12;

is uri_encode("  "), "%20%20";
is uri_encode("|abcå"), "%7Cabc%E5";
is uri_encode("abc"), "abc";
is uri_encode("~*'()"), "~%2A%27%28%29";
is uri_encode("<\">"), "%3C%22%3E";
is uri_encode(Nil), Nil;

is uri_decode("%20%20"), "  ";
is uri_decode("%7Cabc%E5"),"|abcå";
is uri_decode("abc"), "abc";
is uri_decode("~%2A%27%28%29"), "~*'()";
is uri_decode("%3C%22%3E"), "<\">";
is uri_decode(Nil), Nil;