#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use GPGME::FFI;

my $info = GPGME::FFI::EngineInfo->new;
my $error = gpgme_get_engine_info($info);
my $protocol_count = 0;

die "Error getting engine info: " . gpgme_strerror($error) if $error;
my @info;

while($info = $info->next) {
   push @info, $info;

   no warnings 'uninitialized';
   $protocol_count++;

   note(
      join "\n",
      "---",
      "  protocol:    " . gpgme_get_protocol_name($info->protocol),
      "  file_name:   " . $info->file_name,
      "  version:     " . $info->version,
      "  req_version: " . $info->req_version,
      "  home_dir:    " . $info->home_dir,
   );
}

ok $protocol_count, 'at least one protocol supported';

gpgme_set_engine_info(
   GPGME_PROTOCOL_OpenPGP,
   '/foo/bar',
   '/baz',
);


for my $info (@info) {
   no warnings 'uninitialized';

   note(
      join "\n",
      "---",
      "  protocol:    " . gpgme_get_protocol_name($info->protocol),
      "  file_name:   " . $info->file_name,
      "  version:     " . $info->version,
      "  req_version: " . $info->req_version,
      "  home_dir:    " . $info->home_dir,
   );
}

done_testing;
