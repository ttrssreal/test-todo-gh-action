{ lib
, ...
}: {
  options.info = lib.mkOption {
    type = lib.types.attrs;
    description = "arbitrary associated data";
  };
}
