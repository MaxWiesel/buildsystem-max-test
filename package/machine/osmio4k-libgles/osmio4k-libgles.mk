#
# osmio4k-libgles
#
OSMIO4K_LIBGLES_VER    = 2.0
OSMIO4K_LIBGLES_DIR    = edision-libv3d-$(OSMIO4K_LIBGLES_VER)
OSMIO4K_LIBGLES_SOURCE = edision-libv3d-$(OSMIO4K_LIBGLES_VER).tar.xz
OSMIO4K_LIBGLES_SITE   = http://source.mynonpublic.com/edision
OSMIO4K_LIBGLES_DEPS   = bootstrap

$(D)/osmio4k-libgles:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	cp -a $(PKG_BUILD_DIR)/lib/* $(TARGET_DIR)/usr/lib
	ln -sf libv3ddriver.so.$(OSMIO4K_LIBGLES_VER) $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so.$(OSMIO4K_LIBGLES_VER) $(TARGET_LIB_DIR)/libGLESv2.so
	install -m 0644 $(PKG_BUILD_DIR)/include/v3dplatform.h $(TARGET_INCLUDE_DIR)
	for d in EGL GLES GLES2 GLES3 KHR; do \
		install -m 0755 -d $(TARGET_INCLUDE_DIR)/$$d; \
		for f in $(PKG_BUILD_DIR)/include/$$d/*.h; do \
			install -m 0644 $$f $(TARGET_INCLUDE_DIR)/$$d; \
		done; \
	done
	$(REMOVE)
	$(TOUCH)
