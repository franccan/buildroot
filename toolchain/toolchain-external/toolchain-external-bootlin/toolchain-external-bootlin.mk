################################################################################
#
# toolchain-external-bootlin
#
################################################################################

TOOLCHAIN_EXTERNAL_BOOTLIN_ARCH = $(call qstrip,$(BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_ARCH))
TOOLCHAIN_EXTERNAL_BOOTLIN_LIBC = $(call qstrip,$(BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_LIBC))
TOOLCHAIN_EXTERNAL_BOOTLIN_VARIANT = $(call qstrip,$(BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_VARIANT))

TOOLCHAIN_EXTERNAL_BOOTLIN_VERSION = 2018.02-1
TOOLCHAIN_EXTERNAL_BOOTLIN_SITE = https://toolchains.bootlin.com/downloads/releases/toolchains/$(TOOLCHAIN_EXTERNAL_BOOTLIN_ARCH)/tarballs

TOOLCHAIN_EXTERNAL_BOOTLIN_SOURCE = $(TOOLCHAIN_EXTERNAL_BOOTLIN_ARCH)--$(TOOLCHAIN_EXTERNAL_BOOTLIN_LIBC)--$(TOOLCHAIN_EXTERNAL_BOOTLIN_VARIANT)-$(TOOLCHAIN_EXTERNAL_BOOTLIN_VERSION).tar.bz2

$(eval $(toolchain-external-package))
