import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:stickify/bloc/alert_cubit/alert_cubit.dart';

class AppAlert extends StatelessWidget {
  const AppAlert({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AlertCubit, AlertState>(
      listener: (context, state) {
        if (state is ShowError) {
          AlertController.show("ERROR", state.message, TypeAlert.success);
        } else {
          AlertController.hide();
        }
      },
      child: child,
    );
  }
}
