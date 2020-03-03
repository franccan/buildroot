################################################################################
#
# aaa
#
################################################################################

define AAA_INSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/machin
	echo "chose4567" > $(TARGET_DIR)/machin
endef

$(eval $(generic-package))
