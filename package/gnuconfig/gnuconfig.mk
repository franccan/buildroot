################################################################################
#
# gnuconfig
#
################################################################################

GNUCONFIG_VERSION = bad92f031d2d5d980389d2c833f1c218a57443e6
GNUCONFIG_SITE = git://git.savannah.gnu.org/config.git
GNUCONFIG_LICENSE = GPL-3.0+

define HOST_GNUCONFIG_INSTALL_CMDS
	$(foreach f,config.guess config.sub,\
		$(INSTALL) -D $(@D)/$(f) $(HOST_DIR)/usr/share/gnuconfig/$(f)
	)
endef

$(eval $(host-generic-package))
