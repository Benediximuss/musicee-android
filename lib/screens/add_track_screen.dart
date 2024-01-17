import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/screens/add_json_screen.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/widgets/track_input_view.dart';

class AddTrackScreen extends StatelessWidget {
  const AddTrackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a song'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddJsonScreen(),
                ),
              );
            },
            child: const Text(
              'Upload JSON file',
              style: TextStyle(
                color: ColorManager.colorAppBarText,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: TrackInputView(
        inputType: InputTypes.ADD,
        apiFunction: _addSongLogic,
      ),
    );
  }

  void _addSongLogic({
    required TrackModel requestModel,
    required Function() beforeRequest,
    required Function(String) thenRequest,
    required Function(dynamic) onError,
  }) {
    beforeRequest();

    APIService.addTrack(requestModel).then(
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
