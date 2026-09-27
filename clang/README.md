# clang

`.clang-format` — the C/C++ code style used by clang-format (and by conform.nvim on save).

Stowed by `steps/04_stow.sh` (`stow -R -t ~ clang`). → `~/.clang-format`. clang-format looks upward from the source file,
so this is the fallback for any project without its own `.clang-format`.

Style: LLVM base, 4-space indent, no tabs, Linux brace style, 130 columns, `int *p`,
aligned declarations and macros. Try a change with `clang-format -i file.c`.
