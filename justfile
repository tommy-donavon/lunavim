[private]
default:
    @just --list

# analyze yue code
[group('dev')]
check:
    @luacheck --globals vim -- nvim
    @tokei nvim

# lint lua code
[group('dev')]
lint:
    @stylua nvim -c

# lint and apply possible fixes to lua code
[group('dev')]
lint-fix:
    @stylua nvim
