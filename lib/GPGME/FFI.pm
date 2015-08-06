package GPGME::FFI;

use strict;
use warnings;

BEGIN {
   use FFI::Platypus::Declare qw( string );
   use FFI::CheckLib;

   lib find_lib_or_die lib => 'gpgme';

   # https://www.gnupg.org/documentation/manuals/gpgme/Protocols-and-Engines.html#Protocols-and-Engines
   type 'int' => 'gpgme_protocol_t';
   use constant {
      GPGME_PROTOCOL_OpenPGP  => 0,
      GPGME_PROTOCOL_CMS      => 1,
      GPGME_PROTOCOL_GPGCONF  => 2,
      GPGME_PROTOCOL_ASSUAN   => 3,
      GPGME_PROTOCOL_G13      => 4,
      GPGME_PROTOCOL_UISERVER => 5,
      GPGME_PROTOCOL_SPAWN    => 6,
      GPGME_PROTOCOL_DEFAULT  => 254,
      GPGME_PROTOCOL_UNKNOWN  => 255,
   };
   attach gpgme_get_protocol_name => ['gpgme_protocol_t'] => 'string';

   # https://www.gnupg.org/documentation/manuals/gpgme/Engine-Version-Check.html#Engine-Version-Check
   attach gpgme_get_dirinfo => ['string'] => 'string';
   type 'int' => 'gpgme_error_t';
   attach gpgme_engine_check_version => ['gpgme_protocol_t'] => 'gpgme_error_t';

}

use Package::Stash;
use Sub::Exporter::Progressive -setup => {
  exports => [
     grep m/^gpgme_/i,
     keys %{Package::Stash->new(__PACKAGE__)->get_all_symbols('CODE')},
  ],
  groups => {
    default => [
     grep m/^gpgme_/i,
     keys %{Package::Stash->new(__PACKAGE__)->get_all_symbols('CODE')},
    ],
  },
};

1;
