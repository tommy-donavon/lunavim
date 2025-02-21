[private]
default:
    @just --list

# analyze yue code
[group('dev')]
check:
    @tokei src

# clean compiled lua
[group('dev')]
clean:
    rm dist

# compile yue
[group('dev')]
build: clean
    mkdir dist
    cd src && yue -t ../dist .
