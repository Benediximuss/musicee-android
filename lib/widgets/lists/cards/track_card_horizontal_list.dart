import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/utils/color_manager.dart';

class TrackCardHorizontalList extends StatelessWidget {
  const TrackCardHorizontalList({
    Key? key,
    required this.trackDetails,
    required this.refreshListScreen,
  }) : super(key: key);

  final TrackModel trackDetails;
  final void Function()? refreshListScreen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.songDetailsScreen,
          arguments: {
            'trackID': trackDetails.trackId,
          },
        ).then(
          (_) {
            if (refreshListScreen != null) {
              refreshListScreen!();
            } else {
              print("3131: then null refresh!");
            }
          },
        );
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            width: 150,
            height: 50,
            margin: const EdgeInsets.only(right: 8.0, left: 8.0),
            decoration: BoxDecoration(
              color: ColorManager.swatchPrimary.shade100,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.music_note_rounded,
                        size: 50,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          trackDetails.trackName,
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          trackDetails.trackArtist.join(', '),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.thumb_up,
                        size: 18,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        trackDetails.trackLikeList!.length.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          )),
    );
  }
}
