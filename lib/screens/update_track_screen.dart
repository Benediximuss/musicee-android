import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/widgets/future_builder_with_loader.dart';
import 'package:musicee_app/widgets/track_input_view.dart';

class UpdateTrackScreen extends StatelessWidget {
  const UpdateTrackScreen({Key? key, required this.trackID}) : super(key: key);

  final String trackID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update a song'),
      ),
      body: FutureBuilderWithLoader(
        future: APIService.getTrackDetails(trackID),
        onComplete: (snapshot) {
          return TrackInputView(
            inputType: InputTypes.UPDATE,
            apiFunction: _updateSongLogic,
            trackModel: snapshot.data,
          );
        },
      ),
    );
  }

  void _updateSongLogic({
    required TrackModel requestModel,
    required Function() beforeRequest,
    required Function(String) thenRequest,
    required Function(dynamic) onError,
  }) {
    beforeRequest();

    APIService.updateTrack(trackID, requestModel).then(
      (response) {
        thenRequest(response);
      },
    ).catchError(
      (error) {
        onError(error);
      },
    );
  }
}
