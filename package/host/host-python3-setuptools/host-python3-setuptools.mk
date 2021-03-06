#
# python3-setuptools
#
HOST_PYTHON3_SETUPTOOLS_VER    = 44.0.0
HOST_PYTHON3_SETUPTOOLS_DIR    = setuptools-$(HOST_PYTHON3_SETUPTOOLS_VER)
HOST_PYTHON3_SETUPTOOLS_SOURCE = setuptools-$(HOST_PYTHON3_SETUPTOOLS_VER).zip
HOST_PYTHON3_SETUPTOOLS_SITE   = https://files.pythonhosted.org/packages/b0/f3/44da7482ac6da3f36f68e253cb04de37365b3dba9036a3c70773b778b485
HOST_PYTHON3_SETUPTOOLS_DEPS   = bootstrap host-python3

$(D)/host-python3-setuptools:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(HOST_PYTHON_BUILD); \
		$(HOST_PYTHON_INSTALL)
	$(REMOVE)
	$(TOUCH)
