import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorPage extends StatelessWidget{
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Error"),
          Text("Error"),
        ]
      )
    );
  }

}