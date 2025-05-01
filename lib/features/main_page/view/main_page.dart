import 'package:flutter/material.dart';
import 'package:stickify/components/app_decorator/app_decorator.dart';
import 'package:stickify/components/components.dart';
import 'package:stickify/core/core.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDecorator(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/texture.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          height: context.vh(100),
          width: context.vw(100),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: context.vh(5),
            horizontal: context.vw(5),
          ),
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Header(),
              SizedBox.fromSize(size: Size.fromHeight(16)),
              Body(),
              SizedBox.fromSize(size: Size.fromHeight(10)),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
