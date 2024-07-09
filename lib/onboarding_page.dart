import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicom/pages/auth/login_page.dart';
import 'package:hicom/pages/auth/register_page.dart';
import 'package:hicom/resource/colors.dart';
import 'controllers/get_controller.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});

  final GetController _getController = Get.put(GetController());
  late final AnimationController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              child: Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.black70.withOpacity(0.1),
                      AppColors.black70
                    ]
                  )
                )
              )
          ),
          Positioned(
              bottom: _getController.height.value * 0.297,
              right: Get.width * 0.1,
              left: Get.width * 0.1,
              child: Center(
                child: Text('Sizni yuzlab jozibador hikoyalar kutmoqda'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: _getController.width.value * 0.07,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    )
                ),
              )
          ),
          Positioned(
            bottom: Get.height * 0.255,
            right: Get.width * 0.1,
            left: Get.width * 0.1,
            child: Text('Sevimli janrlaringizni o‘rganing'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: _getController.width.value * 0.045,
                  color: AppColors.white.withOpacity(0.7),
                )
            ),
          ),
          Positioned(
            bottom: Get.height * 0.22,
            right: Get.width * 0.3,
            left: Get.width * 0.3,
            child: Row(
              children: [
                const Spacer(),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(width: _getController.width.value * 0.01),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          //button
          Positioned(
              bottom: 80.h,
              width: Get.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: SizedBox(
                  height: 50.h,
                  width: Get.width,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => RegisterPage());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )
                      ),
                      child: Text('Ro‘yxatdan o‘tish'.tr,
                          style: TextStyle(
                            fontSize: _getController.width.value * 0.04,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          )
                      )
                  )
                )
              )
          ),
          Positioned(
              bottom: 20.h,
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Ro‘yxatdan o‘tganmisiz?'.tr,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.white,
                      )
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => LoginPage());
                    },
                    child: Text('Kirish'.tr,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}