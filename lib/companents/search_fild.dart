import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';

class SearchFields extends StatelessWidget {
  final Function(String) onChanged;
  SearchFields({super.key, required this.onChanged});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
        margin: EdgeInsets.only(
            left: Get.width * 0.15,
            top: Get.height * 0.01,
            right: Get.width * 0.03
        ),
        height: Get.height * 0.05,
        //width: Get.width * 0.7,
        padding: EdgeInsets.only(right: Get.width * 0.01),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1), borderRadius: BorderRadius.circular(13)),
        child: TextField(
            controller: _getController.searchController,
            onChanged: onChanged,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
                hintText: 'Qidirish'.tr,
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontSize: Get.width * 0.04),
                prefixIcon: Padding(padding: EdgeInsets.all(Get.height * 0.013), child: Icon(Icons.search, color: Theme.of(context).colorScheme.onSurface)),
                border: InputBorder.none
            )
        )
    ));
  }
}