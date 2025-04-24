import 'package:flutter/material.dart';
import 'package:stickify/core/core.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              Text(
                'Sticker Generator',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    title: "Upload",
                    type: ButtonType.secondary,
                    width: 45,
                    icon: Icon(Icons.arrow_circle_up_rounded, size: 25),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.zero,
                      bottomRight: Radius.zero,
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    onClick: () {
                      print('Upload');
                    },
                  ),
                  AppButton(
                    title: "Generate",
                    type: ButtonType.secondary,
                    width: 45,
                    icon: Icon(Icons.star, size: 25),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      bottomLeft: Radius.zero,
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    onClick: () {
                      print('Generate');
                    },
                  ),
                ],
              ),
              Text(
                'Preview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                width: context.vw(70),
                height: context.vw(70),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(50),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Image.asset("assets/images/9.jpg"),
              ),
              AppButton(
                title: "Edit",
                type: ButtonType.secondary,
                onClick: () {
                  print('Edit button');
                },
              ),
              AppButton(
                title: "Upload to Telegram",
                type: ButtonType.primary,
                onClick: () {
                  print('Upload button');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.type,
    required this.onClick,
    this.icon,
    this.width = 100,
    this.borderRadius,
  });

  final String title;
  final ButtonType type;
  final Function() onClick;
  final Icon? icon;
  final double width;

  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.vw(width),
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            type.isPrimary() ? Colors.blue : Colors.white,
          ),
          foregroundColor: WidgetStatePropertyAll(Colors.blue),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12),
              side: BorderSide(color: Colors.blue, width: 1),
            ),
          ),
        ),
        onPressed: onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? SizedBox.shrink(),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: type.isPrimary() ? Colors.white : Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ButtonType {
  primary,
  secondary;

  bool isPrimary() {
    return this == ButtonType.primary;
  }
}
