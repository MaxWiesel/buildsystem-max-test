#
# rsync
#
RSYNC_VER    = 3.1.3
RSYNC_DIR    = rsync-$(RSYNC_VER)
RSYNC_SOURCE = rsync-$(RSYNC_VER).tar.gz
RSYNC_SITE   = https://download.samba.org/pub/rsync/src
RSYNC_DEPS   = bootstrap

RSYNC_CONF_OPTS = \
	--disable-debug \
	--disable-locale

$(D)/rsync:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install-all DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
