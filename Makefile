ifeq ("${PREFIX}", "")
PREFIX=/usr/local
endif

all:

install: all
	install -D server/auth.rb $(PREFIX)/lib/satanyasha/auth.rb
	install -D server/remote.rb $(PREFIX)/lib/satanyasha/remote.rb
	install -D server/sysinfo.rb $(PREFIX)/lib/satanyasha/sysinfo.rb
	install -D server/udp_receiver.rb $(PREFIX)/lib/satanyasha/udp_receiver.rb
	mkdir -m 0755 -p $(PREFIX)/bin
	ln -sf $(PREFIX)/lib/satanyasha/server.rb $(PREFIX)/bin/satanyasha

uninstall:
	rm -rf  $(PREFIX)/lib/satanyasha $(PREFIX)/bin/satanyasha
