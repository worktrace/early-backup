# Require tokei to be installed.
#
# 1. Don't count code inside rust comment docs.
# 2. Count code in hidden files.
# 3. Sort by lines of code of each language.
# 4. Don't count configuration files.
#
# docs: https://github.com/XAMPPRocky/tokei?tab=readme-ov-file#installation
# source code: https://github.com/XAMPPRocky/tokei
# cargo install: https://crates.io/crates/tokei
tokei \
  --compact \
  --hidden \
  --sort=lines \
  --exclude="*.{json,yaml,toml,xml,svg,xcconfig}"
