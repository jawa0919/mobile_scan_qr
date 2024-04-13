package com.example.mobile_scan_qr

import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel

class BarcodeHandler(binaryMessenger: BinaryMessenger) : EventChannel.StreamHandler {

    private var eventSink: EventChannel.EventSink? = null

    private val eventChannel = EventChannel(
        binaryMessenger,
        "com.example.mobile_scan_qr/eventChannel"
    )

    init {
        eventChannel.setStreamHandler(this)
    }

    fun publishEvent(event: Map<String, Any>) {
        Handler(Looper.getMainLooper()).post {
            eventSink?.success(event)
        }
    }

    override fun onListen(event: Any?, eventSink: EventChannel.EventSink?) {
        this.eventSink = eventSink
    }

    override fun onCancel(event: Any?) {
        this.eventSink = null
    }
}