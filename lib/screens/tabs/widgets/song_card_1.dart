// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SongCard1 extends StatelessWidget {
  final String title;
  final String artist;

  SongCard1({
    this.title = "Song Title",
    this.artist = "Song Artist",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Image.asset(
                'assets/img/albumart.jpg',
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 26),
                      Text(
                        artist,
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.arrow_upward_rounded),
                      const SizedBox(width: 10),
                      Icon(Icons.arrow_downward_rounded),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
