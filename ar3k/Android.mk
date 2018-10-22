ifeq ($(BOARD_USE_AR3K_DIGI_BLUETOOTH),true)

LOCAL_PATH:= $(call my-dir)
define include-ar3k-prebuilt
    include $$(CLEAR_VARS)
    LOCAL_MODULE := $(4)
    LOCAL_MODULE_STEM := $(3)
    LOCAL_MODULE_TAGS := debug eng optional
    LOCAL_MODULE_CLASS := ETC
    LOCAL_MODULE_PATH := $(2)
    LOCAL_SRC_FILES := $(1)
    ALL_DEFAULT_INSTALLED_MODULES += $(LOCAL_MODULE)
    include $$(BUILD_PREBUILT)
endef

define add-ar3k-prebuilt-file
    $(eval $(include-ar3k-prebuilt))
endef

# Digi AR3002 firmware
ar3k_hw1020200_dst_dir := $(TARGET_OUT)/etc/firmware/ar3k/1020200
$(call add-ar3k-prebuilt-file,1020200/PS_ASIC_class_1.pst,$(ar3k_hw1020200_dst_dir),PS_ASIC_class_1.pst,PS_ASIC_class_1)
$(call add-ar3k-prebuilt-file,1020200/PS_ASIC_class_2.pst,$(ar3k_hw1020200_dst_dir),PS_ASIC_class_2.pst,PS_ASIC_class_2)
$(call add-ar3k-prebuilt-file,1020200/RamPatch.txt,$(ar3k_hw1020200_dst_dir),RamPatch.txt,Digi_RamPatch)

ar3k_hw1020200_dst_dir :=

endif
