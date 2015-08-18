package GPGME::FFI::EngineInfo;

use FFI::Platypus::Record;
use FFI::Platypus::Declare qw( opaque );

record_layout(qw(
   opaque _next
   uint   protocol
   string file_name
   string version
   string req_version
   string home_dir
));

attach_cast _cast => opaque, 'record(GPGME::FFI::EngineInfo)';

sub next {
   my $self = shift;
   # CAUTION: this copies the next record.
   # since we are only using it to read the structure this my be okay.
   defined $self->_next ? _cast($self->_next) : undef;
}

1;
