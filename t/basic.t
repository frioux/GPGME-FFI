#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use GPGME::FFI;

is(
   gpgme_get_protocol_name(GPGME_PROTOCOL_OpenPGP),
   'OpenPGP',
   'gpgme_get_protocol_name',
);

is(
   gpgme_engine_check_version(GPGME_PROTOCOL_OpenPGP),
   GPGME_ERR_NO_ERROR,
   'gpgme_get_protocol_name',
);

like(gpgme_strerror(GPGME_ERR_GENERAL), qr/general/i, 'gpgme_strerror');

is(
   gpgme_pubkey_algo_name(GPGME_PK_RSA),
   'RSA',
   'gpgme_pubkey_algo_name',
);

done_testing;
