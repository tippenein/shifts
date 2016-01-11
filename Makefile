serve:
	stack exec shifts

build:
	stack build

watch:
	watchman-make -p '**/*.hs' 'Makefile*' -t build
