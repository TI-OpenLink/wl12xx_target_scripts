LOCAL_PATH := $(call my-dir)
local_target_dir := $(TARGET_OUT_DATA)/misc/wifi

include $(CLEAR_VARS)
LOCAL_MODULE := load_wl12xx.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := load_wlcore_com8_siso40.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := load_wlcore_com8_mimo.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := load_wlcore_dvp_siso40.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := load_wlcore_dvp_mimo.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := load_wlcore_evb_siso40.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := load_wlcore_evb_mimo.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := load_wlcore_fpga_siso40.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := load_wlcore_fpga_mimo.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := load_wlcore_hdk_rld1_rdl5_mimo.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := load_wlcore_hdk_rld1_rdl5_siso40.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := load_wlcore_hdk_rld2_rdl7_mimo.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := load_wlcore_hdk_rld2_rdl7_siso40.sh
LOCAL_MODULE_TAGS := debug
LOCAL_MODULE_CLASS := SCRIPT
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)


