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
            left: _getController.width.value * 0.15,
            top: _getController.height.value * 0.01,
            right: _getController.width.value * 0.03
        ),
        height: _getController.height.value * 0.05,
        //width: _getController.width.value * 0.7,
        padding: EdgeInsets.only(right: _getController.width.value * 0.01),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1), borderRadius: BorderRadius.circular(13)),
        child: TextField(
            controller: _getController.searchController,
            onChanged: onChanged,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
                hintText: 'Qidirish'.tr,
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontSize: _getController.width.value * 0.04),
                prefixIcon: Padding(padding: EdgeInsets.all(_getController.height.value * 0.013), child: Icon(Icons.search, color: Theme.of(context).colorScheme.onSurface)),
                border: InputBorder.none
            )
        )
    ));
  }
}