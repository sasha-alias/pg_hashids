PG_VERSION = 9.3

MODULE_big = pg_hashids
OBJS       = pg_hashids.o hashids.o

EXTENSION = pg_hashids
DATA = pg_hashids--1.2.sql pg_hashids--1.1--1.2.sql pg_hashids--1.0--1.1.sql

PG_CONFIG = /usr/lib/postgresql/$(PG_VERSION)/bin/pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

PG_SHAREDIR := $(shell $(PG_CONFIG) --sharedir)
PG_LIBDIR := $(shell $(PG_CONFIG) --pkglibdir)

INSTALLED_DATA = $(PG_LIBDIR)/pg_hashids.so \
$(PG_SHAREDIR)/extension/pg_hashids.control \
$(PG_SHAREDIR)/extension/pg_hashids--1.2.sql \
$(PG_SHAREDIR)/extension/pg_hashids--1.1--1.2.sql \
$(PG_SHAREDIR)/extension/pg_hashids--1.0--1.1.sql

PACKAGENAME = postgresql-$(PG_VERSION)-pghashids
PACKAGEVERSION = 1.2
PACKAGEARCH = amd64
PACKAGEDIR = $(PACKAGENAME)_$(PACKAGEVERSION)_$(PACKAGEARCH)

deb: $(INSTALLED_DATA)
	mkdir -p $(PACKAGEDIR)
	mkdir -p $(PACKAGEDIR)$(PG_LIBDIR)
	mkdir -p $(PACKAGEDIR)$(PG_SHAREDIR)/extension
	cp -f $(PG_LIBDIR)/pg_hashids.so $(PACKAGEDIR)$(PG_LIBDIR)
	cp -f $(PG_SHAREDIR)/extension/pg_hashids.control $(PACKAGEDIR)$(PG_SHAREDIR)/extension
	cp -f $(PG_SHAREDIR)/extension/pg_hashids--1.2.sql $(PACKAGEDIR)$(PG_SHAREDIR)/extension
	cp -f $(PG_SHAREDIR)/extension/pg_hashids--1.1--1.2.sql $(PACKAGEDIR)$(PG_SHAREDIR)/extension
	cp -f $(PG_SHAREDIR)/extension/pg_hashids--1.0--1.1.sql $(PACKAGEDIR)$(PG_SHAREDIR)/extension
	mkdir $(PACKAGEDIR)/DEBIAN
	echo "Package: $(PACKAGENAME)" >> $(PACKAGEDIR)/DEBIAN/control
	echo "Version: $(PACKAGEVERSION)" >> $(PACKAGEDIR)/DEBIAN/control
	echo "Section: misc" >> $(PACKAGEDIR)/DEBIAN/control
	echo "Priority: extra" >> $(PACKAGEDIR)/DEBIAN/control
	echo "Architecture: $(PACKAGEARCH)" >> $(PACKAGEDIR)/DEBIAN/control
	echo "Installed-Size: 104" >> $(PACKAGEDIR)/DEBIAN/control
	echo "Depends: libc6 (>= 2.4), libpq5 (>= 9.1~), postgresql-$(PG_VERSION)" >> $(PACKAGEDIR)/DEBIAN/control
	echo "Maintainer: William Ivanski <william.ivanski@2ndquadrant.com>" >> $(PACKAGEDIR)/DEBIAN/control
	echo "Homepage: https://github.com/iCyberon/pg_hashids" >> $(PACKAGEDIR)/DEBIAN/control
	echo "Description: pg_hashids plugin for $(PG_VERSION)" >> $(PACKAGEDIR)/DEBIAN/control
	echo "  Short unique id generator for PostgreSQL, using hashids." >> $(PACKAGEDIR)/DEBIAN/control
	dpkg -b $(PACKAGEDIR)
	rm -rf $(PACKAGEDIR)
