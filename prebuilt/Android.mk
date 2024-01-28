LOCAL_PATH := $(call my-dir)

RELINK := $(LOCAL_PATH)/relink.sh

#dummy file to trigger required modules
include $(CLEAR_VARS)

LOCAL_MODULE := teamwin
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/system/bin
LIB_PATH := $(shell echo $(TARGET_OUT_SHARED_LIBRARIES) | awk -F'/' '{ print $$NF }')
# Manage list
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/dump_image
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/flash_image
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/erase_image
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/bu

RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/sh
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/ueventd
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/watchdogd
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcrypto.so
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/grep
LOCAL_POST_INSTALL_CMD += $(hide) if [ -e "$(TARGET_RECOVERY_ROOT_OUT)/system/bin/egrep" ]; then \
	rm $(TARGET_RECOVERY_ROOT_OUT)/system/bin/egrep; fi; ln -s $(TARGET_RECOVERY_ROOT_OUT)/system/bin/grep $(TARGET_RECOVERY_ROOT_OUT)/system/bin/egrep; \
	if [ -e "$(TARGET_RECOVERY_ROOT_OUT)/system/bin/fgrep" ]; then \
	rm $(TARGET_RECOVERY_ROOT_OUT)/system/bin/fgrep; fi; ln -s $(TARGET_RECOVERY_ROOT_OUT)/system/bin/grep $(TARGET_RECOVERY_ROOT_OUT)/system/bin/fgrep;

ifneq ($(wildcard external/zip/Android.mk),)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_OPTIONAL_EXECUTABLES)/zip
endif
ifneq ($(wildcard external/unzip/Android.mk),)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_OPTIONAL_EXECUTABLES)/unzip
endif
ifneq ($(wildcard system/libziparchive/Android.bp),)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/ziptool.recovery
endif
ifneq ($(wildcard external/one-true-awk/Android.bp),)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/awk
endif
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/pigz
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/fsck.fat
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/fatlabel
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/mkfs.fat

ifneq ($(filter $(PRODUCT_USE_DYNAMIC_PARTITIONS) $(TW_INCLUDE_FASTBOOTD),true),)
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/fastbootd
endif
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/bc
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/e2fsck
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/e2fsdroid
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/mke2fs
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/tune2fs
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/resize2fs
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/simg2img
ifneq ($(TW_OZIP_DECRYPT_KEY),)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/ozip_decrypt
endif
ifneq ($(TARGET_ARCH), x86_64)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/linker
endif
ifeq ($(TARGET_ARCH), x86_64)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/linker64
endif
ifeq ($(TARGET_ARCH), arm64)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/linker64
endif
#RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/twrpmtp
ifneq ($(filter $(PRODUCT_USE_DYNAMIC_PARTITIONS) $(TW_INCLUDE_FASTBOOTD),true),)
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/android.hardware.fastboot@1.0.so
endif
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/ld-android.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libandroid_runtime_lazy.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libc.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libdl.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libm.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libbootloader_message.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libfs_mgr.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libfscrypttwrp.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libgsi.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libkeyutils.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/liblogwrap.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/liblp.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libprocessgroup.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libprocessgroup_setup.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libadbd.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libadbd_services.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libcap.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libminijail.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libunwindstack.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libcgrouprc.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libbinderthreadstate.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libsquashfs_utils.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libjsoncpp.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libmdnssd.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.boot@1.0.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.boot@1.1.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.boot@1.2.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libasyncio.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libfec.so

RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libinit.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libresetprop.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/bootstrap/libdl_android.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libprotobuf-cpp-lite.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libbinder.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libbinder_ndk.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libchrome.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libevent.so
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/keystore
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/keystore_auth
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/keystore_cli_v2
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/hwservicemanager
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/servicemanager
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/vold_prepare_subdirs
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_VENDOR_EXECUTABLES)/vndservicemanager
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/toybox
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_VENDOR_EXECUTABLES)/hw/android.hardware.health@2.0-service
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_VENDOR_EXECUTABLES)/hw/android.hardware.health@2.1-service
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/toybox
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/minadbd

RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcutils.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcrecovery.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libusbhost.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libutils.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_com_err.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_e2p.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2fs.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_profile.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_uuid.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_misc.so
ifneq ($(wildcard external/e2fsprogs/lib/quota/Android.mk),)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_quota.so
endif
ifneq ($(wildcard external/e2fsprogs/lib/ext2fs/Android.*),)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2fs.so
endif
ifneq ($(wildcard external/e2fsprogs/lib/blkid/Android.*),)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_blkid.so
endif
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libpng.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblog.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libstdc++.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libz.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libminuitwrp.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libminadbd.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libmtdutils.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libtar.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libtwadbbu.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libtwrpdigest.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libutil-linux.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libblkid.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libmmcutils.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libbmlutils.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libflashutils.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libfusesideload.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libbootloader_message_twrp.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcrypto.so \
$(if $(WITH_CRYPTO_UTILS),$(TARGET_OUT_SHARED_LIBRARIES)/libcrypto_utils.so)
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libpackagelistparser.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblzma.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/$(LIB_PATH)/libbacktrace.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libbootloader_message.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libunwind.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libbase.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libc++.so
# Dynamically loaded by libc and may prevent unmounting system if it is not present in sbin
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libnetd_client.so
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/toolbox

ifneq ($(TW_OEM_BUILD),true)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/twrp
else
	TW_EXCLUDE_MTP := true
endif

ifneq ($(TW_EXCLUDE_MTP), true)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libtwrpmtp-ffs.so
endif

RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext4_utils.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libaosprecovery.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhardware.so
ifneq ($(TW_INCLUDE_JPEG),)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libjpeg.so
endif
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libselinux.so
ifneq ($(TW_NO_EXFAT), true)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libexfat_twrp.so
else
	TW_NO_EXFAT_FUSE := true
endif
ifeq ($(TW_INCLUDE_CRYPTO), true)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcryptfsfde.so
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libdexfile_support.so
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libf2fs_sparseblock.so
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.authsecret@1.0.so
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.oemlock@1.0.so
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/libnos_transport.so
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/libnos_datagram.so
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcrypto.so
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libgpt_twrp.so
	ifeq ($(TARGET_HW_DISK_ENCRYPTION),true)
		ifeq ($(TARGET_CRYPTFS_HW_PATH),)
			RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/libcryptfs_hw.so
		else
			RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcryptfs_hw.so
		endif
	endif
	# FBE files
	ifeq ($(TW_INCLUDE_CRYPTO_FBE), true)
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libtwrpfscrypt.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.security.maintenance-ndk_platform.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.system.keystore2-V1-ndk_platform.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.security.apc-ndk_platform.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.security.authorization-ndk_platform.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeymint_support.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.security.keymint-V1-ndk_platform.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.frameworks.stats-V1-ndk_platform.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.security.secureclock-V1-ndk_platform.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libgatekeeper.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libgatekeeper_aidl.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster_messages.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libbinder.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libprotobuf-cpp-lite.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libsoftkeymasterdevice.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.gatekeeper@1.0.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeystore2_aaid.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeystore2_apc_compat.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeystore2_crypto.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkm_compat_service.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeystore2_vintf_cpp.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.security.compat-ndk_platform.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkm_compat.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeymint.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/lib_android_keymaster_keymint_utils.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcppbor_external.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcppbor.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libpuresoftkeymasterdevice.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcppcose_rkp.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.security.sharedsecret-V1-ndk_platform.so
		RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/hwservicemanager
		RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/avbctl
		RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/keystore
		RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/keystore2
		RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/keystore_cli
		RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/servicemanager
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.system.wifi.keystore@1.0.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.vibrator@1.0.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.vibrator@1.1.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.vibrator@1.2.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.vibrator-V1-ndk_platform.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.vibrator-V1-cpp.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libstatslog.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libsoft_attestation_cert.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libdiskconfig.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhardware_legacy.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libincfs.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.health.storage@1.0.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.health.storage@1.0.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.health.storage-V1-ndk_platform.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhardware_legacy.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.system.suspend@1.0.so
		RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/fscryptpolicyget
		ifneq ($(TW_EXCLUDE_LIBXML2), true)
		    RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so
		endif

		ifneq ($(wildcard system/keymaster/keymaster_stl.cpp),)
			RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster_portable.so
			RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster_staging.so
		endif
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libwifikeystorehal.so
		ifneq ($(wildcard hardware/interfaces/weaver/Android.bp),)
			RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.weaver@1.0.so
		endif
		ifneq ($(wildcard hardware/interfaces/weaver/1.0/Android.bp),)
			RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.weaver@1.0.so
		endif
		ifneq ($(wildcard hardware/interfaces/confirmationui/1.0/Android.bp),)
			RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.confirmationui@1.0.so
		endif
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libsoftkeymasterdevice.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.keymaster@4.0.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.keymaster@4.1.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4support.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4_1support.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libutilscallstack.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libunwindstack.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libdexfile.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libservices.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster_portable.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhwbinder.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeystore-attestation-application-id.so
		# lshal can be useful for seeing if you have things like the keymaster working properly, but it isn't needed for TWRP to work
		#RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/lshal
		#RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblshal.so
		#RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libssl.so
		#RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhidl-gen-hash.so
	endif
