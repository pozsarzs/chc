# +----------------------------------------------------------------------------+
# | CHC v0.1 * Chocking coil sizing application                                |
# | Copyright (C) 2012 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Make file                                                                  |
# +----------------------------------------------------------------------------+

include ../Makefile.global

languages = en hu

all:

clean:

install:
	@echo -n Installing manual files...
	@for x in $(languages); do \
	  if [ -e $(name)_$$x.7 ]; \
	  then \
	    $(install) --directory $(mandir)/$$x/man7; \
	    $(install) --mode $(txtmode) $(name)_$$x.7 $(mandir)/$$x/man7; \
	    mv $(mandir)/$$x/man7/$(name)_$$x.7 $(mandir)/$$x/man7/$(name).7 ; \
	  fi; \
	done
	@$(install) --directory $(mandir)/man7;
	@mv $(mandir)/en/man7/* $(mandir)/man7
	@rmdir $(mandir)/en/man7/
	@rmdir $(mandir)/en
	@echo "done."

uninstall:
	@echo -n Removing manual files...
	@for x in $(languages); do \
	  if [ -e $(name)_$$x.7 ]; \
	  then \
	    $(rm) $(mandir)/$$x/man7/$(name).7; \
	  fi; \
	done
	@$(rm) $(mandir)/man7/$(name).7;
	@echo "done."

