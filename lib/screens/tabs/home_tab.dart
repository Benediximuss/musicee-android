// home_tab.dart
import 'package:flutter/material.dart';
import 'package:musicee_app/screens/tabs/widgets/row_element.dart';
import 'package:musicee_app/theme.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBG,
      body: Padding(
        padding: const EdgeInsets.only(left: 0.0, right: 0.0),
        child: ListView(
          children: [
            RowElement(title: 'Recommendations 1'),
            RowElement(title: 'Recommendations 2'),
            RowElement(title: 'Recommendations 3'),
            RowElement(title: 'Recommendations 4'),
            RowElement(title: 'Recommendations 5'),
          ],
        ),
      ),
    );
  }
}
