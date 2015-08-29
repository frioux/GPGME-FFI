package GPGME::FFI;

use strict;
use warnings;

# see /usr/include/gpgme.h
# and /usr/include/x86_64-linux-gnu/gpg-error.h

BEGIN {
   use FFI::Platypus::Declare qw( string uint );
   use FFI::CheckLib;

   lib find_lib_or_die lib => 'gpgme';

   # https://www.gnupg.org/documentation/manuals/gpgme/Protocols-and-Engines.html#Protocols-and-Engines
   type uint, 'gpgme_protocol_t';
   use constant { # {{{ enum gpgme_protocol_t
      GPGME_PROTOCOL_OpenPGP  => 0,
      GPGME_PROTOCOL_CMS      => 1,
      GPGME_PROTOCOL_GPGCONF  => 2,
      GPGME_PROTOCOL_ASSUAN   => 3,
      GPGME_PROTOCOL_G13      => 4,
      GPGME_PROTOCOL_UISERVER => 5,
      GPGME_PROTOCOL_SPAWN    => 6,
      GPGME_PROTOCOL_DEFAULT  => 254,
      GPGME_PROTOCOL_UNKNOWN  => 255,
   }; # }}}
   attach gpgme_get_protocol_name => ['gpgme_protocol_t'] => string;

   # https://www.gnupg.org/documentation/manuals/gpgme/Engine-Version-Check.html#Engine-Version-Check
   attach gpgme_get_dirinfo => [string], string;
   type uint, 'gpgme_error_t';
   use constant { # {{{ enum gpgme_error_t
      GPGME_ERR_NO_ERROR                 => 0,
      GPGME_ERR_GENERAL                  => 1,
      GPGME_ERR_UNKNOWN_PACKET           => 2,
      GPGME_ERR_UNKNOWN_VERSION          => 3,
      GPGME_ERR_PUBKEY_ALGO              => 4,
      GPGME_ERR_DIGEST_ALGO              => 5,
      GPGME_ERR_BAD_PUBKEY               => 6,
      GPGME_ERR_BAD_SECKEY               => 7,
      GPGME_ERR_BAD_SIGNATURE            => 8,
      GPGME_ERR_NO_PUBKEY                => 9,
      GPGME_ERR_CHECKSUM                 => 10,
      GPGME_ERR_BAD_PASSPHRASE           => 11,
      GPGME_ERR_CIPHER_ALGO              => 12,
      GPGME_ERR_KEYRING_OPEN             => 13,
      GPGME_ERR_INV_PACKET               => 14,
      GPGME_ERR_INV_ARMOR                => 15,
      GPGME_ERR_NO_USER_ID               => 16,
      GPGME_ERR_NO_SECKEY                => 17,
      GPGME_ERR_WRONG_SECKEY             => 18,
      GPGME_ERR_BAD_KEY                  => 19,
      GPGME_ERR_COMPR_ALGO               => 20,
      GPGME_ERR_NO_PRIME                 => 21,
      GPGME_ERR_NO_ENCODING_METHOD       => 22,
      GPGME_ERR_NO_ENCRYPTION_SCHEME     => 23,
      GPGME_ERR_NO_SIGNATURE_SCHEME      => 24,
      GPGME_ERR_INV_ATTR                 => 25,
      GPGME_ERR_NO_VALUE                 => 26,
      GPGME_ERR_NOT_FOUND                => 27,
      GPGME_ERR_VALUE_NOT_FOUND          => 28,
      GPGME_ERR_SYNTAX                   => 29,
      GPGME_ERR_BAD_MPI                  => 30,
      GPGME_ERR_INV_PASSPHRASE           => 31,
      GPGME_ERR_SIG_CLASS                => 32,
      GPGME_ERR_RESOURCE_LIMIT           => 33,
      GPGME_ERR_INV_KEYRING              => 34,
      GPGME_ERR_TRUSTDB                  => 35,
      GPGME_ERR_BAD_CERT                 => 36,
      GPGME_ERR_INV_USER_ID              => 37,
      GPGME_ERR_UNEXPECTED               => 38,
      GPGME_ERR_TIME_CONFLICT            => 39,
      GPGME_ERR_KEYSERVER                => 40,
      GPGME_ERR_WRONG_PUBKEY_ALGO        => 41,
      GPGME_ERR_TRIBUTE_TO_D_A           => 42,
      GPGME_ERR_WEAK_KEY                 => 43,
      GPGME_ERR_INV_KEYLEN               => 44,
      GPGME_ERR_INV_ARG                  => 45,
      GPGME_ERR_BAD_URI                  => 46,
      GPGME_ERR_INV_URI                  => 47,
      GPGME_ERR_NETWORK                  => 48,
      GPGME_ERR_UNKNOWN_HOST             => 49,
      GPGME_ERR_SELFTEST_FAILED          => 50,
      GPGME_ERR_NOT_ENCRYPTED            => 51,
      GPGME_ERR_NOT_PROCESSED            => 52,
      GPGME_ERR_UNUSABLE_PUBKEY          => 53,
      GPGME_ERR_UNUSABLE_SECKEY          => 54,
      GPGME_ERR_INV_VALUE                => 55,
      GPGME_ERR_BAD_CERT_CHAIN           => 56,
      GPGME_ERR_MISSING_CERT             => 57,
      GPGME_ERR_NO_DATA                  => 58,
      GPGME_ERR_BUG                      => 59,
      GPGME_ERR_NOT_SUPPORTED            => 60,
      GPGME_ERR_INV_OP                   => 61,
      GPGME_ERR_TIMEOUT                  => 62,
      GPGME_ERR_INTERNAL                 => 63,
      GPGME_ERR_EOF_GCRYPT               => 64,
      GPGME_ERR_INV_OBJ                  => 65,
      GPGME_ERR_TOO_SHORT                => 66,
      GPGME_ERR_TOO_LARGE                => 67,
      GPGME_ERR_NO_OBJ                   => 68,
      GPGME_ERR_NOT_IMPLEMENTED          => 69,
      GPGME_ERR_CONFLICT                 => 70,
      GPGME_ERR_INV_CIPHER_MODE          => 71,
      GPGME_ERR_INV_FLAG                 => 72,
      GPGME_ERR_INV_HANDLE               => 73,
      GPGME_ERR_TRUNCATED                => 74,
      GPGME_ERR_INCOMPLETE_LINE          => 75,
      GPGME_ERR_INV_RESPONSE             => 76,
      GPGME_ERR_NO_AGENT                 => 77,
      GPGME_ERR_AGENT                    => 78,
      GPGME_ERR_INV_DATA                 => 79,
      GPGME_ERR_ASSUAN_SERVER_FAULT      => 80,
      GPGME_ERR_ASSUAN                   => 81,
      GPGME_ERR_INV_SESSION_KEY          => 82,
      GPGME_ERR_INV_SEXP                 => 83,
      GPGME_ERR_UNSUPPORTED_ALGORITHM    => 84,
      GPGME_ERR_NO_PIN_ENTRY             => 85,
      GPGME_ERR_PIN_ENTRY                => 86,
      GPGME_ERR_BAD_PIN                  => 87,
      GPGME_ERR_INV_NAME                 => 88,
      GPGME_ERR_BAD_DATA                 => 89,
      GPGME_ERR_INV_PARAMETER            => 90,
      GPGME_ERR_WRONG_CARD               => 91,
      GPGME_ERR_NO_DIRMNGR               => 92,
      GPGME_ERR_DIRMNGR                  => 93,
      GPGME_ERR_CERT_REVOKED             => 94,
      GPGME_ERR_NO_CRL_KNOWN             => 95,
      GPGME_ERR_CRL_TOO_OLD              => 96,
      GPGME_ERR_LINE_TOO_LONG            => 97,
      GPGME_ERR_NOT_TRUSTED              => 98,
      GPGME_ERR_CANCELED                 => 99,
      GPGME_ERR_BAD_CA_CERT              => 100,
      GPGME_ERR_CERT_EXPIRED             => 101,
      GPGME_ERR_CERT_TOO_YOUNG           => 102,
      GPGME_ERR_UNSUPPORTED_CERT         => 103,
      GPGME_ERR_UNKNOWN_SEXP             => 104,
      GPGME_ERR_UNSUPPORTED_PROTECTION   => 105,
      GPGME_ERR_CORRUPTED_PROTECTION     => 106,
      GPGME_ERR_AMBIGUOUS_NAME           => 107,
      GPGME_ERR_CARD                     => 108,
      GPGME_ERR_CARD_RESET               => 109,
      GPGME_ERR_CARD_REMOVED             => 110,
      GPGME_ERR_INV_CARD                 => 111,
      GPGME_ERR_CARD_NOT_PRESENT         => 112,
      GPGME_ERR_NO_PKCS15_APP            => 113,
      GPGME_ERR_NOT_CONFIRMED            => 114,
      GPGME_ERR_CONFIGURATION            => 115,
      GPGME_ERR_NO_POLICY_MATCH          => 116,
      GPGME_ERR_INV_INDEX                => 117,
      GPGME_ERR_INV_ID                   => 118,
      GPGME_ERR_NO_SCDAEMON              => 119,
      GPGME_ERR_SCDAEMON                 => 120,
      GPGME_ERR_UNSUPPORTED_PROTOCOL     => 121,
      GPGME_ERR_BAD_PIN_METHOD           => 122,
      GPGME_ERR_CARD_NOT_INITIALIZED     => 123,
      GPGME_ERR_UNSUPPORTED_OPERATION    => 124,
      GPGME_ERR_WRONG_KEY_USAGE          => 125,
      GPGME_ERR_NOTHING_FOUND            => 126,
      GPGME_ERR_WRONG_BLOB_TYPE          => 127,
      GPGME_ERR_MISSING_VALUE            => 128,
      GPGME_ERR_HARDWARE                 => 129,
      GPGME_ERR_PIN_BLOCKED              => 130,
      GPGME_ERR_USE_CONDITIONS           => 131,
      GPGME_ERR_PIN_NOT_SYNCED           => 132,
      GPGME_ERR_INV_CRL                  => 133,
      GPGME_ERR_BAD_BER                  => 134,
      GPGME_ERR_INV_BER                  => 135,
      GPGME_ERR_ELEMENT_NOT_FOUND        => 136,
      GPGME_ERR_IDENTIFIER_NOT_FOUND     => 137,
      GPGME_ERR_INV_TAG                  => 138,
      GPGME_ERR_INV_LENGTH               => 139,
      GPGME_ERR_INV_KEYINFO              => 140,
      GPGME_ERR_UNEXPECTED_TAG           => 141,
      GPGME_ERR_NOT_DER_ENCODED          => 142,
      GPGME_ERR_NO_CMS_OBJ               => 143,
      GPGME_ERR_INV_CMS_OBJ              => 144,
      GPGME_ERR_UNKNOWN_CMS_OBJ          => 145,
      GPGME_ERR_UNSUPPORTED_CMS_OBJ      => 146,
      GPGME_ERR_UNSUPPORTED_ENCODING     => 147,
      GPGME_ERR_UNSUPPORTED_CMS_VERSION  => 148,
      GPGME_ERR_UNKNOWN_ALGORITHM        => 149,
      GPGME_ERR_INV_ENGINE               => 150,
      GPGME_ERR_PUBKEY_NOT_TRUSTED       => 151,
      GPGME_ERR_DECRYPT_FAILED           => 152,
      GPGME_ERR_KEY_EXPIRED              => 153,
      GPGME_ERR_SIG_EXPIRED              => 154,
      GPGME_ERR_ENCODING_PROBLEM         => 155,
      GPGME_ERR_INV_STATE                => 156,
      GPGME_ERR_DUP_VALUE                => 157,
      GPGME_ERR_MISSING_ACTION           => 158,
      GPGME_ERR_MODULE_NOT_FOUND         => 159,
      GPGME_ERR_INV_OID_STRING           => 160,
      GPGME_ERR_INV_TIME                 => 161,
      GPGME_ERR_INV_CRL_OBJ              => 162,
      GPGME_ERR_UNSUPPORTED_CRL_VERSION  => 163,
      GPGME_ERR_INV_CERT_OBJ             => 164,
      GPGME_ERR_UNKNOWN_NAME             => 165,
      GPGME_ERR_LOCALE_PROBLEM           => 166,
      GPGME_ERR_NOT_LOCKED               => 167,
      GPGME_ERR_PROTOCOL_VIOLATION       => 168,
      GPGME_ERR_INV_MAC                  => 169,
      GPGME_ERR_INV_REQUEST              => 170,
      GPGME_ERR_UNKNOWN_EXTN             => 171,
      GPGME_ERR_UNKNOWN_CRIT_EXTN        => 172,
      GPGME_ERR_LOCKED                   => 173,
      GPGME_ERR_UNKNOWN_OPTION           => 174,
      GPGME_ERR_UNKNOWN_COMMAND          => 175,
      GPGME_ERR_NOT_OPERATIONAL          => 176,
      GPGME_ERR_NO_PASSPHRASE            => 177,
      GPGME_ERR_NO_PIN                   => 178,
      GPGME_ERR_NOT_ENABLED              => 179,
      GPGME_ERR_NO_ENGINE                => 180,
      GPGME_ERR_MISSING_KEY              => 181,
      GPGME_ERR_TOO_MANY                 => 182,
      GPGME_ERR_LIMIT_REACHED            => 183,
      GPGME_ERR_NOT_INITIALIZED          => 184,
      GPGME_ERR_MISSING_ISSUER_CERT      => 185,
      GPGME_ERR_NO_KEYSERVER             => 186,
      GPGME_ERR_INV_CURVE                => 187,
      GPGME_ERR_UNKNOWN_CURVE            => 188,
      GPGME_ERR_DUP_KEY                  => 189,
      GPGME_ERR_AMBIGUOUS                => 190,
      GPGME_ERR_NO_CRYPT_CTX             => 191,
      GPGME_ERR_WRONG_CRYPT_CTX          => 192,
      GPGME_ERR_BAD_CRYPT_CTX            => 193,
      GPGME_ERR_CRYPT_CTX_CONFLICT       => 194,
      GPGME_ERR_BROKEN_PUBKEY            => 195,
      GPGME_ERR_BROKEN_SECKEY            => 196,
      GPGME_ERR_MAC_ALGO                 => 197,
      GPGME_ERR_FULLY_CANCELED           => 198,
      GPGME_ERR_UNFINISHED               => 199,
      GPGME_ERR_BUFFER_TOO_SHORT         => 200,
      GPGME_ERR_SEXP_INV_LEN_SPEC        => 201,
      GPGME_ERR_SEXP_STRING_TOO_LONG     => 202,
      GPGME_ERR_SEXP_UNMATCHED_PAREN     => 203,
      GPGME_ERR_SEXP_NOT_CANONICAL       => 204,
      GPGME_ERR_SEXP_BAD_CHARACTER       => 205,
      GPGME_ERR_SEXP_BAD_QUOTATION       => 206,
      GPGME_ERR_SEXP_ZERO_PREFIX         => 207,
      GPGME_ERR_SEXP_NESTED_DH           => 208,
      GPGME_ERR_SEXP_UNMATCHED_DH        => 209,
      GPGME_ERR_SEXP_UNEXPECTED_PUNC     => 210,
      GPGME_ERR_SEXP_BAD_HEX_CHAR        => 211,
      GPGME_ERR_SEXP_ODD_HEX_NUMBERS     => 212,
      GPGME_ERR_SEXP_BAD_OCT_CHAR        => 213,
      GPGME_ERR_NO_CERT_CHAIN            => 226,
      GPGME_ERR_CERT_TOO_LARGE           => 227,
      GPGME_ERR_INV_RECORD               => 228,
      GPGME_ERR_BAD_MAC                  => 229,
      GPGME_ERR_UNEXPECTED_MSG           => 230,
      GPGME_ERR_COMPR_FAILED             => 231,
      GPGME_ERR_WOULD_WRAP               => 232,
      GPGME_ERR_FATAL_ALERT              => 233,
      GPGME_ERR_NO_CIPHER                => 234,
      GPGME_ERR_MISSING_CLIENT_CERT      => 235,
      GPGME_ERR_CLOSE_NOTIFY             => 236,
      GPGME_ERR_TICKET_EXPIRED           => 237,
      GPGME_ERR_BAD_TICKET               => 238,
      GPGME_ERR_UNKNOWN_IDENTITY         => 239,
      GPGME_ERR_BAD_HS_CERT              => 240,
      GPGME_ERR_BAD_HS_CERT_REQ          => 241,
      GPGME_ERR_BAD_HS_CERT_VER          => 242,
      GPGME_ERR_BAD_HS_CHANGE_CIPHER     => 243,
      GPGME_ERR_BAD_HS_CLIENT_HELLO      => 244,
      GPGME_ERR_BAD_HS_SERVER_HELLO      => 245,
      GPGME_ERR_BAD_HS_SERVER_HELLO_DONE => 246,
      GPGME_ERR_BAD_HS_FINISHED          => 247,
      GPGME_ERR_BAD_HS_SERVER_KEX        => 248,
      GPGME_ERR_BAD_HS_CLIENT_KEX        => 249,
      GPGME_ERR_BOGUS_STRING             => 250,
      GPGME_ERR_KEY_DISABLED             => 252,
      GPGME_ERR_KEY_ON_CARD              => 253,
      GPGME_ERR_INV_LOCK_OBJ             => 254,
      GPGME_ERR_ASS_GENERAL              => 257,
      GPGME_ERR_ASS_ACCEPT_FAILED        => 258,
      GPGME_ERR_ASS_CONNECT_FAILED       => 259,
      GPGME_ERR_ASS_INV_RESPONSE         => 260,
      GPGME_ERR_ASS_INV_VALUE            => 261,
      GPGME_ERR_ASS_INCOMPLETE_LINE      => 262,
      GPGME_ERR_ASS_LINE_TOO_LONG        => 263,
      GPGME_ERR_ASS_NESTED_COMMANDS      => 264,
      GPGME_ERR_ASS_NO_DATA_CB           => 265,
      GPGME_ERR_ASS_NO_INQUIRE_CB        => 266,
      GPGME_ERR_ASS_NOT_A_SERVER         => 267,
      GPGME_ERR_ASS_NOT_A_CLIENT         => 268,
      GPGME_ERR_ASS_SERVER_START         => 269,
      GPGME_ERR_ASS_READ_ERROR           => 270,
      GPGME_ERR_ASS_WRITE_ERROR          => 271,
      GPGME_ERR_ASS_TOO_MUCH_DATA        => 273,
      GPGME_ERR_ASS_UNEXPECTED_CMD       => 274,
      GPGME_ERR_ASS_UNKNOWN_CMD          => 275,
      GPGME_ERR_ASS_SYNTAX               => 276,
      GPGME_ERR_ASS_CANCELED             => 277,
      GPGME_ERR_ASS_NO_INPUT             => 278,
      GPGME_ERR_ASS_NO_OUTPUT            => 279,
      GPGME_ERR_ASS_PARAMETER            => 280,
      GPGME_ERR_ASS_UNKNOWN_INQUIRE      => 281,
      GPGME_ERR_USER_1                   => 1024,
      GPGME_ERR_USER_2                   => 1025,
      GPGME_ERR_USER_3                   => 1026,
      GPGME_ERR_USER_4                   => 1027,
      GPGME_ERR_USER_5                   => 1028,
      GPGME_ERR_USER_6                   => 1029,
      GPGME_ERR_USER_7                   => 1030,
      GPGME_ERR_USER_8                   => 1031,
      GPGME_ERR_USER_9                   => 1032,
      GPGME_ERR_USER_10                  => 1033,
      GPGME_ERR_USER_11                  => 1034,
      GPGME_ERR_USER_12                  => 1035,
      GPGME_ERR_USER_13                  => 1036,
      GPGME_ERR_USER_14                  => 1037,
      GPGME_ERR_USER_15                  => 1038,
      GPGME_ERR_USER_16                  => 1039,
      GPGME_ERR_MISSING_ERRNO            => 16381,
      GPGME_ERR_UNKNOWN_ERRNO            => 16382,
      GPGME_ERR_EOF                      => 16383,
      GPGME_ERR_SYSTEM_ERROR             => 1<<15,
      GPGME_ERR_E2BIG                    => 1<<15 | 0,
      GPGME_ERR_EACCES                   => 1<<15 | 1,
      GPGME_ERR_EADDRINUSE               => 1<<15 | 2,
      GPGME_ERR_EADDRNOTAVAIL            => 1<<15 | 3,
      GPGME_ERR_EADV                     => 1<<15 | 4,
      GPGME_ERR_EAFNOSUPPORT             => 1<<15 | 5,
      GPGME_ERR_EAGAIN                   => 1<<15 | 6,
      GPGME_ERR_EALREADY                 => 1<<15 | 7,
      GPGME_ERR_EAUTH                    => 1<<15 | 8,
      GPGME_ERR_EBACKGROUND              => 1<<15 | 9,
      GPGME_ERR_EBADE                    => 1<<15 | 10,
      GPGME_ERR_EBADF                    => 1<<15 | 11,
      GPGME_ERR_EBADFD                   => 1<<15 | 12,
      GPGME_ERR_EBADMSG                  => 1<<15 | 13,
      GPGME_ERR_EBADR                    => 1<<15 | 14,
      GPGME_ERR_EBADRPC                  => 1<<15 | 15,
      GPGME_ERR_EBADRQC                  => 1<<15 | 16,
      GPGME_ERR_EBADSLT                  => 1<<15 | 17,
      GPGME_ERR_EBFONT                   => 1<<15 | 18,
      GPGME_ERR_EBUSY                    => 1<<15 | 19,
      GPGME_ERR_ECANCELED                => 1<<15 | 20,
      GPGME_ERR_ECHILD                   => 1<<15 | 21,
      GPGME_ERR_ECHRNG                   => 1<<15 | 22,
      GPGME_ERR_ECOMM                    => 1<<15 | 23,
      GPGME_ERR_ECONNABORTED             => 1<<15 | 24,
      GPGME_ERR_ECONNREFUSED             => 1<<15 | 25,
      GPGME_ERR_ECONNRESET               => 1<<15 | 26,
      GPGME_ERR_ED                       => 1<<15 | 27,
      GPGME_ERR_EDEADLK                  => 1<<15 | 28,
      GPGME_ERR_EDEADLOCK                => 1<<15 | 29,
      GPGME_ERR_EDESTADDRREQ             => 1<<15 | 30,
      GPGME_ERR_EDIED                    => 1<<15 | 31,
      GPGME_ERR_EDOM                     => 1<<15 | 32,
      GPGME_ERR_EDOTDOT                  => 1<<15 | 33,
      GPGME_ERR_EDQUOT                   => 1<<15 | 34,
      GPGME_ERR_EEXIST                   => 1<<15 | 35,
      GPGME_ERR_EFAULT                   => 1<<15 | 36,
      GPGME_ERR_EFBIG                    => 1<<15 | 37,
      GPGME_ERR_EFTYPE                   => 1<<15 | 38,
      GPGME_ERR_EGRATUITOUS              => 1<<15 | 39,
      GPGME_ERR_EGREGIOUS                => 1<<15 | 40,
      GPGME_ERR_EHOSTDOWN                => 1<<15 | 41,
      GPGME_ERR_EHOSTUNREACH             => 1<<15 | 42,
      GPGME_ERR_EIDRM                    => 1<<15 | 43,
      GPGME_ERR_EIEIO                    => 1<<15 | 44,
      GPGME_ERR_EILSEQ                   => 1<<15 | 45,
      GPGME_ERR_EINPROGRESS              => 1<<15 | 46,
      GPGME_ERR_EINTR                    => 1<<15 | 47,
      GPGME_ERR_EINVAL                   => 1<<15 | 48,
      GPGME_ERR_EIO                      => 1<<15 | 49,
      GPGME_ERR_EISCONN                  => 1<<15 | 50,
      GPGME_ERR_EISDIR                   => 1<<15 | 51,
      GPGME_ERR_EISNAM                   => 1<<15 | 52,
      GPGME_ERR_EL2HLT                   => 1<<15 | 53,
      GPGME_ERR_EL2NSYNC                 => 1<<15 | 54,
      GPGME_ERR_EL3HLT                   => 1<<15 | 55,
      GPGME_ERR_EL3RST                   => 1<<15 | 56,
      GPGME_ERR_ELIBACC                  => 1<<15 | 57,
      GPGME_ERR_ELIBBAD                  => 1<<15 | 58,
      GPGME_ERR_ELIBEXEC                 => 1<<15 | 59,
      GPGME_ERR_ELIBMAX                  => 1<<15 | 60,
      GPGME_ERR_ELIBSCN                  => 1<<15 | 61,
      GPGME_ERR_ELNRNG                   => 1<<15 | 62,
      GPGME_ERR_ELOOP                    => 1<<15 | 63,
      GPGME_ERR_EMEDIUMTYPE              => 1<<15 | 64,
      GPGME_ERR_EMFILE                   => 1<<15 | 65,
      GPGME_ERR_EMLINK                   => 1<<15 | 66,
      GPGME_ERR_EMSGSIZE                 => 1<<15 | 67,
      GPGME_ERR_EMULTIHOP                => 1<<15 | 68,
      GPGME_ERR_ENAMETOOLONG             => 1<<15 | 69,
      GPGME_ERR_ENAVAIL                  => 1<<15 | 70,
      GPGME_ERR_ENEEDAUTH                => 1<<15 | 71,
      GPGME_ERR_ENETDOWN                 => 1<<15 | 72,
      GPGME_ERR_ENETRESET                => 1<<15 | 73,
      GPGME_ERR_ENETUNREACH              => 1<<15 | 74,
      GPGME_ERR_ENFILE                   => 1<<15 | 75,
      GPGME_ERR_ENOANO                   => 1<<15 | 76,
      GPGME_ERR_ENOBUFS                  => 1<<15 | 77,
      GPGME_ERR_ENOCSI                   => 1<<15 | 78,
      GPGME_ERR_ENODATA                  => 1<<15 | 79,
      GPGME_ERR_ENODEV                   => 1<<15 | 80,
      GPGME_ERR_ENOENT                   => 1<<15 | 81,
      GPGME_ERR_ENOEXEC                  => 1<<15 | 82,
      GPGME_ERR_ENOLCK                   => 1<<15 | 83,
      GPGME_ERR_ENOLINK                  => 1<<15 | 84,
      GPGME_ERR_ENOMEDIUM                => 1<<15 | 85,
      GPGME_ERR_ENOMEM                   => 1<<15 | 86,
      GPGME_ERR_ENOMSG                   => 1<<15 | 87,
      GPGME_ERR_ENONET                   => 1<<15 | 88,
      GPGME_ERR_ENOPKG                   => 1<<15 | 89,
      GPGME_ERR_ENOPROTOOPT              => 1<<15 | 90,
      GPGME_ERR_ENOSPC                   => 1<<15 | 91,
      GPGME_ERR_ENOSR                    => 1<<15 | 92,
      GPGME_ERR_ENOSTR                   => 1<<15 | 93,
      GPGME_ERR_ENOSYS                   => 1<<15 | 94,
      GPGME_ERR_ENOTBLK                  => 1<<15 | 95,
      GPGME_ERR_ENOTCONN                 => 1<<15 | 96,
      GPGME_ERR_ENOTDIR                  => 1<<15 | 97,
      GPGME_ERR_ENOTEMPTY                => 1<<15 | 98,
      GPGME_ERR_ENOTNAM                  => 1<<15 | 99,
      GPGME_ERR_ENOTSOCK                 => 1<<15 | 100,
      GPGME_ERR_ENOTSUP                  => 1<<15 | 101,
      GPGME_ERR_ENOTTY                   => 1<<15 | 102,
      GPGME_ERR_ENOTUNIQ                 => 1<<15 | 103,
      GPGME_ERR_ENXIO                    => 1<<15 | 104,
      GPGME_ERR_EOPNOTSUPP               => 1<<15 | 105,
      GPGME_ERR_EOVERFLOW                => 1<<15 | 106,
      GPGME_ERR_EPERM                    => 1<<15 | 107,
      GPGME_ERR_EPFNOSUPPORT             => 1<<15 | 108,
      GPGME_ERR_EPIPE                    => 1<<15 | 109,
      GPGME_ERR_EPROCLIM                 => 1<<15 | 110,
      GPGME_ERR_EPROCUNAVAIL             => 1<<15 | 111,
      GPGME_ERR_EPROGMISMATCH            => 1<<15 | 112,
      GPGME_ERR_EPROGUNAVAIL             => 1<<15 | 113,
      GPGME_ERR_EPROTO                   => 1<<15 | 114,
      GPGME_ERR_EPROTONOSUPPORT          => 1<<15 | 115,
      GPGME_ERR_EPROTOTYPE               => 1<<15 | 116,
      GPGME_ERR_ERANGE                   => 1<<15 | 117,
      GPGME_ERR_EREMCHG                  => 1<<15 | 118,
      GPGME_ERR_EREMOTE                  => 1<<15 | 119,
      GPGME_ERR_EREMOTEIO                => 1<<15 | 120,
      GPGME_ERR_ERESTART                 => 1<<15 | 121,
      GPGME_ERR_EROFS                    => 1<<15 | 122,
      GPGME_ERR_ERPCMISMATCH             => 1<<15 | 123,
      GPGME_ERR_ESHUTDOWN                => 1<<15 | 124,
      GPGME_ERR_ESOCKTNOSUPPORT          => 1<<15 | 125,
      GPGME_ERR_ESPIPE                   => 1<<15 | 126,
      GPGME_ERR_ESRCH                    => 1<<15 | 127,
      GPGME_ERR_ESRMNT                   => 1<<15 | 128,
      GPGME_ERR_ESTALE                   => 1<<15 | 129,
      GPGME_ERR_ESTRPIPE                 => 1<<15 | 130,
      GPGME_ERR_ETIME                    => 1<<15 | 131,
      GPGME_ERR_ETIMEDOUT                => 1<<15 | 132,
      GPGME_ERR_ETOOMANYREFS             => 1<<15 | 133,
      GPGME_ERR_ETXTBSY                  => 1<<15 | 134,
      GPGME_ERR_EUCLEAN                  => 1<<15 | 135,
      GPGME_ERR_EUNATCH                  => 1<<15 | 136,
      GPGME_ERR_EUSERS                   => 1<<15 | 137,
      GPGME_ERR_EWOULDBLOCK              => 1<<15 | 138,
      GPGME_ERR_EXDEV                    => 1<<15 | 139,
      GPGME_ERR_EXFULL                   => 1<<15 | 140,
      GPGME_ERR_CODE_DIM                 => 65536
   }; # }}}
   attach gpgme_engine_check_version => ['gpgme_protocol_t'] => 'gpgme_error_t';

   type uint, 'gpgme_err_source_t';
   use constant { # {{{ enum gpg_err_source_t
      GPGME_ERR_SOURCE_UNKNOWN  => 0,
      GPGME_ERR_SOURCE_GCRYPT   => 1,
      GPGME_ERR_SOURCE_GPG      => 2,
      GPGME_ERR_SOURCE_GPGSM    => 3,
      GPGME_ERR_SOURCE_GPGAGENT => 4,
      GPGME_ERR_SOURCE_PINENTRY => 5,
      GPGME_ERR_SOURCE_SCD      => 6,
      GPGME_ERR_SOURCE_GPGME    => 7,
      GPGME_ERR_SOURCE_KEYBOX   => 8,
      GPGME_ERR_SOURCE_KSBA     => 9,
      GPGME_ERR_SOURCE_DIRMNGR  => 10,
      GPGME_ERR_SOURCE_GSTI     => 11,
      GPGME_ERR_SOURCE_GPA      => 12,
      GPGME_ERR_SOURCE_KLEO     => 13,
      GPGME_ERR_SOURCE_G13      => 14,
      GPGME_ERR_SOURCE_ASSUAN   => 15,
      GPGME_ERR_SOURCE_TLS      => 17,
      GPGME_ERR_SOURCE_ANY      => 31,
      GPGME_ERR_SOURCE_USER_1   => 32,
      GPGME_ERR_SOURCE_USER_2   => 33,
      GPGME_ERR_SOURCE_USER_3   => 34,
      GPGME_ERR_SOURCE_USER_4   => 35,
      GPGME_ERR_SOURCE_DIM      => 128
   }; # }}}

   # https://www.gnupg.org/documentation/manuals/gpgme/Engine-Information.html#Engine-Information
   attach gpgme_get_engine_info => ['record(GPGME::FFI::EngineInfo)'] => 'gpgme_error_t';

   attach gpgme_strerror => ['gpgme_error_t'], string;

   # https://www.gnupg.org/documentation/manuals/gpgme/Engine-Configuration.html#Engine-Configuration
   attach gpgme_set_engine_info => [
      'gpgme_protocol_t',
      string,
      string,
   ] => 'gpgme_error_t';

   # https://www.gnupg.org/documentation/manuals/gpgme/Public-Key-Algorithms.html#Public-Key-Algorithms
   type uint, 'gpgme_pubkey_algo_t';
   use constant { # {{{ enum gpgme_pubkey_algo_t
    GPGME_PK_RSA   => 1,
    GPGME_PK_RSA_E => 2,
    GPGME_PK_RSA_S => 3,
    GPGME_PK_ELG_E => 16,
    GPGME_PK_DSA   => 17,
    GPGME_PK_ECC   => 18,
    GPGME_PK_ELG   => 20,
    GPGME_PK_ECDSA => 301,
    GPGME_PK_ECDH  => 302
   }; # }}}

   attach gpgme_pubkey_algo_name => [ 'gpgme_pubkey_algo_t' ] => string;

   type uint, 'gpgme_hash_algo_t';
   use constant { # {{{ enum gpgme_hash_algo_t
    GPGME_MD_NONE          => 0,
    GPGME_MD_MD5           => 1,
    GPGME_MD_SHA1          => 2,
    GPGME_MD_RMD160        => 3,
    GPGME_MD_MD2           => 5,
    GPGME_MD_TIGER         => 6,
    GPGME_MD_HAVAL         => 7,
    GPGME_MD_SHA256        => 8,
    GPGME_MD_SHA384        => 9,
    GPGME_MD_SHA512        => 10,
    GPGME_MD_SHA224        => 11,
    GPGME_MD_MD4           => 301,
    GPGME_MD_CRC32         => 302,
    GPGME_MD_CRC32_RFC1510 => 303,
    GPGME_MD_CRC24_RFC2440 => 304
   }; # }}}

   attach gpgme_hash_algo_name => [ 'gpgme_hash_algo_t' ] => string;
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

# vim: fdm=marker
