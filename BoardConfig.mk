USE_CAMERA_STUB := true

# inherit from the proprietary version
-include vendor/smallart/uhost1/BoardConfigVendor.mk

# BOARD_USES_UBOOT := true

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

TARGET_BOARD_PLATFORM := sun4i
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_BOOTLOADER_BOARD_NAME := a10

TARGET_GLOBAL_CFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp
ARCH_ARM_HAVE_TLS_REGISTER := true

TARGET_SPECIFIC_HEADER_PATH := device/smallart/uhost1/include

TARGET_USE_SCORPION_BIONIC_OPTIMIZATION := true

BOARD_HAS_VIBRATOR_IMPLEMENTATION := ../../device/smallart/uhost1/vibrator.c

BOARD_HAVE_BLUETOOTH := true

BOARD_WIFI_VENDOR := realtek
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_rtl
BOARD_HOSTAPD_DRIVER := WEXT
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_rtl
BOARD_WLAN_DEVICE := rtl8192cu
WIFI_DRIVER_MODULE_PATH := "/system/vendor/modules/8192cu.ko"
WIFI_DRIVER_MODULE_NAME := 8192cu

TARGET_CUSTOM_WIFI := ../../hardware/realtek/wlan/wifi_realtek.c

BOARD_EGL_CFG := device/smallart/uhost1/configuration/egl.cfg
BOARD_USE_SKIA_LCDTEXT := true
USE_OPENGL_RENDERER := true
ENABLE_WEBGL := true

TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true

BOARD_USE_LEGACY_TOUCHSCREEN := true

BOARD_KERNEL_CMDLINE := console=ttyS0,115200 rw init=/init loglevel=8
BOARD_KERNEL_BASE := 0x40000000
BOARD_KERNEL_PAGESIZE := 2048

# fix this up by examining /proc/partitions on a running device
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432
BOARD_SYSTEMIMAGE_PARTITION_SITE := 536870912
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1073741824
BOARD_FLASH_BLOCK_SIZE := 4096

# TARGET_PREBUILT_KERNEL := device/smallart/uhost1/prebuilt/kernel

TARGET_USERIMAGES_USE_EXT4 := true

TARGET_RECOVERY_PRE_COMMAND := "echo -n boot-recovery | busybox dd of=/dev/block/nandf count=1 conv=sync; sync;"

#BOARD_HAS_NO_SELECT_BUTTON := true
# Use this flag if the board has a ext4 partition larger than 2gb
#BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_CUSTOM_RECOVERY_KEYMAPPING := ../../device/smallart/uhost1/recovery/recovery_keys.c
BOARD_CUSTOM_GRAPHICS := ../../../device/smallart/uhost1/recovery/graphics.c

TARGET_KERNEL_SOURCE := kernel/allwinner/common
TARGET_KERNEL_CONFIG := sun4i_crane_defconfig
