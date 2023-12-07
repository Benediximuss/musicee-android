import 'package:flutter/material.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/widgets/row_element.dart';

import '../../utils/color_manager.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 0.0, right: 0.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                       Navigator.pushNamed(context, Routes.allTracksScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.colorPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      "All Songs",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
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
            ],
          ),
        ),
      ),
    );
  }
}
