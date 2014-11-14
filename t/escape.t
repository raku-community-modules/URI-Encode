use v6;
use Test;
use lib './lib';
use URI::Escape;

plan 6;

is uri_escape("  "), "%20%20";
is uri_escape("|abcå"), "%7Cabc%E5";
is uri_escape("abc"), "abc";
is uri_escape("~*'()"), "~%2A%27%28%29";
is uri_escape("<\">"), "%3C%22%3E";
is uri_escape(Nil), Nil;

