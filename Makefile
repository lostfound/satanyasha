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
	rm -f  $(PREFIX)/bin/satanyasha
	echo "#!/bin/sh"                 >  $(PREFIX)/bin/satanyasha
	echo cd $(PREFIX)/lib/satanyasha >> $(PREFIX)/bin/satanyasha
	echo ruby remote.rb `cat .d`            >> $(PREFIX)/bin/satanyasha
	chmod a+rx $(PREFIX)/bin/satanyasha

  

uninstall:
	rm -rf  $(PREFIX)/lib/satanyasha $(PREFIX)/bin/satanyasha
