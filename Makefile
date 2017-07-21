prefix=/usr/local

# files that need mode 755
EXEC_FILES=remote-branch-housekeeping

all:
	@echo "usage: make install"
	@echo "       make uninstall"
	@echo "       make reinstall"
	@echo "       make test"

help:
	$(MAKE) all

install:
	install -m 0755 $(EXEC_FILES) $(prefix)/bin
	git config --global alias.remote-branch-housekeeping '! $(prefix)/bin/$(EXEC_FILES)'

uninstall:
	test -d $(prefix)/bin && \
	cd $(prefix)/bin && \
	rm -f $(EXEC_FILES) && \
	git config --global --unset alias.remote-branch-housekeeping

reinstall:
	git pull origin master
	$(MAKE) uninstall && \
	$(MAKE) install

test:
	tests/commands_test.sh