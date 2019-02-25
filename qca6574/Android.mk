ifeq ($(BOARD_HAVE_WIFI_QCA6574),true)

LOCAL_PATH:= $(call my-dir)
define include-qca6574-prebuilt
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

define add-qca6574-prebuilt-file
    $(eval $(include-qca6574-prebuilt))
endef

qca6574_dst_dir := $(TARGET_OUT_VENDOR)/firmware

$(call add-qca6574-prebuilt-file,qca6574_proprietary/qwlan30.bin,$(qca6574_dst_dir),qwlan30.bin,qwlan30)
$(call add-qca6574-prebuilt-file,qca6574_proprietary/fakeboar.bin,$(qca6574_dst_dir),fakeboar.bin,fakeboar)
$(call add-qca6574-prebuilt-file,qca6574_proprietary/otp.bin,$(qca6574_dst_dir),otp.bin,otp)
$(call add-qca6574-prebuilt-file,qca6574_proprietary/utf.bin,$(qca6574_dst_dir),utf.bin,utf)

define add-qca6574-symlink
$(1):
	@echo "Symlink: $$@ -> $(2)"
	@mkdir -p $$(dir $$@)
	@rm -f $$@
	$$(hide) ln -sf $(2) $$@

ALL_DEFAULT_INSTALLED_MODULES += $(1)
endef

$(eval $(call add-qca6574-symlink,$(qca6574_dst_dir)/athwlan.bin,qwlan30.bin))
$(eval $(call add-qca6574-symlink,$(qca6574_dst_dir)/athsetup.bin,otp.bin))
$(eval $(call add-qca6574-symlink,$(qca6574_dst_dir)/wlan/wlan_mac0,/proc/device-tree/wireless/mac-address))
$(eval $(call add-qca6574-symlink,$(qca6574_dst_dir)/wlan/wlan_mac1,/proc/device-tree/wireless/mac-address1))
$(eval $(call add-qca6574-symlink,$(qca6574_dst_dir)/wlan/wlan_mac2,/proc/device-tree/wireless/mac-address2))
$(eval $(call add-qca6574-symlink,$(qca6574_dst_dir)/wlan/wlan_mac3,/proc/device-tree/wireless/mac-address3))

qca6574_dst_dir :=

endif
