import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:musicee_app/utils/color_manager.dart';

class CustomLoaderIndicator extends StatelessWidget {
  const CustomLoaderIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitPulsingGrid(
        color: ColorManager.swatchPrimary.shade400,
        size: 75.0,
      ),
    );
  }
}
