import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/utils/asset_manager.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/utils/theme_manager.dart';
import 'package:musicee_app/widgets/loader_view.dart';

class AddTrackScreen extends StatefulWidget {
  const AddTrackScreen({Key? key}) : super(key: key);

  @override
  _AddTrackScreenState createState() => _AddTrackScreenState();
}

class _AddTrackScreenState extends State<AddTrackScreen> {
  // Controllers for form fields
  final _trackNameController = TextEditingController();
  final List<TextEditingController> _artistNameControllers = [];
  final _albumNameController = TextEditingController();
  final _trackYearController = TextEditingController();

  // Focus nodes for form fields
  final _trackNameFocus = FocusNode();
  final List<FocusNode> _artistNameFocuses = [];
  final _albumNameFocus = FocusNode();
  final _trackYearFocus = FocusNode();

  // UI Logic
  bool _isLoading = false;
  bool _isFailed = false;
  final String _errorMessage = 'Something gone wrong. Try again!';

  // ignore: prefer_final_fields
  List<Widget> _artistInputs = [];

  // Validation function
  bool _validateInputs() {
    if (_trackNameController.text.isEmpty) {
      setState(() {
        _trackNameFocus.requestFocus();
      });
      return false;
    }

    for (int i = 0; i < _artistNameControllers.length; i++) {
      if (_artistNameControllers[i].text.isEmpty) {
        setState(() {
          _artistNameFocuses[i].requestFocus();
        });
        return false;
      }
    }

    if (_albumNameController.text.isEmpty) {
      setState(() {
        _albumNameFocus.requestFocus();
      });
      return false;
    }

    if (_trackYearController.text.isEmpty) {
      setState(() {
        _trackYearFocus.requestFocus();
      });
      return false;
    } else {
      setState(() {
        FocusManager.instance.primaryFocus?.unfocus();
      });
      return true;
    }
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to avoid memory leaks
    _trackNameController.dispose();
    _albumNameController.dispose();
    _trackYearController.dispose();

    for (var element in _artistNameControllers) {
      element.dispose();
    }

    for (var element in _artistNameFocuses) {
      element.dispose();
    }

    _trackNameFocus.dispose();
    _albumNameFocus.dispose();
    _trackYearFocus.dispose();

    super.dispose();
  }

  void _initArtistInputs() {
    _addArtistInput();
  }

  @override
  void initState() {
    _initArtistInputs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: LoaderView(
        condition: _isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add a new song'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _songFieldInput(
                    label: 'Song Name',
                    icon: Icons.music_note_rounded,
                    controller: _trackNameController,
                    focus: _trackNameFocus,
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _artistInputs.length,
                    itemBuilder: (context, index) {
                      return _artistInputs[index];
                    },
                  ),
                  _songFieldInput(
                    label: 'Album Name',
                    icon: Icons.album_rounded,
                    controller: _albumNameController,
                    focus: _albumNameFocus,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _songFieldInput(
                          label: 'Release Year',
                          icon: Icons.calendar_month,
                          controller: _trackYearController,
                          focus: _trackYearFocus,
                          inputType: TextInputType.datetime,
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Visibility(
                    visible: _isFailed,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_validateInputs()) {
                          _addSongLogic();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        "Add Song",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addSongLogic() {
    List<String> artistNames =
        _artistNameControllers.map((controller) => controller.text).toList();

    setState(() {
      _isLoading = true;
      _isFailed = false;
    });

    final requestModel = TrackModel(
      trackName: _trackNameController.text,
      trackArtist: artistNames,
      trackAlbum: _albumNameController.text,
      trackReleaseYear: int.parse(_trackYearController.text),
    );

    APIService.addTrack(requestModel).then(
      (response) {
        setState(() {
          _isLoading = false;
        });

        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.8),
          builder: (context) => AddTrackDialog(trackID: response),
        );
      },
    ).catchError((error) {
      setState(() {
        _isLoading = false;
        _isFailed = true;
        print("3131: $error");
      });
    });
  }

  TextFormField _songFieldInput(
      {required String label,
      required IconData icon,
      required TextEditingController controller,
      required FocusNode focus,
      TextInputType? inputType}) {
    return TextFormField(
      controller: controller,
      focusNode: focus,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        labelStyle: const TextStyle(fontSize: 18),
        labelText: label,
        icon: Icon(icon),
        border: ThemeManager.buildFormOutline(controller),
      ),
      keyboardType: inputType,
    );
  }

  Row _artistFieldInput({
    required TextEditingController controller,
    required FocusNode focus,
  }) {
    return Row(
      children: [
        Expanded(
          child: _songFieldInput(
            label: (_artistInputs.isEmpty)
                ? 'Artist'
                : 'Artist ${(_artistInputs.length / 2 + 1).toInt()}',
            icon: Icons.people_alt_rounded,
            controller: controller,
            focus: focus,
          ),
        ),
        SizedBox(
          width: 40,
          child: (_artistInputs.length < 4)
              ? GestureDetector(
                  onTap: (_artistInputs.isEmpty)
                      ? () {
                          setState(() {
                            _addArtistInput();
                          });
                        }
                      : () {
                          setState(() {
                            _popArtistInput();
                          });
                        },
                  child: Icon(
                    (_artistInputs.isEmpty) ? Icons.add : Icons.clear_rounded,
                    size: 30,
                  ),
                )
              : null,
        ),
      ],
    );
  }

  void _popArtistInput() {
    _artistInputs.removeLast();
    _artistInputs.removeLast();
    _artistNameControllers.removeLast();
    _artistNameFocuses.removeLast();
  }

  void _addArtistInput() {
    var inputControl = TextEditingController();
    var inputFocus = FocusNode();

    _artistInputs.add(
      _artistFieldInput(
        controller: inputControl,
        focus: inputFocus,
      ),
    );

    _artistInputs.add(
      const SizedBox(height: 16),
    );

    _artistNameControllers.add(inputControl);
    _artistNameFocuses.add(inputFocus);
  }
}

class AddTrackDialog extends StatelessWidget {
  const AddTrackDialog({super.key, required this.trackID});

  final String trackID;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorManager.colorBG,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      icon: const Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: 75,
      ),
      content: const Text(
        'New Song Added Successfully!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.songDetailsScreen,
              ModalRoute.withName(Routes.homeScreen),
              arguments: {
                'title': 'ZART',
                'artist': 'ZORT',
                'imagePath': AssetManager.placeholderAlbumArt,
              },
            );
          },
          child: const DecoratedBox(
            decoration: BoxDecoration(
              color: ColorManager.colorPrimary,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.colorBG,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
