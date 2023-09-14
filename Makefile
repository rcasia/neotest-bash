
all: install test

test: 
	./scripts/test

test-fail-fast:
	./scripts/test --fail-fast

install:
	git submodule update --init --recursive
	nvim --headless -u tests/minimal_init.vim -c "TSInstallSync bash | quit"

validate:
	stylua --check .

format:
	stylua .
