import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/utils/color_manager.dart';

class ListItemCard extends StatelessWidget {
  final TrackModel trackDetails;
  final void Function() refreshListScreen;

  const ListItemCard({
    Key? key,
    required this.trackDetails,
    required this.refreshListScreen,
  }) : super(key: key);

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
        ).then((_) {
          refreshListScreen();
        });
      },
      child: Card(
        elevation: 3,
        // margin: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),

        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                // padding: const EdgeInsets.all(8.0),
                child: Container(
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
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    songFieldText(
                      label: 'Artists',
                      value: trackDetails.trackArtist.join(', '),
                    ),
                    const SizedBox(height: 5),
                    songFieldText(
                      label: 'Likes',
                      value: trackDetails.likeList!.length.toString(),
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

RichText songFieldText({required String label, required String value}) {
  return RichText(
    text: TextSpan(
      text: "$label: ",
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 15,
      ),
      children: [
        TextSpan(
          text: value,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
    overflow: TextOverflow.ellipsis,
  );
}

class TrackListView extends StatelessWidget {
  final List<TrackModel> tracksList;
  final void Function() refreshListScreen;

  const TrackListView({
    Key? key,
    required this.tracksList,
    required this.refreshListScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tracksList.length,
      itemBuilder: (context, index) {
        return ListItemCard(
          trackDetails: tracksList[index],
          refreshListScreen: refreshListScreen,
        );
      },
    );
  }
}
