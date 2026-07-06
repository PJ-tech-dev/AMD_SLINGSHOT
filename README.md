# WM811K Wafer Defect Training + FPGA Deployment Guide

## What we completed

This project was implemented to train a small CNN for WM811K wafer defect classification and prepare outputs for FPGA deployment on **Zybo Z7 (Zynq-7020)**.

### Target constraints
- FPGA target: `xc7z020clg400-1`
- Resource-aware architecture (2 Conv layers)
- Small model for HLS compatibility
- INT8-ready export path

## Dataset and split

- Dataset folder used: `WM811k_Dataset/`
- Classes (9): `Center, Donut, Edge Local, Edge Ring, Local, near full, none, random, Scratch`
- Split used: **70% train / 15% validation / 15% test** (stratified)

## Training pipeline implemented

The script used is:
- `New folder/fgpatrain.py`

Pipeline steps:
1. Load images from class folders
2. Resize and normalize
3. Train/val/test split (stratified)
4. Compute class weights for imbalance
5. Train compact CNN with early stopping + LR scheduling
6. Save model artifacts
7. Optional INT8 TFLite export
8. Optional hls4ml conversion for FPGA flow

## Model architectures tested

During tuning, multiple configurations were evaluated (grayscale/rgb, augmentation on/off, small width changes).

Best observed run in this environment:
- Train accuracy: ~90.17%
- Validation accuracy: ~81.48%
- Test accuracy: ~71.32%

> Note: 90% on both validation and test was not reached in current experiments with this small dataset and strict 2-conv lightweight constraints.

## Files generated and what they mean

1. `wafer_qat_model.h5`
- Final saved training model from last run.
- Used for experimentation / retraining continuation.

2. `wafer_qat_best.h5`
- Best checkpoint on validation metric during training.
- Usually best candidate for evaluation/inference among training checkpoints.

3. `wafer_fpga_deploy_model.h5`
- Deployment-oriented Keras model intended as the source for conversion to FPGA flow (`hls4ml` -> Vitis HLS/Vivado).
- **Primary model to use for FPGA conversion pipeline.**

4. `wafer_int8_model.tflite`
- INT8 TensorFlow Lite model.
- Best for CPU/edge runtimes using TFLite interpreter (e.g., ARM software path).
- Not the direct artifact for Vitis HLS IP generation.

## Which file should be used for hardware?

### If your hardware path is **PL acceleration via hls4ml + Vitis HLS + Vivado**
Use:
- **`wafer_fpga_deploy_model.h5`** (recommended)

Then convert this model with hls4ml to generate C++/HLS project and export IP.

### If your hardware path is **PS-side software inference (ARM on Zynq) using TFLite runtime**
Use:
- **`wafer_int8_model.tflite`**

## Practical recommendation

For your stated Zybo Z7 FPGA workflow (hls4ml + Vitis HLS):
- Use **`wafer_fpga_deploy_model.h5`** as the conversion input.
- Keep `wafer_qat_best.h5` as backup candidate if you want to compare conversion quality/accuracy.
- Use `wafer_int8_model.tflite` only for ARM-side TFLite inference, not for HLS IP generation.

## Command examples used

### Full training
```powershell
& "D:/AMD Hackathon/.venv/Scripts/python.exe" "d:/AMD Hackathon/New folder/fgpatrain.py" --epochs 120 --batch-size 32 --backend plain --img-size 32 --color-mode rgb --conv1-filters 8 --conv2-filters 16 --dense-units 32 --dropout 0.1
```

### With INT8 TFLite export
```powershell
& "D:/AMD Hackathon/.venv/Scripts/python.exe" "d:/AMD Hackathon/New folder/fgpatrain.py" --epochs 120 --batch-size 32 --backend plain --img-size 32 --color-mode rgb --conv1-filters 8 --conv2-filters 16 --dense-units 32 --dropout 0.1 --export-tflite-int8
```

## Next step for FPGA deployment

1. Convert `wafer_fpga_deploy_model.h5` with hls4ml using part `xc7z020clg400-1`
2. Run C simulation + synthesis in Vitis HLS
3. Export IP
4. Integrate IP in Vivado block design with Zynq PS
5. Build bitstream and run end-to-end inference test
