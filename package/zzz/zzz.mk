################################################################################
#
# zzz
#
################################################################################

ZZZ_DEPENDENCIES = aaa

define ZZZ_INSTALL_TARGET_CMDS
	echo "bidule" > $(TARGET_DIR)/bidule
endef

$(eval $(generic-package))
