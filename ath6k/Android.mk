ifeq ($(TARGET_DIGI_ATHEROS_FW),true)

LOCAL_PATH:= $(call my-dir)
define include-ar6k-prebuilt
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

define add-ar6k-prebuilt-file
    $(eval $(include-ar6k-prebuilt))
endef
# HW2.1.1 firmware

ar6k_hw21_dst_dir := $(TARGET_OUT_VENDOR)/lib/firmware/ath6k/AR6003/hw2.1.1

$(call add-ar6k-prebuilt-file,hw2.1.1/athwlan.bin,$(ar6k_hw21_dst_dir),athwlan.bin,athwlan)
$(call add-ar6k-prebuilt-file,hw2.1.1/Digi_6203-6233-US.bin,$(ar6k_hw21_dst_dir),Digi_6203-6233-US.bin,Digi_6203-6233-US)
$(call add-ar6k-prebuilt-file,hw2.1.1/Digi_6203-6233-World.bin,$(ar6k_hw21_dst_dir),Digi_6203-6233-World.bin,Digi_6203-6233-World)
$(call add-ar6k-prebuilt-file,hw2.1.1/Digi_6203_2_ANT-US.bin,$(ar6k_hw21_dst_dir),Digi_6203_2_ANT-US.bin,Digi_6203_2_ANT-US)
$(call add-ar6k-prebuilt-file,hw2.1.1/Digi_6203_2_ANT-World.bin,$(ar6k_hw21_dst_dir),Digi_6203_2_ANT-World.bin,Digi_6203_2_ANT-World)
$(call add-ar6k-prebuilt-file,hw2.1.1/fw-4.bin,$(ar6k_hw21_dst_dir),fw-4.bin,Digi_fw-4)
$(call add-ar6k-prebuilt-file,hw2.1.1/athtcmd_ram.bin,$(ar6k_hw21_dst_dir),athtcmd_ram.bin,Digi_athtcmd_ram)
$(call add-ar6k-prebuilt-file,hw2.1.1/nullTestFlow.bin,$(ar6k_hw21_dst_dir),nullTestFlow.bin,Digi_nullTestFlow)
$(call add-ar6k-prebuilt-file,hw2.1.1/utf.bin,$(ar6k_hw21_dst_dir),utf.bin,Digi_utf)

define add-ar6k-symlink
$(1):
	@echo "Symlink: $$@ -> $(2)"
	@mkdir -p $$(dir $$@)
	@rm -f $$@
	$$(hide) ln -sf $(2) $$@

ALL_DEFAULT_INSTALLED_MODULES += $(1)
endef

$(eval $(call add-ar6k-symlink,$(ar6k_hw21_dst_dir)/softmac,/proc/device-tree/wireless/mac-address))
$(eval $(call add-ar6k-symlink,$(ar6k_hw21_dst_dir)/bdata.0x0.bin,Digi_6203-6233-US.bin))
$(eval $(call add-ar6k-symlink,$(ar6k_hw21_dst_dir)/bdata.0x1.bin,Digi_6203-6233-World.bin))
$(eval $(call add-ar6k-symlink,$(ar6k_hw21_dst_dir)/bdata.0x2.bin,Digi_6203-6233-World.bin))
$(eval $(call add-ar6k-symlink,$(ar6k_hw21_dst_dir)/bdata.ANT-0x0.bin,Digi_6203_2_ANT-US.bin))
$(eval $(call add-ar6k-symlink,$(ar6k_hw21_dst_dir)/bdata.ANT-0x1.bin,Digi_6203_2_ANT-World.bin))
$(eval $(call add-ar6k-symlink,$(ar6k_hw21_dst_dir)/bdata.ANT-0x2.bin,Digi_6203_2_ANT-World.bin))

ar6k_hw21_dst_dir :=

endif
