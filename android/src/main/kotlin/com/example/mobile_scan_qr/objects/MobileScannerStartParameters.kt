package com.example.mobile_scan_qr.objects

class MobileScannerStartParameters(
    val width: Double = 0.0,
    val height: Double,
    val hasFlashUnit: Boolean,
    val id: Long,
    val numberOfCameras: Int
)