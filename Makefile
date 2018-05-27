XENIAL_RELEASE="2018.04-1ppa5~ubuntu16.04"
BIONIC_RELEASE="2018.04-1ppa5~ubuntu18.04"

all: corrade magnum magnum-plugins magnum-integration magnum-extras magnum-examples

.PHONY: clean
clean:
	rm -rf upstream/*.dsc upstream/*.build upstream/*.buildinfo upstream/*.changes upstream/*.tar.xz upstream/*.upload upstream/*.ddeb upstream/*.deb

define dobuild =
rm -rf upstream/$@/debian
cp -r ubuntu/$@ upstream/$@/debian
cd upstream/$@/debian && dch -v $1 -D $2 "PPA release of $1 for ubuntu $2"
cd upstream/$@/debian && dch -r ""
cat upstream/$@/debian/changelog | head
cd upstream/$@/debian && debuild -S -sa -d
endef

.PHONY: corrade
corrade: 
	$(call dobuild,$(XENIAL_RELEASE),"xenial")
	$(call dobuild,$(BIONIC_RELEASE),"bionic")

.PHONY: magnum
magnum: 
	$(call dobuild,$(XENIAL_RELEASE),"xenial")
	$(call dobuild,$(BIONIC_RELEASE),"bionic")

.PHONY: magnum-plugins
magnum-plugins:
	$(call dobuild,$(XENIAL_RELEASE),"xenial")
	$(call dobuild,$(BIONIC_RELEASE),"bionic")

.PHONY: magnum-integration
magnum-integration:
	$(call dobuild,$(XENIAL_RELEASE),"xenial")
	$(call dobuild,$(BIONIC_RELEASE),"bionic")

.PHONY: magnum-extras
magnum-extras:
	$(call dobuild,$(XENIAL_RELEASE),"xenial")
	$(call dobuild,$(BIONIC_RELEASE),"bionic")

.PHONY: magnum-examples
magnum-examples:
	$(call dobuild,$(XENIAL_RELEASE),"xenial")
	$(call dobuild,$(BIONIC_RELEASE),"bionic")

# .PHONY: upload
# upload:
# 	cd upstream && dput ppa:chrome/magnum-graphics corrade_$(XENIAL_RELEASE)_source.changes
# 	cd upstream && dput ppa:chrome/magnum-graphics corrade_$(BIONIC_RELEASE)_source.changes

define actuallybuild = 
rm -rf upstream/$3/debian
cp -r ubuntu/$3 upstream/$3/debian
cd upstream/$3/debian && dch -v $1 -D $2 "PPA release of $1 for ubuntu $2"
cd upstream/$3/debian && dch -r ""
cat upstream/$3/debian/changelog | head
cd upstream/$3 && dpkg-buildpackage
endef

.phony: build
build:
	$(call actuallybuild,$(BIONIC_RELEASE),"bionic",corrade)
	$(call actuallybuild,$(BIONIC_RELEASE),"bionic",magnum)
	$(call actuallybuild,$(BIONIC_RELEASE),"bionic",magnum-plugins)
	$(call actuallybuild,$(BIONIC_RELEASE),"bionic",magnum-integration)
	$(call actuallybuild,$(BIONIC_RELEASE),"bionic",magnum-extras)
	$(call actuallybuild,$(BIONIC_RELEASE),"bionic",magnum-examples)