import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hicom/companents/instrument/instrument_components.dart';
import 'package:hicom/controllers/api_controller.dart';
import 'package:hicom/pages/sample/add_project_page.dart';
import 'package:hicom/pages/sample/switch_lists.dart';
import 'package:hicom/pages/user_page.dart';
import 'package:hicom/resource/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/search_fild.dart';
import '../../controllers/get_controller.dart';

class SamplePage extends StatelessWidget {
  SamplePage({super.key});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _getData() {
    _refreshController.refreshCompleted();
    ApiController().getProjects();
  }

  @override
  Widget build(BuildContext context) {
    ApiController().login(_getController.getNumber(),_getController.getSession(),'50UvFayZ2w5u3O9B',false).then((_) => {
      _refreshController.requestRefresh(),
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      _getData();
    });
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Obx(() => Text(_getController.isSearch.value ? ''.tr : 'Loyihalar ro‘yxati'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.05))),
            leading: Obx(() => IconButton(icon: Icon(_getController.isSearch.value ? Icons.arrow_back : Icons.account_circle_outlined, size: Get.height * 0.035), onPressed: () => {if (_getController.isSearch.value){_getController.isSearch.value = !_getController.isSearch.value} else {Get.to(UserPage(), transition: Transition.fadeIn)}})),
            centerTitle: true,
            actions: [
              Obx(() => _getController.isSearch.value
                  ? SearchFields(onChanged: (String value) {_getController.searchProject(value);})
                  : IconButton(icon: Icon(Icons.search, size: Get.height * 0.035), onPressed: () => {_getController.isSearch.value = !_getController.isSearch.value})
              )
            ]),
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            physics: const BouncingScrollPhysics(),
            header: CustomHeader(builder: (BuildContext context, RefreshStatus? mode) {return SizedBox(height: Get.height * 0.1);}),
            footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {return SizedBox(height: Get.height * 0.1);}),
            onLoading: null,
            onRefresh: _getData,
            controller: _refreshController,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Obx(() => _getController.searchProjectModel.value.admin != null && _getController.searchProjectModel.value.join!.isNotEmpty &&  _getController.searchProjectModel.value.join!.length > 0 || _getController.searchProjectModel.value.join != null && _getController.searchProjectModel.value.admin!.isNotEmpty && _getController.searchProjectModel.value.admin!.length > 0
                    ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_getController.searchProjectModel.value.admin!.isNotEmpty)
                        for(var i = 0; i < _getController.searchProjectModel.value.admin!.length; i++)
                          InkWell(
                              overlayColor: WidgetStateProperty.all(Colors.transparent),
                              onTap: () => {
                                ApiController().getSwitchList(_getController.searchProjectModel.value.admin![i].pid),
                                Get.to(SwitchList(name: _getController.searchProjectModel.value.admin![i].name.toString(), isAdmin: true), arguments: _getController.searchProjectModel.value.admin![i].pid)
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
                                  elevation: 1,
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                                            child: Stack(
                                                children: [
                                                  SvgPicture.asset('assets/svg_assets/folde.svg', width: Get.width * 0.06, height: Get.height * 0.06),
                                                  Positioned(
                                                    top: Get.height * 0.026,
                                                    left: Get.width * 0.056,
                                                    child: SvgPicture.asset('assets/svg_assets/user.svg', width: Get.width * 0.03, height: Get.height * 0.03),
                                                  )
                                                ]
                                            )
                                        ),
                                        Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: Get.height * 0.01),
                                              SizedBox(
                                                width: Get.width * 0.6,
                                                child: Text(_getController.searchProjectModel.value.admin![i].name.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.05)),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.6,
                                                child: Text(_getController.searchProjectModel.value.admin![i].note.toString() == ''|| _getController.searchProjectModel.value.admin![i].note.toString() == ' ' ? 'Qo‘shimcha ma’lumotlar yo‘q'.tr : _getController.searchProjectModel.value.admin![i].note.toString(),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04))
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text('${'Jami'.tr} ${_getController.searchProjectModel.value.admin![i].sc.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                    Container(
                                                        width: 2,
                                                        height: Get.height * 0.025,
                                                        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.01),
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                                    ),
                                                    Text('${'Yoniq'.tr} ${_getController.searchProjectModel.value.admin![i].lsc.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                    Container(
                                                        width: 2,
                                                        height: Get.height * 0.025,
                                                        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.01),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(3),
                                                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                                                        )
                                                    ),
                                                    Text('${'Xato'.tr} ${_getController.searchProjectModel.value.admin![i].wsc.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                  ]
                                              )
                                            ]
                                        ),
                                        Expanded(child: Container()),
                                        PopupMenuButton<String>(
                                            icon: Icon(Icons.menu, size: Get.width * 0.05),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                            color: Theme.of(context).colorScheme.surface,
                                            surfaceTintColor: Colors.transparent,
                                            elevation: 4,
                                            onSelected: (String value) {
                                              switch (value) {
                                                case 'edit':
                                                  _getController.nameProjectController.text = _getController.searchProjectModel.value.admin![i].name.toString();
                                                  _getController.noteProjectController.text = _getController.searchProjectModel.value.admin![i].note.toString();
                                                  InstrumentComponents().bottomSheetEditName(context,_getController.searchProjectModel.value.admin![i].pid);
                                                  break;
                                                case 'watchers':
                                                  InstrumentComponents().bottomSheetUsers(context, _getController.searchProjectModel.value.admin![i].pid);
                                                  ApiController().getProjectsUsers(_getController.searchProjectModel.value.admin![i].pid);
                                                  break;
                                                case 'share':
                                                  InstrumentComponents().bottomSheetShare(context, _getController.searchProjectModel.value.admin![i].pid);
                                                  break;
                                                case 'delete':
                                                  InstrumentComponents().deleteProject(context, _getController.searchProjectModel.value.admin![i].pid);
                                                  break;
                                              }
                                            },
                                            itemBuilder: (BuildContext context) {
                                              return [
                                                PopupMenuItem(
                                                    value: 'edit',
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.edit, size: Get.width * 0.04),
                                                        SizedBox(width: Get.width * 0.015),
                                                        Text('Tahrirlash'.tr)
                                                      ],
                                                    )
                                                ),
                                                PopupMenuItem(
                                                    value: 'watchers',
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.person, size: Get.width * 0.04),
                                                        SizedBox(width: Get.width * 0.015),
                                                        Text('Kuzatuvchilar'.tr)
                                                      ],
                                                    )
                                                ),
                                                PopupMenuItem(
                                                    value: 'share',
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.share, size: Get.width * 0.04),
                                                        SizedBox(width: Get.width * 0.015),
                                                        Text('Ulashish'.tr)
                                                      ],
                                                    )
                                                ),
                                                const PopupMenuItem(
                                                  height: 0,
                                                  padding: EdgeInsets.all(0),
                                                  value: 'watcher',
                                                  child: Divider(),
                                                ),
                                                PopupMenuItem(
                                                    value: 'delete',
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.delete, size: Get.width * 0.04, color: Theme.of(context).colorScheme.error),
                                                        SizedBox(width: Get.width * 0.015),
                                                        Text('O‘chirish'.tr, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: Get.width * 0.04))
                                                      ],
                                                    )
                                                )
                                              ];
                                            }
                                        )
                                      ]
                                  )
                              )
                          ),
                      if (_getController.searchProjectModel.value.join != null && _getController.searchProjectModel.value.join!.isNotEmpty)
                        for(var i = 0; i < _getController.searchProjectModel.value.join!.length; i++)
                          InkWell(
                              overlayColor: WidgetStateProperty.all(Colors.transparent),
                              onTap: () => {
                                ApiController().getSwitchList(_getController.searchProjectModel.value.join![i].pid),
                                Get.to(SwitchList(name: _getController.searchProjectModel.value.join![i].name.toString(), isAdmin: false), arguments: _getController.searchProjectModel.value.join![i].pid)
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: Get.height * 0.01),
                                elevation: 1,
                                child: Center(
                                    child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                                              child: SvgPicture.asset('assets/svg_assets/folde.svg', width: Get.width * 0.06, height: Get.height * 0.06)
                                          ),
                                          Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: Get.height * 0.01),
                                                SizedBox(width: Get.width * 0.6, child: Text(_getController.searchProjectModel.value.join![i].name.toString(), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.05)),),
                                                SizedBox(width: Get.width * 0.6, child: Text(_getController.searchProjectModel.value.join![i].note.toString() == '' ? 'Qo‘shimcha ma’lumotlar yo‘q'.tr : _getController.searchProjectModel.value.join![i].note.toString(), overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),),
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text('${'Jami'.tr} ${_getController.searchProjectModel.value.join![i].sc.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                      Container(
                                                          width: 2,
                                                          height: Get.height * 0.025,
                                                          margin: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.01),
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                                      ),
                                                      Text('${'Yoniq'.tr} ${_getController.searchProjectModel.value.join![i].lsc.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                      Container(
                                                          width: 2,
                                                          height: Get.height * 0.025,
                                                          margin: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.01),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(3),
                                                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                                                          )
                                                      ),
                                                      Text('${'Xato'.tr} ${_getController.searchProjectModel.value.join![i].wsc.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04))
                                                    ]
                                                )
                                              ]
                                          )
                                        ]
                                    )
                                )
                              )
                          )
                    ])
                    : Column(children: [SizedBox(
                          height: Get.height* 0.9,
                          width: Get.width,
                          child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/svg_assets/empty.svg', width: Get.width * 0.18, height: Get.height * 0.18),
                                  SizedBox(height: Get.height * 0.01),
                                  Text('Faol loyihalar yo‘q'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize)),
                                  SizedBox(height: Get.height * 0.01),
                                  Padding(padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05), child: Text('Loyiha qo‘shish uchun pastki o‘ng burchakdagi qo‘shish tugmasini bosing.'.tr, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize)))
                                ]
                              )
                          )
                      )])
                )
            )
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.blue,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            Get.to(AddProjectPage());
          },
          child: Icon(Icons.add,color: AppColors.white,size: Get.width * 0.06),
        )
    );
  }
}
