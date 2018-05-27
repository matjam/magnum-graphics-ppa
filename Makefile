XENIAL_RELEASE="2018.04-1ppa2~ubuntu16.04"
BIONIC_RELEASE="2018.04-1ppa2~ubuntu18.04"

all: corrade magnum magnum-plugins magnum-integration magnum-extras magnum-examples

.PHONY: clean
clean:
	rm -rf upstream/*.dsc upstream/*.build upstream/*.buildinfo upstream/*.changes upstream/*.tar.xz upstream/*.upload

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