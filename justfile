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
	cd src && find . -type f -name '*.lua' -delete

# compile yue
[group('dev')]
build: clean
	yue -m init.yue
	cd lua && yue -m .
