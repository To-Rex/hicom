import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/get_controller.dart';

class InstructionPage extends StatelessWidget {
  InstructionPage({super.key});

  late final WebViewController _controller;
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://hicom.uz/doc/privacy_policy.html')) {
              return NavigationDecision.prevent;
            }else{
              return NavigationDecision.navigate;
            }
          }
        ),
      )
      ..loadRequest(Uri.parse('https://hicom.uz/doc/privacy_policy.html'));

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,surfaceTintColor: Colors.transparent,
          title: Text('Foydalanish yo‘riqnomasi'.tr),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back, size: Get.width * 0.06), onPressed: () => Get.back())
      ),
      body: SafeArea(
        child: Center(
          child: WebViewWidget(controller: _controller)
        )
      )
    );
  }
}