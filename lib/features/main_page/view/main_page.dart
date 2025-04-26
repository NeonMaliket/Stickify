import 'package:flutter/material.dart';
import 'package:stickify/components/components.dart';
import 'package:stickify/core/core.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        height: context.vh(100),
        width: context.vw(100),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: context.vh(5),
          horizontal: context.vw(5),
        ),
        child: SingleChildScrollView(
          child: Column(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Header(),
              SizedBox.fromSize(size: Size.fromHeight(50)),
              Body(),
              SizedBox.fromSize(size: Size.fromHeight(50)),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
