#!/usr/bin/perl
# hello.pl by Bill Weinman <http://bw.org/contact/>

use 5.18.0;
use warnings;
use MIME::Base64;

say "Hello, World!";


 # my $encoded = encode_base64('Aladdin:open sesame', "");
 my $encoded = encode_base64('www.python.org', "");
 
 print "$encoded";
 print "*************************\n";
 
my $decoded = decode_base64($encoded);
print "$decoded";
print "*************************\n";