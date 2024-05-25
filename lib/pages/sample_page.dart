import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hicom/controllers/api_controller.dart';
import 'package:hicom/controllers/tea.dart';
import 'package:hicom/pages/user_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../companents/search_fild.dart';
import '../controllers/get_controller.dart';

class SamplePage extends StatelessWidget {
  SamplePage({super.key});

  final GetController _getController = Get.put(GetController());
  void _onLoading() => _getController.refreshController.loadComplete();
  void _getData() => _getController.refreshController.refreshCompleted();
  
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
                ? SearchFields(onChanged: (String value) {})
                : IconButton(icon: Icon(Icons.search,
                size: _getController.height.value * 0.035),
                onPressed: () => {
                  _getController.isSearch.value = !_getController.isSearch.value
                })
            )
          ]
        ),
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            physics: const BouncingScrollPhysics(),
            header: CustomHeader(builder: (BuildContext context, RefreshStatus? mode) {return SizedBox(height: _getController.height.value * 0.1);}),
            footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {return SizedBox(height: _getController.height.value * 0.1);}),
            onLoading: _onLoading,
            onRefresh: _getData,
            controller: _getController.refreshController,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    children: [
                      SizedBox(
                        height: _getController.height.value * 0.9,
                        width: double.infinity,
                        child: Center(
                            child: Text(
                              'Loyihalar ro\'yxati'.tr,
                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.05),
                            )
                        )
                      )
                    ]
                )
            )
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
