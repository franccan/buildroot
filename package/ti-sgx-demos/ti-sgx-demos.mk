################################################################################
#
# ti-sgx-demos
#
################################################################################

# This corresponds to SDK 04.00.00.00
TI_SGX_DEMOS_VERSION = f09e59b2467cb0a5b88b6329fe35527cf65ed6e9
TI_SGX_DEMOS_SITE = git://git.ti.com/graphics/img-pvr-sdk.git
TI_SGX_DEMOS_LICENSE = Imagination Technologies License Agreement
TI_SGX_DEMOS_LICENSE_FILES = LegalNotice.txt

# Wayland demos seem to need at least X11
TI_SGX_DEMOS_SUBDIR = NullWS

# The full demo folder is +100MB, so limit to 5 like in SDK 02.00.00.00
TI_SGX_DEMOS_BINARIES = OGLES2ChameleonMan \
	OGLES2FilmTV \
	OGLES2MagicLantern \
	OGLES2ParticleSystem \
	OGLES2BinaryShader

define TI_SGX_DEMOS_INSTALL_TARGET_CMDS
	for i in $(TI_SGX_DEMOS_BINARIES) ; do \
		cp -dpfr $(@D)/targetfs/Examples/Advanced/$(TI_SGX_DEMOS_SUBDIR)/$$i \
			$(TARGET_DIR)/usr/bin/ ; \
	done
endef

$(eval $(generic-package))
