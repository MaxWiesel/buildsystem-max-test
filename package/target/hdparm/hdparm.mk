#
# hdparm
#
HDPARM_VER    = 9.60
HDPARM_DIR    = hdparm-$(HDPARM_VER)
HDPARM_SOURCE = hdparm-$(HDPARM_VER).tar.gz
HDPARM_SITE   = https://sourceforge.net/projects/hdparm/files/hdparm
HDPARM_DEPS   = bootstrap

$(D)/hdparm:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE) $(TARGET_CONFIGURE_ENV); \
		$(MAKE) install DESTDIR=$(TARGET_DIR) mandir=$(REMOVE_mandir)
	$(REMOVE)
	$(TOUCH)
