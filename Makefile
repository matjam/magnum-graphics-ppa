XENIAL_RELEASE="2018.04-0ubuntu0~16.04"
BIONIC_RELEASE="2018.04-0ubuntu0~18.04"

all: corrade

.PHONY: clean
clean:
	rm -rf upstream/*.dsc upstream/*.build upstream/*.buildinfo upstream/*.changes upstream/*.tar.xz upstream/*.upload

define dobuild =
rm -rf upstream/$@/debian
cp -r ubuntu/$@ upstream/$@/debian
cd upstream/$@/debian && dch -v $1 -D $2 "PPA release of $1 for ubuntu $2"
cd upstream/$@/debian && dch -r ""
cat upstream/$@/debian/changelog | head
cd upstream/$@/debian && debuild -S -sa
endef

.PHONY: corrade
corrade: 
	$(call dobuild,$(XENIAL_RELEASE),"xenial")
	$(call dobuild,$(BIONIC_RELEASE),"bionic")

.PHONY: magnum-graphics
magnum: 
	$(call dobuild,$(XENIAL_RELEASE),"xenial")
	$(call dobuild,$(BIONIC_RELEASE),"bionic")

.PHONY: upload
upload:
	cd upstream && dput ppa:chrome/magnum-graphics corrade_$(XENIAL_RELEASE)_source.changes
	cd upstream && dput ppa:chrome/magnum-graphics corrade_$(BIONIC_RELEASE)_source.changes
