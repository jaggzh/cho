binname=cho

diruser=$(wildcard ~/bin)
dirsys=/bin

binuser="$(diruser)/$(binname)"
binsys="$(dirsys)/$(binname)"

cho: Makefile cho.c
	cc -O3 -o "$(binname)" cho.c
	strip -- "$(binname)"
	[ -f choq ] || ln -s cho choq

install:
	@echo "Use installuser for $(diruser)"
	@echo "    installsys for /usr/bin/cho"
	@echo "    installall for both"

installall: installuser installsys

installuser:
	[ ! -d "$(diruser)" ] && \
		{ echo "ERROR: No user dir (diruser): $(diruser): Make it yourself please." >&2; exit 1; } || \
		cp -- "$(binname)" "$(binuser)"
	@echo
	@echo "SUCCESSFULLY INSTALLED as $(binuser)"
	@echo

installsys:
	[ ! -d "$(dirsys)" ] && \
		{ echo "ERROR: No sys dir (dirsys): $(dirsys). That's... strange." >&2; exit 1; } || \
		cp -- "$(binname)" "$(binsys)"
	@echo
	@echo "SUCCESSFULLY INSTALLED as $(binsys)"
	@echo

vi:
	vim Makefile cho.c

