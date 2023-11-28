// song_detail_screen.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:musicee_app/theme.dart';

class SongDetailScreen extends StatelessWidget {
  final String title;
  final String artist;
  final String imagePath;

  const SongDetailScreen(
      {super.key, required this.title, required this.artist, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Song Details',
          style: TextStyle(
            fontSize: 20,
            color: AppColors.colorPrimaryText,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2), // changes the shadow direction
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  imagePath,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                Text(
                  artist,
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // RATE FUNCTIONALITY
                    },
                    child: Text('Rate',
                        style: TextStyle(
                            fontSize: 16, color: AppColors.colorPrimaryText)),
                  ),
                ),
                SizedBox(width: 35),
                SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // ADD TO LIST FUNCTIONALITY
                      },
                      child: Text('Add to list',
                          style: TextStyle(
                              fontSize: 16, color: AppColors.colorPrimaryText)),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
