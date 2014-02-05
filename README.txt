WWW-Kickstarter

~~~


INSTALLATION

To install this module, run the following commands:

    perl Build.PL
    ./Build
    ./Build test
    ./Build install


DEPENDENCIES

This module requires these other modules and libraries:

    Module::Build    (For installation only)
    FindBin          (For testing only)
    Test::More       (For testing only)
    autovivification
    Carp
    overload
    Time::HiRes
    URI
    URI::Escape
    URI::QueryParam
    version

    The default HTTP client requires the following:
        HTTP::Headers
        HTTP::Request::Common
        LWP::Protocol::https
        LWP::UserAgent

    The default JSON parser requires the following:
        JSON::XS


SUPPORT AND DOCUMENTATION

After installing, you can find documentation for this module with the
perldoc command.

    perldoc WWW::Kickstarter

You can also look for information at:

    RT, CPAN's request tracker
        http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Kickstarter

    AnnoCPAN, Annotated CPAN documentation
        http://annocpan.org/dist/WWW-Kickstarter

    CPAN Ratings
        http://cpanratings.perl.org/d/WWW-Kickstarter

    Search CPAN
        http://search.cpan.org/dist/WWW-Kickstarter


COPYRIGHT AND LICENCE

No rights reserved.

The author has dedicated the work to the Commons by waiving all of his
or her rights to the work worldwide under copyright law and all related or
neighboring legal rights he or she had in the work, to the extent allowable by
law.

Works under CC0 do not require attribution. When citing the work, you should
not imply endorsement by the author.
