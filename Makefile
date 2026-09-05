all: install test

test: 
	./scripts/test

test-fail-fast:
	./scripts/test --fail-fast
update:
	./scripts/install_deps

install: clean update
	nvim --headless -u tests/testrc.vim -c "lua require('nvim-treesitter.install').install('bash'):wait(300000)" -c "quit"

clean:
	rm -rf dependencies

validate:
	stylua --check .

format:
	stylua .
