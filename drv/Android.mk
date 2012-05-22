LOCAL_PATH := $(call my-dir)
local_target_dir := $(TARGET_OUT_DATA)/misc/wifi

include $(CLEAR_VARS)
LOCAL_MODULE := load_wlcore.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := unload_wlcore.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := wlcore-print-fw-stat.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)
