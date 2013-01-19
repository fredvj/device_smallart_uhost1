# Release name
PRODUCT_RELEASE_NAME := uhost1

# Select the right boot animation
TARGET_BOOTANIMATION_NAME := horizontal-1280x800

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

# Inherit device configuration
$(call inherit-product, device/smallart/uhost1/full_uhost1.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := uhost1
PRODUCT_NAME := cm_uhost1
PRODUCT_BRAND := smallart
PRODUCT_MODEL := uhost1
PRODUCT_MANUFACTURER := smallart
