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


https://randu.org/tutorials/perl/records.php
https://metacpan.org/pod/Search::Elasticsearch


Given: User is a concert promoter subscribes to all concert events in Australia.
When:  Any artist tours Australia
Then:  User will be notified with concert details.

Given: User interested in Australian concert events that match their spotify playlist.
When:  Artic Monkeys tours Australia in March 2019 
Then:  User will be automatically notified with concert details.

Given: Elton John, Eninem have announced their 2019 Australian tour back in 2018.
When:  User adds Elton John, Eninem in their spotify playlist.
Then:  User will receive past notifications for upcoming concerts.
       e.g. Elton John concert Dec 2019   
       but not Eninem 27 Feb 2019 (concert finished)
        
Given: User is a subscriber to concert events.
When:  Any artist announces updates to their concert tour.
Then:  User will receive update notifications.
       User will receive notifications once and only, ie no duplications.
