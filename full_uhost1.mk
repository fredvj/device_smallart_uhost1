$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

$(call inherit-product-if-exists, vendor/smallart/uhost1/uhost1-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/smallart/uhost1/overlay

# Inherit dalvik parameters
$(call inherit-product, frameworks/base/build/phone-hdpi-512-dalvik-heap.mk)

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

$(call inherit-product, build/target/product/full.mk)

PRODUCT_PACKAGES += \
	make_ext4fs \
	e2fsck \
	setup_fs \
	com.android.future.usb.accessory

# Hardware support

PRODUCT_PACKAGES += \
	audio.primary.sun4i \
	audio_policy.default \
	camera.sun4i \
	display.sun4i \
	gralloc.sun4i \
	hwcomposer.sun4i \
	lights.sun4i \
	sensors.sun4i

# Vold config, boot logo & init scripts

PRODUCT_COPY_FILES += \
        device/smallart/uhost1/configuration/vold.fstab:system/etc/vold.fstab \
        device/smallart/uhost1/configuration/init.sun4i.rc:root/init.sun4i.rc \
        device/smallart/uhost1/configuration/init.sun4i.usb.rc:root/init.sun4i.usb.rc \
        device/smallart/uhost1/configuration/ueventd.sun4i.rc:root/ueventd.sun4i.rc \
        device/smallart/uhost1/configuration/media_profiles.xml:system/etc/media_profiles.xml

# HAL libraries

PRODUCTS_COPY_FILES += \
	device/smallart/uhost1/prebuilt/camera.sun4i.so:system/lib/hw/camera.sun4i.so \
	device/smallart/uhost1/prebuilt/gps.sun4i.so:system/lib/hw/gps.sun4i.so \
	device/smallart/uhost1/prebuilt/lights.sun4i.so:system/lib/hw/lights.sun4i.so


# Permissions

PRODUCT_COPY_FILES += \
        frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
        frameworks/base/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
        frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
        frameworks/base/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
        frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
        frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
        frameworks/base/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
        frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
        frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
        frameworks/base/data/etc/com.tmobile.software.themes.xml:system/etc/permissions/com.tmobile.software.themes.xml \
        packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_uhost1
PRODUCT_DEVICE := uhost1
