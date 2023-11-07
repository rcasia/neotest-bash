all: install test

test: 
	./scripts/test

test-fail-fast:
	./scripts/test --fail-fast
update:
	git submodule update --init --recursive

install: clean update
	nvim --headless -u tests/minimal_init.vim -c "TSInstallSync bash | quit"

clean:
	rm -rf dependencies

validate:
	stylua --check .

format:
	stylua .
