[private]
default:
    @just --list

# analyze yue code
[group('dev')]
check:
    @luacheck --globals vim -- src
    @tokei src

# lint lua code
[group('dev')]
lint:
    @stylua src -c

# lint and apply possible fixes to lua code
[group('dev')]
lint-fix:
    @stylua src
