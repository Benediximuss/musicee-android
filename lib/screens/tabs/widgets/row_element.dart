// row_element.dart
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:musicee_app/screens/tabs/widgets/song_card.dart';

class RowElement extends StatelessWidget {
  final String title;

  RowElement({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1A1A)),
          ),
        ),
        Container(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Change this as needed
            itemBuilder: (context, index) {
              return SongCard();
            },
          ),
        ),
      ],
    );
  }
}
