import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../controllers/get_controller.dart';

class QRViewExample extends StatelessWidget {
  QRViewExample({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Kodni Skaynerlash', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.045, fontWeight: FontWeight.w500)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:Theme.of(context).colorScheme.onSurface, size: Get.width * 0.05),
          onPressed: () => Get.back()
        ),
        actions: [
          Obx(() => IconButton(
              icon: Icon(
                _getController.cameraFacing.value == CameraFacing.front ? Icons.camera_rear : Icons.camera_front,
                color: Colors.white,
                size: Get.width * 0.05
              ),
              onPressed: _getController.toggleCamera
            )),
          Obx(() => IconButton(
              icon: Icon(
                _getController.isLampOn.value ? Icons.flashlight_off : Icons.flashlight_on,
                color: Colors.white,
                size: Get.width * 0.05
              ),
              onPressed: _getController.toggleLamp
            )
          )
        ]
      ),
      body: Obx(() => Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: QRView(
                    overlay: QrScannerOverlayShape(
                        borderColor: Colors.white,
                        borderRadius: 10,
                        borderLength: 30,
                        borderWidth: 10,
                        cutOutSize: MediaQuery.of(context).size.width * 0.8
                    ),
                    key: _getController.qrKey,
                    cameraFacing: _getController.cameraFacing.value,
                    onQRViewCreated: _getController.onQRViewCreated
                  )
                )
              ]
            )
          ]
        )
      )
    );
  }
}