# Require tokei to be installed.
#
# docs: https://github.com/XAMPPRocky/tokei?tab=readme-ov-file#installation
# source code: https://github.com/XAMPPRocky/tokei
# cargo install: https://crates.io/crates/tokei
tokei \
  --compact \
  --hidden \
  --sort=lines \
  --exclude="*.{json,yaml,toml,xml,svg,xcconfig}"
