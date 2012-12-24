# Release name
PRODUCT_RELEASE_NAME := uboot1

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

# Inherit device configuration
$(call inherit-product, device/smallart/uboot1/device_uboot1.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := uboot1
PRODUCT_NAME := cm_uboot1
PRODUCT_BRAND := smallart
PRODUCT_MODEL := uboot1
PRODUCT_MANUFACTURER := smallart
