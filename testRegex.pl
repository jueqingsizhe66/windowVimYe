#!/usr/bin/env perl
#===============================================================================
#
#         FILE: testRegex.pl
#
#        USAGE: ./testRegex.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Ye Zhao Liang (YZL), yezhaoliang@ncepu.edu.cn
# ORGANIZATION: NCEPU
#      VERSION: 1.0
#      CREATED: 2018/8/29 9:02:49
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;


my  $source="I have a string: 34.5 then -34.5 , also -34.5E6 or -34.56e6, finally 34.5E+10 or 34.5E-10";


while ( $source =~ m/(\-?\d+(\.\d+)?([e|E][+|-]?\d+)?)/xgm ) {
    print "$1\n";
}

print $_,"\n" foreach split / /,$source;
