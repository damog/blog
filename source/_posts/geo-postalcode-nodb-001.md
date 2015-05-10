title: "Geo::PostalCode::NoDB 0.01"
Date: 2012-03-21 11:19:17
Tags: berkeley db,cpan,hack,perl,postal code,zipcodes
---
<a href="https://metacpan.org/module/Geo::PostalCode">Geo::PostalCode</a> is a great Perl module. It lets you find surrounding postal areas (zip codes) around a given an amount of miles (radius), calculate distance between them, among other nice features. Sadly, I couldn't get it to work with updated data and because the file its Berkely DB installer was producing was not being recognized by its parser, which bases off on <a href="http://perldoc.perl.org/DB_File.html">DB_File</a>. Since I was able to find <a href="http://damog.net/files/misc/zipcodes-csv-10-Aug-2004.zip">working data</a> for the source of zip codes, I ended up hacking the module and producing a version with no Berkeley DB support.

So basically, and taken from the POD:
<blockquote>RATIONALE BEHIND NO BERKELEY DB
On a busy day at work, I couldn't get Geo::PostalCode to work with newer data (the data source <a href="http://search.cpan.org/~tjmather/">TJMATHER</a> points <a href="http://cpansearch.perl.org/src/TJMATHER/Geo-PostalCode-0.07/INSTALL">to</a> is no longer available), so the tests shipped with his module pass, but trying to use real data no longer seems to work. DB_File marked the <a href="http://search.cpan.org/~tjmather/Geo-PostalCode-0.07/lib/Geo/PostalCode/InstallDB.pm">Geo::PostalCode::InstallDB</a> output file as invalid type or format. If you don't run into that issue by not wanting to use this module, please drop <a href="http://damog.net/">me</a> a note! I would love to learn how other people made it work.

So, in order to get my shit done, I decided to create this module. Loading the whole data into memory from the class constructor has been proven to be enough for massive usage (citation needed) on a <a href="http://perldancer.org">Dancer</a> application where this module is instantiated only once.</blockquote>
<tt>$ sudo cpanm <a href="https://metacpan.org/module/DAMOG/Geo-PostalCode-NoDB-0.01/lib/Geo/PostalCode/NoDB.pm">Geo::PostalCode::NoDB</a></tt> now!