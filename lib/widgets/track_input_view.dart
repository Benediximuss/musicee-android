import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/utils/theme_manager.dart';
import 'package:musicee_app/widgets/loaders/loader_view.dart';

class TrackInputView extends StatefulWidget {
  const TrackInputView({
    Key? key,
    required this.inputType,
    required this.apiFunction,
    this.trackModel,
  }) : super(key: key);

  final InputTypes inputType;
  final void Function({
    required TrackModel requestModel,
    required Function() beforeRequest,
    required Function(String) thenRequest,
    required Function(dynamic) onError,
  }) apiFunction;
  final TrackModel? trackModel;

  @override
  _TrackInputViewState createState() => _TrackInputViewState();
}

class _TrackInputViewState extends State<TrackInputView> {
  // Controllers for form fields
  final _trackNameController = TextEditingController();
  final List<TextEditingController> _artistNameControllers = [];
  final _albumNameController = TextEditingController();
  final _trackYearController = TextEditingController();
  final _genreController = TextEditingController();

  // Focus nodes for form fields
  final _trackNameFocus = FocusNode();
  final List<FocusNode> _artistNameFocuses = [];
  final _albumNameFocus = FocusNode();
  final _trackYearFocus = FocusNode();
  final _genreFocus = FocusNode();

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
    }

    if (_genreController.text.isEmpty) {
      setState(() {
        _genreFocus.requestFocus();
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

  @override
  void initState() {
    _addArtistInput();

    if (widget.inputType == InputTypes.UPDATE) {
      _trackNameController.text = widget.trackModel!.trackName;
      _albumNameController.text = widget.trackModel!.trackAlbum;
      _genreController.text = widget.trackModel!.genre!;
      _trackYearController.text =
          widget.trackModel!.trackReleaseYear.toString();
      List<String> artists = widget.trackModel!.trackArtist;
      _artistNameControllers[0].text = artists[0];
      for (int i = 1; i < artists.length; i += 2) {
        _addArtistInput();
        _artistNameControllers.last.text = artists[i];
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderView(
      condition: _isLoading,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 32.0, horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _songFieldInput(
                  label: 'Title',
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
                  label: 'Album',
                  icon: Icons.album_rounded,
                  controller: _albumNameController,
                  focus: _albumNameFocus,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: _songFieldInput(
                        label: 'Genre',
                        icon: Icons.library_music_rounded,
                        controller: _genreController,
                        focus: _genreFocus,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 4,
                      child: _songFieldInput(
                        label: 'Year',
                        icon: Icons.calendar_month_rounded,
                        controller: _trackYearController,
                        focus: _trackYearFocus,
                        inputType: TextInputType.datetime,
                      ),
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
                        widget.apiFunction(
                          requestModel: TrackModel(
                            trackName: _trackNameController.text,
                            trackArtist: _artistNameControllers
                                .map((controller) => controller.text)
                                .toList(),
                            trackAlbum: _albumNameController.text,
                            genre: _genreController.text,
                            trackReleaseYear:
                                int.parse(_trackYearController.text),
                          ),
                          beforeRequest: () {
                            setState(() {
                              _isLoading = true;
                              _isFailed = false;
                            });
                          },
                          thenRequest: (response) {
                            setState(() {
                              _isLoading = false;
                              _isFailed = false;
                            });
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierColor: Colors.black.withOpacity(0.8),
                              builder: (context) => AddTrackDialog(
                                trackID: response,
                                inputType: widget.inputType,
                              ),
                            );
                          },
                          onError: (error) {
                            setState(() {
                              _isLoading = false;
                              _isFailed = true;
                              print("3131: $error");
                            });
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      (widget.inputType == InputTypes.ADD)
                          ? "Add Song"
                          : "Update song",
                      style: const TextStyle(
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
    );
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
  const AddTrackDialog({
    super.key,
    required this.trackID,
    required this.inputType,
  });

  final String trackID;
  final InputTypes inputType;

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
      content: Text(
        (inputType == InputTypes.ADD)
            ? "New Song Added Successfully"
            : "Song Updated Successfully",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            if (inputType == InputTypes.ADD) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.songDetailsScreen,
                ModalRoute.withName(Routes.homeScreen),
                arguments: {"trackID": trackID},
              );
            } else {
              Navigator.popUntil(
                context,
                ModalRoute.withName(Routes.songDetailsScreen),
              );

              Navigator.pop(context, true);

              Navigator.pushNamed(
                context,
                Routes.songDetailsScreen,
                arguments: {'trackID': trackID},
              );

              // Navigator.pushReplacementNamed(
              //   context,
              //   Routes.songDetailsScreen,
              //   arguments: {'trackID': trackID},
              // );
            }
          },
          child: const DecoratedBox(
            decoration: BoxDecoration(
              color: ColorManager.colorPrimary,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: Text(
                'Show Song',
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

enum InputTypes {
  ADD,
  UPDATE,
}
