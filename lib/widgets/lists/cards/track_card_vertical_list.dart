import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/utils/color_manager.dart';

class TrackCardVerticalList extends StatelessWidget {
  const TrackCardVerticalList({
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
        ).then((value) {
          if (value != null) {
            if (value == true) {
              if (refreshListScreen != null) {
                refreshListScreen!();
                print("3131: refreshed list!");
              } else {
                print("3131: null refresher function!");
              }
            } else {
              print("3131: no changes");
            }
          } else {
            print("3131: nothing returned");
          }
        });
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        color: ColorManager.lighterSwatch.shade100,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.music_note_rounded,
                    size: 50,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trackDetails.trackName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      trackDetails.trackArtist.join(', '),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Icon(
                          Icons.comment,
                          size: 18,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          trackDetails.comments!.length.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 25,
                  color: ColorManager.colorAppBarText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