endif
ifneq ($(filter $(TW_INCLUDE_CRYPTO) $(TW_SUPPORT_INPUT_AIDL_HAPTICS), true),)
    RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.vibrator-V2-cpp.so
    RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.vibrator-V2-ndk_platform.so
endif
ifeq ($(AB_OTA_UPDATER), true)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/system/bin/update_engine_sideload
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/update_engine_sideload
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_VENDOR_EXECUTABLES)/hw/android.hardware.boot@1.0-service
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_VENDOR_EXECUTABLES)/hw/android.hardware.boot@1.1-service
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_VENDOR_EXECUTABLES)/hw/android.hardware.boot@1.2-service
endif
ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS),true)
	ifneq ($(TW_INCLUDE_LPDUMP),)
		RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/bootctl
		RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/lpdump
		RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/lpdumpd
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblpdump.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblpdump_interface-V1-cpp.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libprotobuf-cpp-full.so
	endif
	ifneq ($(TW_INCLUDE_LPTOOLS),)
		RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/lptools
	endif
endif
ifneq ($(wildcard system/core/libsparse/Android.*),)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libsparse.so
endif
ifneq ($(TW_EXCLUDE_ENCRYPTED_BACKUPS),)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/openaes
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libopenaes.so
endif
ifeq ($(TARGET_USERIMAGES_USE_F2FS), true)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/make_f2fs
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/fsck.f2fs
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/sload_f2fs
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblz4.so
endif
ifneq ($(wildcard system/core/reboot/Android.*),)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/reboot
endif
ifneq ($(TW_DISABLE_TTF), true)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libft2.so
endif
ifneq ($(TW_RECOVERY_ADDITIONAL_RELINK_BINARY_FILES),)
	RECOVERY_BINARY_SOURCE_FILES += $(TW_RECOVERY_ADDITIONAL_RELINK_BINARY_FILES)
endif
ifneq ($(TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES),)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES)
endif
ifneq ($(TW_RECOVERY_ADDITIONAL_RELINK_VENDOR_HW_BINARY_FILES),)
    RECOVERY_VENDOR_HW_BINARY_FILES += $(TW_RECOVERY_ADDITIONAL_RELINK_VENDOR_HW_BINARY_FILES)
endif
ifneq ($(wildcard external/pcre/Android.mk),)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libpcre.so
endif
ifeq ($(TW_INCLUDE_NTFS_3G),true)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/mount.ntfs
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/fsck.ntfs
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/mkfs.ntfs
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libntfs-3g.so
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libfuse-lite.so
else
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/ntfs-3g
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/ntfsfix
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/mkntfs
endif
ifeq ($(BOARD_HAS_NO_REAL_SDCARD),)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/sgdisk
endif
ifneq ($(TW_OZIP_DECRYPT_KEY),)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/ozip_decrypt
endif
ifeq ($(TWRP_INCLUDE_LOGCAT), true)
	RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/logcat
	ifeq ($(TARGET_USES_LOGD), true)
		RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/logd
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libsysutils.so
		RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libnl.so
	endif
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libpcrecpp.so
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblogcat.so
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcap.so
endif
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libpcre2.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libvndksupport.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhwbinder.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhidlbase.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhidltransport.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.frameworks.stats@1.0.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.keymaster@3.0.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libziparchive.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_blkid.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_quota.so

RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhidl-gen-utils.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libvintf.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libtinyxml2.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.token@1.0.so
ifneq ($(wildcard system/core/libkeyutils/Android.bp),)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeyutils.so
endif
ifeq ($(TARGET_ARCH), arm64)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libclang_rt.ubsan_standalone-aarch64-android.so
endif
ifeq ($(TARGET_ARCH), arm)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libclang_rt.ubsan_standalone-arm-android.so
endif
ifeq ($(TARGET_ARCH), x86_64)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libclang_rt.ubsan_standalone-x86_64-android.so
endif
ifeq ($(TARGET_ARCH), x86)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libclang_rt.ubsan_standalone-i686-android.so
endif
ifeq ($(TARGET_ARCH), mips)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libclang_rt.ubsan_standalone-mips-android.so
endif
ifeq ($(TARGET_ARCH), mips64)
	RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libclang_rt.ubsan_standalone-mips64-android.so
