LOCAL_PATH := $(call my-dir)
local_target_dir := $(TARGET_OUT_DATA)/misc/wifi/phy

include $(CLEAR_VARS)
LOCAL_MODULE := set_cmd_silence.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

