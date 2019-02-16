# prove


https://perlmaven.com/testing-a-simple-perl-module

perl -Ilib t/lib/Math.t

prove -l t/lib/Math.t

MAX@MAX-PC MINGW64 /e/git/prove (master)
$ prove -l t/01_compute.t
t/01_compute.t .. ok
All tests successful.
Files=1, Tests=2,  0 wallclock secs ( 0.16 usr  0.14 sys +  0.05 cusr  0.08 csys =  0.42 CPU)
Result: PASS
