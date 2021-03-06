# Mesa
PRODUCT_PACKAGES += \
    libGLES_mesa \
    libGLES_android

PRODUCT_PACKAGES += \
    libdrm \
    libdrm_intel \
    libsync

PRODUCT_COPY_FILES += \
    device/intel/android_ia/common/graphics/drirc:system/etc/drirc

# Memtrack HAL
PRODUCT_PACKAGES += \
    memtrack.android_ia

{{#drmhwc}}
# DRM HWComposer
PRODUCT_PACKAGES += \
    hwcomposer.drm

PRODUCT_PROPERTY_OVERRIDES += \
   hwc.drm.use_overlay_planes=1 \
   ro.hardware.hwcomposer=drm
{{/drmhwc}}

{{^drmhwc}}
# HWComposer IA
PRODUCT_PACKAGES += \
    hwcomposer.android_ia

PRODUCT_PROPERTY_OVERRIDES += \
   hwc.drm.use_overlay_planes=1 \
   ro.hardware.hwcomposer=android_ia
{{/drmhwc}}

{{#minigbm}}
# Mini gbm
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gralloc=android_ia

PRODUCT_PACKAGES += \
    gralloc.android_ia
{{/minigbm}}

{{^minigbm}}
#Gralloc
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gralloc=drm

PRODUCT_PACKAGES += \
    gralloc.drm
{{/minigbm}}

{{^gen9+}}
# GLES version. We cannot enable Android
# 3.2 support for Gen9+ devices.
PRODUCT_PROPERTY_OVERRIDES += \
   ro.opengles.version=196609

{{#vulkan}}
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.level-0.xml:system/etc/permissions/android.hardware.vulkan.level.xml
{{/vulkan}}

{{/gen9+}}

{{#gen9+}}
# Mesa
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml

# GLES version
PRODUCT_PROPERTY_OVERRIDES += \
   ro.opengles.version=196609

{{#vulkan}}
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:system/etc/permissions/android.hardware.vulkan.level.xml
{{/vulkan}}

{{/gen9+}}

{{#vulkan}}
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_0_3.xml:system/etc/permissions/android.hardware.vulkan.version.xml

PRODUCT_PACKAGES += \
    vulkan.android_ia \
    libvulkan_intel

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.vulkan=android_ia
{{/vulkan}}
