# Include all languages
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Include full feature set
$(call inherit-product, $(SRC_TARGET_DIR)/product/full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

# Inherit dalvik parameters
$(call inherit-product, frameworks/base/build/tablet-dalvik-heap.mk)

# Include vendor specific things - if existent
$(call inherit-product-if-exists, vendor/smallart/uhost1/uhost1-vendor.mk)

DEVICE_PACKAGE_OVERLAYS := \
	device/smallart/uhost1/overlay

LOCAL_PATH := device/smallart/uhost1
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/prebuilt/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_COPY_FILES += \
	$(LOCAL_KERNEL):kernel

PRODUCT_PACKAGES += \
	make_ext4fs \
	e2fsck \
	setup_fs \
	com.android.future.usb.accessory

# Hardware support

PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.primary.sun4i \
	audio_policy.default \
	libaudioutils \
	camera.sun4i \
	display.sun4i \
	gralloc.sun4i \
	hwcomposer.sun4i \
	lights.sun4i \
	sensors.sun4i

# CedarX libraries
PRODUCT_PACKAGES += \
	libCedarA \
	libCedarX \
	libcedarv \
	libcedarxbase \
	libcedarxosal \
	libcedarxsftdemux \
	libswdrm

# Vold config, boot logo & init scripts

PRODUCT_COPY_FILES += \
        device/smallart/uhost1/configuration/vold.fstab:system/etc/vold.fstab \
        device/smallart/uhost1/configuration/init.sun4i.rc:root/init.sun4i.rc \
        device/smallart/uhost1/configuration/init.sun4i.usb.rc:root/init.sun4i.usb.rc \
        device/smallart/uhost1/configuration/ueventd.sun4i.rc:root/ueventd.sun4i.rc \
        device/smallart/uhost1/configuration/media_profiles.xml:system/etc/media_profiles.xml \
	device/smallart/uhost1/configuration/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
	device/smallart/uhost1/configuration/default-settings.sh:system/etc/default-settings.sh

# HAL libraries

PRODUCTS_COPY_FILES += \
	device/smallart/uhost1/prebuilt/camera.sun4i.so:system/lib/hw/camera.sun4i.so \
	device/smallart/uhost1/prebuilt/gps.sun4i.so:system/lib/hw/gps.sun4i.so \
	device/smallart/uhost1/prebuilt/lights.sun4i.so:system/lib/hw/lights.sun4i.so

# Bluetooth config

PRODUCT_COPY_FILES += \
	device/smallart/uhost1/prebuilt/btusb.ko:system/vendor/modules/btusb.ko \
        system/bluetooth/data/main.conf:system/etc/bluetooth/main.conf

# Keyboard support files

PRODUCT_COPY_FILES += \
	device/smallart/uhost1/prebuilt/qwertz.kcm:system/usr/keychars/qwertz.kcm \
	device/smallart/uhost1/prebuilt/qwertz.kl:system/usr/keylayout/qwertz.kl \
	device/smallart/uhost1/prebuilt/sun4i-ir.kl:system/usr/keylayout/sun4i-ir.kl \
	device/smallart/uhost1/prebuilt/sun4i-keyboard.kl:system/usr/keylayout/sun4i-keyboard.kl \
	device/smallart/uhost1/configuration/german-keyboard.sh:system/bin/german-keyboard.sh

# Permissions

PRODUCT_COPY_FILES += \
        device/smallart/uhost1/configuration/television_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
	device/smallart/uhost1/configuration/television_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
        frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
        frameworks/base/data/etc/com.tmobile.software.themes.xml:system/etc/permissions/com.tmobile.software.themes.xml \
        packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

PRODUCT_AAPT_CONFIG := normal ldpi mdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi
PRODUCT_LOCALES += hdpi

PRODUCT_BUILD_PROP_OVERRIDES += \
	BUILD_UTC_DATE=0 \
	PRODUCT_BRAND=samsung \
	PRODUCT_MANUFACTURER=samsung \
	PRODUCT_NAME=GT-P1000
