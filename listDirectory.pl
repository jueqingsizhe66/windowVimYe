#!/usr/bin/env perl
#===============================================================================
#
#         FILE: listDirectory.pl
#
#        USAGE: ./listDirectory.pl  
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
#      CREATED: 2017/12/12 11:51:02
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

my @lines   = `ls -ls`;

foreach  ( @lines ) {
    print;
}