endif
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblogwrap.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_misc.so

ifneq ($(TW_EXCLUDE_NANO), true)
    RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_SYSTEM_EXT_EXECUTABLES)/nano
    RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libncurses.so
    RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/libssh.so
    RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libssl.so
endif

ifneq ($(TW_EXCLUDE_BASH), true)
    RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_SYSTEM_EXT_EXECUTABLES)/bash
    RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libncurses.so
endif

include $(CLEAR_VARS)
LOCAL_MODULE := relink_libraries
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/
ifneq ($(TARGET_ARCH), arm64)
    ifneq ($(TARGET_ARCH), x86_64)
        LOCAL_POST_INSTALL_CMD += $(RELINK) $(TARGET_RECOVERY_ROOT_OUT)/system/lib $(RECOVERY_LIBRARY_SOURCE_FILES)
    else
        LOCAL_POST_INSTALL_CMD += $(RELINK) $(TARGET_RECOVERY_ROOT_OUT)/system/lib64 $(RECOVERY_LIBRARY_SOURCE_FILES)
    endif
else
LOCAL_POST_INSTALL_CMD += $(RELINK) $(TARGET_RECOVERY_ROOT_OUT)/system/lib64 $(RECOVERY_LIBRARY_SOURCE_FILES)
endif
TARGET_LIBRARY_RELINK_FILES := $(notdir $(RECOVERY_LIBRARY_SOURCE_FILES))
TARGET_BASE_LIBRARY_RELINK_MODULES := $(basename $(TARGET_LIBRARY_RELINK_FILES))
TARGET_RELINK_LIBRARY_MODULES :=  $(filter-out libdexfile, $(TARGET_BASE_LIBRARY_RELINK_MODULES))
LOCAL_REQUIRED_MODULES += $(TARGET_RELINK_LIBRARY_MODULES)
include $(BUILD_PHONY_PACKAGE)


include $(CLEAR_VARS)
LOCAL_MODULE := relink_binaries
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/
LOCAL_POST_INSTALL_CMD += $(RELINK) $(TARGET_RECOVERY_ROOT_OUT)/system/bin $(RECOVERY_BINARY_SOURCE_FILES)
TARGET_BINARY_RELINK_FILES := $(filter-out bu, $(notdir $(RECOVERY_BINARY_SOURCE_FILES)))
LOCAL_REQUIRED_MODULES += $(TARGET_BINARY_RELINK_FILES)
include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := relink_vendor_hw_binaries
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/
LOCAL_POST_INSTALL_CMD += $(RELINK) $(TARGET_RECOVERY_ROOT_OUT)/vendor/bin/hw $(RECOVERY_VENDOR_HW_BINARY_FILES)
TARGET_VENDOR_BINARY_RELINK_FILES := $(notdir $(RECOVERY_VENDOR_HW_BINARY_FILES))
LOCAL_REQUIRED_MODULES += $(TARGET_VENDOR_BINARY_RELINK_FILES)
$(warning vendor_hw: $(LOCAL_POST_INSTALL_CMD))
include $(BUILD_PHONY_PACKAGE)

#build out TWRP ramdisk
include $(CLEAR_VARS)
LOCAL_MODULE := twrp_ramdisk
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)
LOCAL_POST_INSTALL_CMD += \
    mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/sbin; ln -sf /system/bin/sh $(TARGET_RECOVERY_ROOT_OUT)/sbin/sh && \
    mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/system/etc/selinux/ && \
    mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/vendor/etc/selinux/ && \
    cp $(TARGET_OUT_ETC)/selinux/plat_service_contexts $(TARGET_RECOVERY_ROOT_OUT)/system/etc/selinux/plat_service_contexts && \
    cp $(TARGET_OUT_ETC)/selinux/plat_hwservice_contexts $(TARGET_RECOVERY_ROOT_OUT)/system/etc/selinux/plat_hwservice_contexts && \
    cp $(TARGET_OUT_VENDOR_ETC)/selinux/vndservice_contexts $(TARGET_RECOVERY_ROOT_OUT)/vendor/etc/selinux/vndservice_contexts && \
    cp $(TARGET_OUT_VENDOR_ETC)/selinux/vendor_hwservice_contexts $(TARGET_RECOVERY_ROOT_OUT)/vendor/etc/selinux/vendor_hwservice_contexts && \
    cp $(TARGET_OUT_ETC)/selinux/plat_keystore2_key_contexts $(TARGET_RECOVERY_ROOT_OUT)/system/etc/selinux/plat_keystore2_key_contexts
    ifeq ($(TARGET_USES_MKE2FS), true)
        LOCAL_POST_INSTALL_CMD += \
            && cp $(TARGET_OUT_ETC)/mke2fs.conf $(TARGET_RECOVERY_ROOT_OUT)/system/etc/mke2fs.conf
    endif
