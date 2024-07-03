import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hicom/companents/instrument/instrument_components.dart';
import 'package:hicom/controllers/api_controller.dart';
import 'package:hicom/pages/sample/add_project_page.dart';
import 'package:hicom/pages/sample/switch_lists.dart';
import 'package:hicom/pages/user_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/search_fild.dart';
import '../../controllers/get_controller.dart';

class SamplePage extends StatelessWidget {
  SamplePage({super.key});

  final GetController _getController = Get.put(GetController());
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  void _onLoading() {
    refreshController.loadComplete();
  }

  void _getData() {
    refreshController.refreshCompleted();
    ApiController().getProjects();
  }

  @override
  Widget build(BuildContext context) {
    ApiController().login(_getController.getNumber(),_getController.getSession(),'50UvFayZ2w5u3O9B',false).then((_) => {
      refreshController.requestRefresh(),
      _getData()
    });
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Obx(() => Text(_getController.isSearch.value ? ''.tr : 'Loyihalar ro\'yxati'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.05))),
            leading: Obx(() => IconButton(icon: Icon(_getController.isSearch.value ? Icons.arrow_back : Icons.account_circle_outlined, size: Get.height * 0.035), onPressed: () => {if (_getController.isSearch.value){_getController.isSearch.value = !_getController.isSearch.value} else {Get.to(UserPage(), transition: Transition.fadeIn)}})),
            centerTitle: true,
            actions: [
              Obx(() => _getController.isSearch.value
                  ? SearchFields(onChanged: (String value) {})
                  : IconButton(icon: Icon(Icons.search, size: Get.height * 0.035), onPressed: () => {_getController.isSearch.value = !_getController.isSearch.value})
              )
            ]),
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            physics: const BouncingScrollPhysics(),
            header: CustomHeader(builder: (BuildContext context, RefreshStatus? mode) {return SizedBox(height: Get.height * 0.1);}),
            footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {return SizedBox(height: Get.height * 0.1);}),
            onLoading: _onLoading,
            onRefresh: _getData,
            controller: refreshController,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Obx(() => _getController.projectModel.value.admin != null || _getController.projectModel.value.join != null
                    ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_getController.projectModel.value.admin!.isNotEmpty)
                        for(var i = 0; i < _getController.projectModel.value.admin!.length; i++)
                          InkWell(
                              onTap: () => {
                                ApiController().getSwitchList(_getController.projectModel.value.admin![i].pid),
                                Get.to(SwitchList(name: _getController.projectModel.value.admin![i].name.toString()), arguments: _getController.projectModel.value.admin![i].pid)
                              },
                              child: Container(
                                  margin: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * 0.02),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Theme.of(context).colorScheme.surface),
                                  child: Center(
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
                                                  Text(_getController.projectModel.value.admin![i].name.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.05)),
                                                  Text(_getController.projectModel.value.admin![i].note.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                  Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text('${'Jami'.tr} ${_getController.projectModel.value.admin![i].sc.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                        Container(
                                                            width: 2,
                                                            height: Get.height * 0.025,
                                                            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.01),
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                                        ),
                                                        Text('${'Yoniq'.tr} ${_getController.projectModel.value.admin![i].lsc.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                        Container(
                                                            width: 2,
                                                            height: Get.height * 0.025,
                                                            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.01),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(3),
                                                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                                                            )
                                                        ),
                                                        Text('${'Xato'.tr} ${_getController.projectModel.value.admin![i].wsc.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                      ]
                                                  )
                                                ]
                                            ),
                                            PopupMenuButton<String>(
                                                icon: Icon(Icons.menu, size: Get.width * 0.05),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                                color: Theme.of(context).colorScheme.surface,
                                                surfaceTintColor: Colors.transparent,
                                                elevation: 4,
                                                onSelected: (String value) {
                                                  switch (value) {
                                                    case 'edit':
                                                      _getController.nameProjectController.text = _getController.projectModel.value.admin![i].name.toString();
                                                      _getController.noteProjectController.text = _getController.projectModel.value.admin![i].note.toString();
                                                      InstrumentComponents().bottomSheetEditName(context,_getController.projectModel.value.admin![i].pid);
                                                      break;
                                                    case 'watchers':
                                                      InstrumentComponents().bottomSheetUsers(context, _getController.projectModel.value.admin![i].pid);
                                                      ApiController().getProjectsUsers(_getController.projectModel.value.admin![i].pid);
                                                      break;
                                                    case 'share':
                                                      InstrumentComponents().bottomSheetShare(context, _getController.projectModel.value.admin![i].pid);
                                                      break;
                                                    case 'delete':
                                                      InstrumentComponents().deleteProject(context, _getController.projectModel.value.admin![i].pid);
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
                                                    //line
                                                    //const Divider(),
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
                                                            Text('O\'chirish'.tr, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: Get.width * 0.04))
                                                          ],
                                                        )
                                                    )
                                                  ];
                                                }
                                            )
                                          ]
                                      )
                                  )
                              )
                          ),
                      if (_getController.projectModel.value.join!.isNotEmpty)
                        for(var i = 0; i < _getController.projectModel.value.join!.length; i++)
                          InkWell(
                              onTap: () => {
                                ApiController().getSwitchList(_getController.projectModel.value.join![i].pid),
                                Get.to(SwitchList(name: _getController.projectModel.value.join![i].name.toString()), arguments: _getController.projectModel.value.join![i].pid)
                              },
                              child: Container(
                                  margin: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * 0.02),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Theme.of(context).colorScheme.surface),
                                  child: Center(
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
                                                  Text(_getController.projectModel.value.join![i].name.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.05)),
                                                  Text(_getController.projectModel.value.join![i].note.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                  Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text('${'Jami'.tr} ${_getController.projectModel.value.join![i].sc.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                        Container(
                                                            width: 2,
                                                            height: Get.height * 0.025,
                                                            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.01),
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                                        ),
                                                        Text('${'Yoniq'.tr} ${_getController.projectModel.value.join![i].lsc.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                        Container(
                                                            width: 2,
                                                            height: Get.height * 0.025,
                                                            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.01),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(3),
                                                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                                                            )
                                                        ),
                                                        Text('${'Xato'.tr} ${_getController.projectModel.value.join![i].wsc.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                      ]
                                                  )
                                                ]
                                            ),
                                            PopupMenuButton<String>(
                                                icon: Icon(Icons.menu, size: Get.width * 0.05),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                                color: Theme.of(context).colorScheme.surface,
                                                surfaceTintColor: Colors.transparent,
                                                elevation: 4,
                                                onSelected: (String value) {
                                                  switch (value) {
                                                    case 'edit':
                                                      _getController.nameProjectController.text = _getController.projectModel.value.join![i].name.toString();
                                                      _getController.noteProjectController.text = _getController.projectModel.value.join![i].note.toString();
                                                      InstrumentComponents().bottomSheetEditName(context,_getController.projectModel.value.join![i].pid);
                                                      break;
                                                    case 'watchers':
                                                      InstrumentComponents().bottomSheetUsers(context, _getController.projectModel.value.join![i].pid);
                                                      ApiController().getProjectsUsers(_getController.projectModel.value.join![i].pid);
                                                      break;
                                                    case 'share':
                                                      InstrumentComponents().bottomSheetShare(context, _getController.projectModel.value.join![i].pid);
                                                      break;
                                                    case 'delete':
                                                      InstrumentComponents().deleteProject(context, _getController.projectModel.value.join![i].pid);
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
                                                    //line
                                                    //const Divider(),
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
                                                            Text('O\'chirish'.tr, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: Get.width * 0.04))
                                                          ],
                                                        )
                                                    )
                                                  ];
                                                }
                                            )
                                          ]
                                      )
                                  )
                              )
                          ),
                    ])
                    : Column(children: [
                      SizedBox(
                          height: Get.height* 0.9,
                          width: Get.width,
                          child: Center(child: Text('Loyihalar ro\'yxati'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.05)))
                      )
                    ])
                )
            )
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.blue,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            //debugPrint(Tea.decryptTea('2n24x4rCjXpfnwgCrVP7FrJXSgrdxKI4z2Lx8vEdDR4qeN8Q7JzuNviHB/oSkAbxlXKuEcY+bBfe9XL5r6+5RGv5iwLuiP72RQl6KDDpaOGbvxXxh+Gr8lhfZ4GoiH/u32dFwwOuU8XOPmqJWkjlBoVNFvnc5npHDVuu7gMbB1r6JYV/xAhEgalm2GzvxM65tCEiHf3d', _getController.getKey()).toString());
            /*_getController.addAllData(
                '+998916848100',
                'ivEWz4iyP2UZ348HRyF3JKNMuppBSGCNL3a2fnRJolJIpjQUEOlJH208aXBdQtfQ',
                'a2tB333raC8y74dt',
                '2025b25f25ce9ad98d6047ff0dc105b5'
            );*/

            Get.to(AddProjectPage());
            //Get.to(QRViewExample());
            //debugPrint(Tea.decryptTea('3yZ7oI51a6NU/CeZ3afmDWOfrEsHfudjby20hOBkhsLfMB695GrzyYGyd14tqnSt9qQ4nJcoL4irK5L3PjD+dWj7Jo2cOkFmb+A+JUoRpZW/Oyv8rcFAxxtYn4NNBe3y53Yv0guyPbh9h6qElKF6tcSrRRHgIo/AW2ZGfg8h+yi8D/lZp8kosEbfLKSxzaSE+AxXqHr5Xoc22IX67eu5t2MG4ToxrF1Zh1klbTRVaAE6217TBRLk/QtTuNxZRGw7ya+DlAW9IUZh5h8XrQWvOUbfLKSxzaSE+AxXqHr5XocJ4FPPJEENvqkilh1Wipi77vp/PP6xPrWP4Czn1UWcpCLQ0MtkRsUilhUzICWV8iwx4F8O7oqOs6MJTo0tX1Oz9oDydwewEeI+BErZ6zv2x8xNZOi1n4GsTvn0qEzRRCXWoKtxb7uH+I4wm3+RjDMmx1ju+nPf4NR0euP5lbuBk+aPVvV+V4l3rKBq+wbM26KhB0LO563vnKdcooZ7+f/ZoMtbltXhGT8iqgeEZbTUUO4zjdxmpaoWICN2XDpg098TO2fbjHXzON8wHr3kavPJSLJc501hONuzOcWCnsKgJaSD3Gt4UOriU/vrzdAJRJI=', '6VarcjE2oJ7tWX8z'));
            //InstrumentComponents().bottomCrackUser(context);
          },
          child: const Icon(Icons.add),
        ));
  }
}
