#
# alsa-lib
#
ALSA_LIB_VER    = 1.2.4
ALSA_LIB_DIR    = alsa-lib-$(ALSA_LIB_VER)
ALSA_LIB_SOURCE = alsa-lib-$(ALSA_LIB_VER).tar.bz2
ALSA_LIB_SITE   = https://www.alsa-project.org/files/pub/lib
ALSA_LIB_DEPS   = bootstrap

ALSA_LIB_AUTORECONF = YES

ALSA_LIB_CONF_OPTS = \
	--with-alsa-devdir=/dev/snd/ \
	--with-plugindir=/usr/lib/alsa \
	--without-debug \
	--with-debug=no \
	--with-versioned=no \
	--enable-symbolic-functions \
	--enable-silent-rules \
	--disable-aload \
	--disable-rawmidi \
	--disable-resmgr \
	--disable-old-symbols \
	--disable-alisp \
	--disable-ucm \
	--disable-hwdep \
	--disable-python \
	--disable-topology

$(D)/alsa-lib:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/alsa/,topology ucm)
	find $(TARGET_SHARE_DIR)/alsa/cards/ -not -name 'aliases.conf' -name '*.conf' -exec rm -f {} \;
	find $(TARGET_SHARE_DIR)/alsa/pcm/ -not -name 'default.conf' -not -name 'dmix.conf' -name '*.conf' -exec rm -f {} \;
	$(TOUCH)
