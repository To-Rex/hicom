import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicom/pages/user_page.dart';
import '../companents/search_fild.dart';
import '../controllers/get_controller.dart';

class SamplePage extends StatelessWidget {
  SamplePage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(_getController.isSearch.value ? ''.tr : 'Loyihalar ro\'yxati'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.05))),
          leading: Obx(() => IconButton(
            icon: Icon(_getController.isSearch.value ? Icons.arrow_back: Icons.account_circle_outlined, size: _getController.height.value * 0.035),
            onPressed: () => {
              if (_getController.isSearch.value) {
                _getController.isSearch.value = !_getController.isSearch.value
              }else {
                Get.to(UserPage(), transition: Transition.fadeIn)
              }
            })
          ),
          centerTitle: true,
          actions: [
            Obx(() => _getController.isSearch.value
                ? SearchFields(onChanged: (String) {})
                : IconButton(icon: Icon(Icons.search,
                size: _getController.height.value * 0.035),
                onPressed: () => {
                  _getController.isSearch.value = !_getController.isSearch.value
                })
            )
          ]
        ),

        body: const Center(
          child: Text('Sample Page'),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.blue,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }
}
