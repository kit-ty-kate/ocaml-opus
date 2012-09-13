exception Buffer_too_small
exception Internal_error
exception Invalid_packet
exception Unimplemented
exception Invalid_state
exception Alloc_fail

let () =
  Callback.register_exception "opus_exn_buffer_too_small" Buffer_too_small;
  Callback.register_exception "opus_exn_internal_error" Internal_error;
  Callback.register_exception "opus_exn_invalid_packet" Invalid_packet;
  Callback.register_exception "opus_exn_unimplemented" Unimplemented;
  Callback.register_exception "opus_exn_invalid_state" Invalid_state;
  Callback.register_exception "opus_exn_alloc_fail" Alloc_fail

let init () = ()

let max_frame_size = 960*6

module Packet = struct
  type t = Ogg.Stream.packet

  external check : t -> bool = "ocaml_opus_packet_check"

  external channels : t -> int = "ocaml_opus_decoder_channels"
end

module Decoder = struct
  type t

  external create : int -> int -> t = "ocaml_opus_decoder_create"

  external init : t -> int -> int -> unit = "ocaml_opus_decoder_init"

  external decode_float : t -> Packet.t -> float array array -> int -> int -> int = "ocaml_opus_decoder_decode_float_byte" "ocaml_opus_decoder_decode_float"
end