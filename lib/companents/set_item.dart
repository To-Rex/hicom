import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicom/controllers/get_controller.dart';
import '../resource/colors.dart';

class SettingsItem extends StatelessWidget {

  final Icon icon;
  final String title;
  final  Function onTap;
  final Color color;
  final bool isNightMode;
  final bool isLanguage;

  const SettingsItem({super.key, required this.icon, required this.title, required this.onTap, required this.color, required this.isNightMode, required this.isLanguage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(AppColors.blackTransparent),
      child: Row(
        children: [
          icon,
          SizedBox(width: Get.width * 0.03),
          Text(title, style: TextStyle(color: color, fontSize: Get.width * 0.04, fontWeight: FontWeight.w500)),
          const Spacer(),
          if (isLanguage)
            Text(GetController().language.toString() == 'uz_UZ' ? 'O‘zbekcha' : GetController().language.toString() == 'oz_OZ' ? 'Узбекча' : GetController().language.toString() == 'ru_RU' ? 'Русский' : 'English', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontSize: Get.width * 0.035, fontWeight: FontWeight.w500)),
          if (!isNightMode)
            IconButton(onPressed: () => onTap(), icon: Icon(Icons.chevron_right, size: Get.height * 0.035, color: color))
          else
            CupertinoSwitch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                AdaptiveTheme.of(context).brightness == Brightness.light ? AdaptiveTheme.of(context).setDark() : AdaptiveTheme.of(context).setLight();
              },
              activeColor: AppColors.green,
              trackColor: AppColors.grey.withOpacity(0.5),
              focusColor: AppColors.green,
              thumbColor: Theme.of(context).colorScheme.surface,
              applyTheme: true
            )
        ]
      ),
      onTap: () => onTap()
    );
  }
}