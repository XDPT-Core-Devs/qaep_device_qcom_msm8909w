ifneq (,$(filter $(QCOM_BOARD_PLATFORMS),$(TARGET_BOARD_PLATFORM)))
ifneq (,$(filter arm aarch64 arm64, $(TARGET_ARCH)))
ifneq ($(call is-board-platform,msm8994),true)
ifneq ($(call is-board-platform,msm8992),true)
LOCAL_PATH := $(call my-dir)
commonSources :=

include $(CLEAR_VARS)
LOCAL_SRC_FILES += msm_ion_test_module.c compat_msm_ion_test_module.c
LOCAL_MODULE      := msm_ion_test_mod.ko
LOCAL_MODULE_TAGS := debug
include $(DLKM_DIR)/AndroidKernelModule.mk

# the userspace test program
include $(CLEAR_VARS)
LOCAL_MODULE := msm_iontest
LOCAL_CFLAGS += -Werror
LOCAL_SRC_FILES += $(commonSources) msm_iontest.c kernel_ion_tests.c user_ion_tests.c cp_ion_tests.c
LOCAL_SRC_FILES += ion_test_utils.c
LOCAL_C_INCLUDES := $(BOARD_KERNEL_HEADER_DIR)
LOCAL_ADDITIONAL_DEPENDENCIES := $(BOARD_KERNEL_HEADER_DEPENDENCIES)
LOCAL_SHARED_LIBRARIES := \
        libc \
        libcutils \
        libutils
LOCAL_MODULE_TAGS := optional debug
LOCAL_MODULE_PATH := $(TARGET_OUT_DATA)/kernel-tests
include $(BUILD_EXECUTABLE)

# the test script
include $(CLEAR_VARS)
LOCAL_MODULE := iontest.sh
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_SRC_FILES := iontest.sh
LOCAL_MODULE_TAGS := optional debug
LOCAL_MODULE_PATH := $(TARGET_OUT_DATA)/kernel-tests
include $(BUILD_PREBUILT)

endif
endif
endif
endif
