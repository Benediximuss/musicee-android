// import 'package:flutter/material.dart';
// import 'package:musicee_app/models/track.dart';
// import 'package:musicee_app/screens/all_tracks_screen.dart';
// import 'package:musicee_app/utils/color_manager.dart';

// class UserLikesScreen extends StatefulWidget {
//   const UserLikesScreen(
//       {Key? key, required this.username, required this.likesList})
//       : super(key: key);

//   final String username;
//   final List<int> likesList;

//   @override
//   _UserLikesScreenState createState() => _UserLikesScreenState();
// }

// class _UserLikesScreenState extends State<UserLikesScreen> {
  
//   late List<Track> tracksList;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: RichText(
//           text: TextSpan(
//             text: "Liked songs of ",
//             style: const TextStyle(
//                 color: ColorManager.colorAppBarText, fontSize: 20),
//             children: [
//               TextSpan(
//                 text: widget.username,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: widget.likesList.length,
//         itemBuilder: (context, index) {
//           return ListItemCard(track: widget.likesList[index]);
//         },
//       ),
//     );
//   }
// }
