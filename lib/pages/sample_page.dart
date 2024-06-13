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
            title: Obx(() => Text(
                _getController.isSearch.value
                    ? ''.tr
                    : 'Loyihalar ro\'yxati'.tr,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: _getController.width.value * 0.05))),
            leading: Obx(() => IconButton(
                icon: Icon(
                    _getController.isSearch.value
                        ? Icons.arrow_back
                        : Icons.account_circle_outlined,
                    size: _getController.height.value * 0.035),
                onPressed: () => {
                      if (_getController.isSearch.value)
                        {
                          _getController.isSearch.value =
                              !_getController.isSearch.value
                        }
                      else
                        {Get.to(UserPage(), transition: Transition.fadeIn)}
                    })),
            centerTitle: true,
            actions: [
              Obx(() => _getController.isSearch.value
                  ? SearchFields(onChanged: (String value) {})
                  : IconButton(
                      icon: Icon(Icons.search,
                          size: _getController.height.value * 0.035),
                      onPressed: () => {
                            _getController.isSearch.value =
                                !_getController.isSearch.value
                          }))
            ]),
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            physics: const BouncingScrollPhysics(),
            header: CustomHeader(
                builder: (BuildContext context, RefreshStatus? mode) {
              return SizedBox(height: _getController.height.value * 0.1);
            }),
            footer:
                CustomFooter(builder: (BuildContext context, LoadStatus? mode) {
              return SizedBox(height: _getController.height.value * 0.1);
            }),
            onLoading: _onLoading,
            onRefresh: _getData,
            controller: _getController.refreshController,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Obx(() {
                  final hasProjects =
                      (_getController.projectModel.value.errCode != 0 && _getController.projectModel.value.admin != null && _getController.projectModel.value.admin!.isNotEmpty) || (_getController.projectModel.value.join != null && _getController.projectModel.value.join!.isNotEmpty);
                  return hasProjects ?
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.03, vertical: _getController.height.value * 0.01),
                          child: Text(
                              _getController.projectModel.value.admin!.isNotEmpty ? 'Admin'.tr : _getController.projectModel.value.join!.isNotEmpty ? 'User'.tr : ''.tr,
                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.05)),
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _getController.projectModel.value.admin!.isEmpty ? _getController.projectModel.value.join!.length : _getController.projectModel.value.admin!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.03, vertical: _getController.height.value * 0.01),
                                child: Text(_getController.projectModel.value.admin!.isEmpty ? _getController.projectModel.value.join![index].name.toString() : _getController.projectModel.value.admin![index].name.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.05))
                              );
                            })
                        ]) :
                  Column(children: [
                    SizedBox(
                        height: _getController.height.value * 0.9,
                        width: double.infinity,
                        child: Center(
                            child: Text('Loyihalar ro\'yxati'.tr,
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.05)
                            )
                        )
                    )
                  ]);
                }))),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.blue,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            ApiController().getProjects();
            debugPrint(Tea.decryptTea(
                'Fb+w8iPorjpi9LBAsUszpBhLr7U1qDXBN5hW1y3LKgF4J1kwyMDztlbeaqGblzVZv695xKIFtW0Q/VR6Mut7vc8eyd5QoyRhVcgHvLitdoaErID3YWRwvIXTdV0WMJ5ywzgFmY67bMFar3VQ0glXc4kF3N8OLsl6fx+M1Trwy5nQgUrZ3EZwZdmNdES7Jxfi4BcfMKdES7fLyWz+7RfEh5sdfQ==',
                'ut3Rs41pjvd6MkW6'));
            //debugPrint(Tea.decryptTea('1LLnNi7B1hRGlUdIoyx1bj1ID+/nFH12j+R1rMvLpclmfwjzA2uY754UUJEZL4HGxccmODDIAAP+CXygtZytXYXGyqThk3CfRriePR2yrY+uC8YAxKgTELcR/y7Ys1nQ8elPzKoyzMfd+WTzl1elo/Vd50/zMYRj6/x8GXlhniVELg7ORrKKc2wbJi3xpaiYy/xSJbu9h7bDOBogb26ik72dfQ==', 'fjA8etDf3lSArwzz'));
          },
          child: const Icon(Icons.add),
        ));
  }
}
