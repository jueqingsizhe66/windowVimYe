#!/usr/bin/env perl
#===============================================================================
#
#         FILE: testGonghan.pl
#
#        USAGE: ./testGonghan.pl  
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
#      CREATED: 2018/8/14 16:01:34
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;


print "*****************************modfiy letter*************************************\n";
my  $message='
DEAR =FIRST=,
You have been chosen to win a brand new =TRINKET=! Free!
Could you use another =TRINKET= in the =FAMILY= household?
Yes =SUCKER=, I bet you could! Just respond by ...';


my  $given ="Tom";
my  $family = "Cruise";
my  $wunderprize = "100% genuine faux diamond";

$message =~ s/=FIRST=/$given/xgm;
$message =~ s/=FAMILY=/$family/gxm;
$message =~ s/=SUCKER=/$given $family/xgm;
$message =~ s/=TRINKET=/fabulous $wunderprize/xmg;

print "$message\n";

print "**************************Modify price**************************************\n";
my  $price=12.45343000624;
my  $price1 = 12.350;
print "Original price \$price  =$price \t \$price1 = $price1\n";
$price =~ s/(\.\d\d[1-9]?)\d*/$1/xm;
$price1 =~ s/(\.\d\d[1-9]?)\d*/$1/xm;

print "Update price \$price  =$price \t \$price1 = $price1\n";

print "**********************************************Extract letter info*************************************\n";
my  $letterString='
From ncepu mail stock 2019 
To: jfreid@regex.info (Jeffrey Friedl)
From: yezhaoliang@ncepu.edu.cn (Ye Zhaoliang)
Date: Thu, Aug 14 2018 15:33
Subject: Look around and Look before
Reply-To: yezhaoliang@ncepu.edu.cn

Sorry I haven\'t been around lately. A few years back I look at a pile of 
bright character housees, which is used to cross the cliff and mountain.
The duke say "Hi".
    Ye Zhaoliang
';

my  $letter;

# my  $date='undef';
# my  $reply_address='undef';
# my  $subject='undef';
#my  $from_name='undef';
my  $from_name;
my  $date;
my  $reply_address;
my  $subject;

my	$letterFile_file_name = 'letter.md';		# input file name

open  my $letterFile, '<', $letterFile_file_name
    or die  "$0 : failed to open  input file '$letterFile_file_name' : $!\n";

# 由于pos限制，所以From得放在前头, Subject放在最后
#if ( $letter =~ m/^From: (\s+) \(([^()]*)\)/ixg ) {

while ( $letter=<$letterFile> ) {
    if ( $letter =~ m/^From:\s*(\S+)\s*\(([^()]*)\)$/ixg ) {
    #if ( $letter =~ m/^From:\s*(\S+)\s*(?<=\()([^()]*)(?=\))$/ixg ) {
    $reply_address =$1;
    $from_name =$2;
}elsif ( $letter =~ m/^Date:\s*(.*)$/ixg ) {
#if ( $letter =~ m/Date: (.*)/ixg ) {
#针对文件使用 尖角 和dollar符号
    $date=$1;
}elsif (  $letter =~ m/^Reply-To:\s*(\S+)$/ixg) {
    #if (  $letter =~ m/Reply-To: (\S+)/ixg) {
    $reply_address=$1;
}elsif ( $letter =~ m/^Subject:\s*(.*)$/ixg ) {
    #if ( $letter =~ m/Subject: (.*)/ixg ) {
    $subject=$1;
}


}
print " \$subject=$subject \n \$date=$date \n \$reply_address=$reply_address \n \$from_name=$from_name\n";

print "****************************New letter info********************************\n";
print "To: $reply_address ($from_name)\n";
print "Subject: Re: $subject \n"; ## Re表示一封回信
print "\n"; #Black line


if ( not defined($reply_address)
    or not defined($from_name)
    or not defined($reply_address)
    or not defined($subject)) {
    die "Couldn't glean the required info"
}
close  $letterFile
    or warn "$0 : failed to close input file '$letterFile_file_name' : $!\n";


