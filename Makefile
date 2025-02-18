MAINT := jaggz.h@gmail.com
DATEVER := $(shell date +'%Y%m%d')

binname := cho
binnameq := choq

diruser := $(wildcard ~/bin)
dirsys := /bin

binuser := $(diruser)/$(binname)
binsys := $(dirsys)/$(binname)

binuserq := $(diruser)/$(binnameq)
binsysq := $(dirsys)/$(binnameq)

cho: Makefile cho.c
	cc -O3 -o "$(binname)" cho.c
	strip -- "$(binname)"
	[ -f choq ] || ln -s cho choq

install:
	@echo "Use installuser for $(diruser)"
	@echo "    installsys for /usr/bin/cho and /usr/bin/choq"
	@echo "    installall for both"

install-deb-sys:
	@echo "Safe echo and quoting echo. Alternatives to echo and printf (for simple echos)." > description-pak
	@echo "We're going to sudo to run checkinstall so we can make a system package and install it."
	@echo " (on my system checkinstall defaults to Debian. I imagine this is system-dependent.)"
	sudo checkinstall \
		--pkgname='cho' \
		--maintainer="$(MAINT)" \
		--pkgversion=$(DATEVER) \
		--nodoc \
		make installsys
		# --fstrans=no \

installall: installuser installsys

installuser:
	[ ! -d "$(diruser)" ] && \
		{ echo "ERROR: No user dir (diruser): $(diruser): Make it yourself please." >&2; exit 1; } || \
		echo cp -- "$(binname)" "$(binuser)" && \
		echo ln -s -- cho "$(binnameq)"
	@echo
	@echo "SUCCESSFULLY INSTALLED as $(binuser) and $(binuserq)"
	@echo

installsys:
	[ ! -d "$(dirsys)" ] && \
		{ echo "ERROR: No sys dir (dirsys): $(dirsys). That's... strange." >&2; exit 1; } || \
		cp -- "$(binname)" "$(binsys)" && \
		ln -s -- cho "$(binsysq)"
	@echo
	@echo "SUCCESSFULLY INSTALLED as $(binsys) and $(binsysq)"
	@echo

vi:
	vim Makefile cho.c

