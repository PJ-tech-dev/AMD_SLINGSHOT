// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xwafer_video.h"

extern XWafer_video_Config XWafer_video_ConfigTable[];

XWafer_video_Config *XWafer_video_LookupConfig(u16 DeviceId) {
	XWafer_video_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XWAFER_VIDEO_NUM_INSTANCES; Index++) {
		if (XWafer_video_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XWafer_video_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XWafer_video_Initialize(XWafer_video *InstancePtr, u16 DeviceId) {
	XWafer_video_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XWafer_video_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XWafer_video_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