LOCAL_REQUIRED_MODULES += init_second_stage.recovery \
    reboot.recovery \
    plat_service_contexts \
    plat_hwservice_contexts \
    plat_hardware_contexts \
    vndservice_contexts \
    plat_keystore2_key_contexts \
    vendor_hwservice_contexts

include $(BUILD_PHONY_PACKAGE)

# copy license file for OpenAES
ifneq ($(TW_EXCLUDE_ENCRYPTED_BACKUPS),)
	include $(CLEAR_VARS)
	LOCAL_MODULE := openaes_license
	LOCAL_MODULE_TAGS := optional
	LOCAL_MODULE_CLASS := EXECUTABLES
	LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/license/openaes
	LOCAL_SRC_FILES := ../openaes/LICENSE
	include $(BUILD_PREBUILT)
endif

ifeq ($(TW_USE_TOOLBOX), true)
   include $(CLEAR_VARS)
   LOCAL_MODULE := mkshrc_twrp
   LOCAL_MODULE_STEM := mkshrc
   LOCAL_MODULE_TAGS := optional
   LOCAL_MODULE_CLASS := ETC
   LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/etc
   LOCAL_SRC_FILES := $(LOCAL_MODULE)
   include $(BUILD_PREBUILT)
endif

#Parted
include $(CLEAR_VARS)
LOCAL_MODULE := parted
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/system/bin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

ifeq ($(wildcard external/magisk-prebuilt/Android.*),)
	$(warning Magisk prebuilt tools not found!)
	$(warning Please place https://github.com/PitchBlackRecoveryProject/external_magisk-prebuilt)
	$(warning into external/magisk-prebuilt)
	$(error magiskboot prebuilts not present; exiting)
endif

# Include tzdata in TWRP to fix "__bionic_open_tzdata" log spam
# Dummy file to apply post-install patch
ifneq ($(TW_EXCLUDE_TZDATA), true)
    include $(CLEAR_VARS)
    LOCAL_MODULE := tzdata_twrp
    LOCAL_MODULE_TAGS := optional
    LOCAL_MODULE_CLASS := ETC
    LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)/system/bin
    LOCAL_REQUIRED_MODULES := tzdata

    LOCAL_POST_INSTALL_CMD += \
        mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/system/usr/share/zoneinfo; \
        cp -f $(TARGET_OUT)/usr/share/zoneinfo/tzdata $(TARGET_RECOVERY_ROOT_OUT)/system/usr/share/zoneinfo/;
    include $(BUILD_PHONY_PACKAGE)
endif

include $(CLEAR_VARS)
LOCAL_MODULE := nano_twrp
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)/system/bin
LOCAL_REQUIRED_MODULES := nano libncurses
LOCAL_POST_INSTALL_CMD += \
    cp -rf $(TARGET_OUT_SYSTEM_EXT_ETC)/nano $(TARGET_RECOVERY_ROOT_OUT)/system/etc/; \
    cp -rf external/libncurses/lib/terminfo $(TARGET_RECOVERY_ROOT_OUT)/system/etc/;
include $(BUILD_PHONY_PACKAGE)

ifneq ($(TW_EXCLUDE_BASH), true)
	include $(CLEAR_VARS)
	LOCAL_MODULE := bash_twrp
	LOCAL_MODULE_TAGS := optional
	LOCAL_MODULE_CLASS := ETC
	LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)/system/bin
	LOCAL_REQUIRED_MODULES := bash

	LOCAL_POST_INSTALL_CMD += \
		mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/system/etc/bash/; \
		cp -rf external/bash/etc/* $(TARGET_RECOVERY_ROOT_OUT)/system/etc/bash/; \
        sed -i 's/ro.lineage.device/ro.product.device/' $(TARGET_RECOVERY_ROOT_OUT)/system/etc/bash/bashrc; \
        sed -i '/export TERM/d' $(TARGET_RECOVERY_ROOT_OUT)/system/etc/bash/bashrc; \
        mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/sbin; \
        ln -sf /system/bin/bash $(TARGET_RECOVERY_ROOT_OUT)/sbin/bash;
	include $(BUILD_PHONY_PACKAGE)
endif

