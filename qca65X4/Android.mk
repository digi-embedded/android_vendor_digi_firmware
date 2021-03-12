ifeq ($(BOARD_HAVE_WIFI_QCA65X4),true)

LOCAL_PATH:= $(call my-dir)
define include-qca65X4-prebuilt
    include $$(CLEAR_VARS)
    LOCAL_MODULE := $(4)
    LOCAL_MODULE_STEM := $(3)
    LOCAL_MODULE_TAGS := optional
    LOCAL_MODULE_CLASS := ETC
    LOCAL_MODULE_PATH := $(2)
    LOCAL_SRC_FILES := $(1)
    include $$(BUILD_PREBUILT)
endef

define add-qca65X4-prebuilt-file
    $(eval $(include-qca65X4-prebuilt))
endef

qca65X4_dst_dir := $(TARGET_OUT_VENDOR)/firmware

# Wi-Fi firmware
ifeq ($(QCACLD_WIFI_INTERFACE), sdio)
$(call add-qca65X4-prebuilt-file,qca65X4_proprietary/sdio/qwlan30.bin,$(qca65X4_dst_dir),qwlan30.bin,qwlan30)
$(call add-qca65X4-prebuilt-file,qca65X4_proprietary/sdio/bdwlan30_US.bin,$(qca65X4_dst_dir),bdwlan30.bin,bdwlan30)
$(call add-qca65X4-prebuilt-file,qca65X4_proprietary/sdio/otp30.bin,$(qca65X4_dst_dir),otp30.bin,otp30)
$(call add-qca65X4-prebuilt-file,qca65X4_proprietary/sdio/utf30.bin,$(qca65X4_dst_dir),utf30.bin,utf30)
else ifeq ($(QCACLD_WIFI_INTERFACE), pci)
$(call add-qca65X4-prebuilt-file,qca65X4_proprietary/pci/qwlan30.bin,$(qca65X4_dst_dir),qwlan30.bin,qwlan30)
$(call add-qca65X4-prebuilt-file,qca65X4_proprietary/pci/bdwlan30_US.bin,$(qca65X4_dst_dir),bdwlan30.bin,bdwlan30)
$(call add-qca65X4-prebuilt-file,qca65X4_proprietary/pci/otp30.bin,$(qca65X4_dst_dir),otp30.bin,otp30)
$(call add-qca65X4-prebuilt-file,qca65X4_proprietary/pci/utf.bin,$(qca65X4_dst_dir),utf.bin,utf)
else
$(error Variable QCACLD_WIFI_INTERFACE not set.)
endif

# Bluetooth firmware
$(call add-qca65X4-prebuilt-file,qca65X4_bt/nvm_tlv_3.2.bin,$(qca65X4_dst_dir),nvm_tlv_3.2.bin,nvm_tlv)
$(call add-qca65X4-prebuilt-file,qca65X4_bt/rampatch_tlv_3.2.tlv,$(qca65X4_dst_dir),rampatch_tlv_3.2.tlv,rampatch_tlv)

define add-qca65X4-symlink
$(1):
	@echo "Symlink: $$@ -> $(2)"
	@mkdir -p $$(dir $$@)
	@rm -f $$@
	$$(hide) ln -sf $(2) $$@
endef

FW_SYMLINKS_LIST := \
    $(qca65X4_dst_dir)/utfbd30.bin \
    $(qca65X4_dst_dir)/wlan/wlan_mac0 \
    $(qca65X4_dst_dir)/wlan/wlan_mac1 \
    $(qca65X4_dst_dir)/wlan/wlan_mac2 \
    $(qca65X4_dst_dir)/wlan/wlan_mac3

ifeq ($(QCACLD_WIFI_INTERFACE), pci)
FW_SYMLINKS_LIST += \
    $(qca65X4_dst_dir)/athsetup.bin \
    $(qca65X4_dst_dir)/athwlan.bin
endif

$(eval $(call add-qca65X4-symlink,$(qca65X4_dst_dir)/athwlan.bin,qwlan30.bin))
$(eval $(call add-qca65X4-symlink,$(qca65X4_dst_dir)/athsetup.bin,otp30.bin))
$(eval $(call add-qca65X4-symlink,$(qca65X4_dst_dir)/utfbd30.bin,bdwlan30.bin))
$(eval $(call add-qca65X4-symlink,$(qca65X4_dst_dir)/wlan/wlan_mac0,/proc/device-tree/wireless/mac-address))
$(eval $(call add-qca65X4-symlink,$(qca65X4_dst_dir)/wlan/wlan_mac1,/proc/device-tree/wireless/mac-address1))
$(eval $(call add-qca65X4-symlink,$(qca65X4_dst_dir)/wlan/wlan_mac2,/proc/device-tree/wireless/mac-address2))
$(eval $(call add-qca65X4-symlink,$(qca65X4_dst_dir)/wlan/wlan_mac3,/proc/device-tree/wireless/mac-address3))

# Force a dependence from the firmware so the symlinks are created
$(qca65X4_dst_dir)/qwlan30.bin: $(FW_SYMLINKS_LIST)

qca65X4_dst_dir :=

endif
