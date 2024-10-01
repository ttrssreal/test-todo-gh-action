# Marker options

{ lib
, ...
}: {
  options = {
    jess.hasDisplay = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether we have a display or not.
      '';
    };
  };
}
