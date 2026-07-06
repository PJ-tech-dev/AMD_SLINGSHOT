// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xwafer_video.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XWafer_video_CfgInitialize(XWafer_video *InstancePtr, XWafer_video_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XWafer_video_Start(XWafer_video *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XWafer_video_ReadReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_AP_CTRL) & 0x80;
    XWafer_video_WriteReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XWafer_video_IsDone(XWafer_video *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XWafer_video_ReadReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XWafer_video_IsIdle(XWafer_video *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XWafer_video_ReadReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XWafer_video_IsReady(XWafer_video *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XWafer_video_ReadReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XWafer_video_EnableAutoRestart(XWafer_video *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XWafer_video_WriteReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XWafer_video_DisableAutoRestart(XWafer_video *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XWafer_video_WriteReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_AP_CTRL, 0);
}

void XWafer_video_InterruptGlobalEnable(XWafer_video *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XWafer_video_WriteReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_GIE, 1);
}

void XWafer_video_InterruptGlobalDisable(XWafer_video *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XWafer_video_WriteReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_GIE, 0);
}

void XWafer_video_InterruptEnable(XWafer_video *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XWafer_video_ReadReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_IER);
    XWafer_video_WriteReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_IER, Register | Mask);
}

void XWafer_video_InterruptDisable(XWafer_video *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XWafer_video_ReadReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_IER);
    XWafer_video_WriteReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_IER, Register & (~Mask));
}

void XWafer_video_InterruptClear(XWafer_video *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XWafer_video_WriteReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_ISR, Mask);
}

u32 XWafer_video_InterruptGetEnabled(XWafer_video *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XWafer_video_ReadReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_IER);
}

u32 XWafer_video_InterruptGetStatus(XWafer_video *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XWafer_video_ReadReg(InstancePtr->Control_BaseAddress, XWAFER_VIDEO_CONTROL_ADDR_ISR);
}

