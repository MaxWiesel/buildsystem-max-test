#
# sysvinit
#
SYSVINIT_VER    = 2.97
SYSVINIT_DIR    = sysvinit-$(SYSVINIT_VER)
SYSVINIT_SOURCE = sysvinit-$(SYSVINIT_VER).tar.xz
SYSVINIT_SITE   = http://download.savannah.nongnu.org/releases/sysvinit

SYSVINIT_PATCH  = \
	0001-install.patch\
	0001-crypt-lib.patch \
	0002-change-INIT_FIFO.patch \
	0003-pidof-add-m-option.patch \
	0004-realpath.patch

$(D)/sysvinit: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(BUILD_ENV) \
		$(MAKE) SULOGINLIBS=-lcrypt; \
		$(MAKE) install ROOT=$(TARGET_DIR) mandir=/.remove
	mkdir -p $(TARGET_DIR)/etc/{init.d,rc{{0..6},S}.d}
	$(INSTALL_DATA) $(PKG_FILES_DIR)/inittab $(TARGET_DIR)/etc/inittab
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/autologin $(TARGET_DIR)/bin/autologin
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/rc $(TARGET_DIR)/etc/init.d
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/rcS $(TARGET_DIR)/etc/init.d
	$(INSTALL_DATA) $(PKG_FILES_DIR)/rcS-default $(TARGET_DIR)/etc/default/rcS
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/service $(TARGET_DIR)/sbin/service
#	$(INSTALL_EXEC) $(PKG_FILES_DIR)/bootlogd.init $(TARGET_DIR)/etc/init.d/bootlogd
#	$(INSTALL_DATA) $(PKG_FILES_DIR)/volatiles.01_bootlogd $(TARGET_DIR)/etc/default/volatiles/01_bootlogd
#	ln -sf bootlogd $(TARGET_DIR)/etc/init.d/stop-bootlogd
#	$(UPDATE-RC.D) bootlogd start 07 S .
#	$(UPDATE-RC.D) stop-bootlogd start 99 2 3 4 5 .
	rm -f $(addprefix $(TARGET_DIR)/sbin/,fstab-decode logsave runlevel telinit)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,lastb)
	$(PKG_REMOVE)
	$(TOUCH)
