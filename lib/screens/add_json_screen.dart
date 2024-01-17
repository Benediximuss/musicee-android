import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/widgets/loaders/loader_view.dart';
import 'package:path/path.dart' as path;

class AddJsonScreen extends StatefulWidget {
  const AddJsonScreen({super.key});

  @override
  _AddJsonScreenState createState() => _AddJsonScreenState();
}

class _AddJsonScreenState extends State<AddJsonScreen> {
  File? selectedFile;

  bool _isLoading = false;

  void pickFile() async {
    setState(() {
      _isLoading = true;
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
        _isLoading = false;
      });
    }
  }

  void uploadFile() async {
    setState(() {
      _isLoading = true;
    });

    // Create a multipart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://musicee.us-west-2.elasticbeanstalk.com/tracks/upload_track_file/'),
    );

    // Attach the file to the request
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        selectedFile!.path,
        contentType: MediaType('application', 'json'),
      ),
    );

    // Send the request
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // File successfully uploaded
        print('File uploaded successfully');

        setState(() {
          _isLoading = false;
        });

        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.8),
          builder: (context) => const UploadDialog(),
        );
      } else {
        // Handle other status codes
        print('File upload failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderView(
      condition: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('File Upload'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: pickFile,
                child: const Text('Pick .json File'),
              ),
              const SizedBox(height: 20),
              if (selectedFile != null)
                Text(
                  'Selected File: ${path.basename(selectedFile!.path)}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              const SizedBox(height: 20),
              if (selectedFile != null)
                ElevatedButton(
                  onPressed: uploadFile,
                  child: const Text('Upload File'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadDialog extends StatelessWidget {
  const UploadDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorManager.colorBG,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(24.0), // Adjust the radius as needed
      ),
      icon: const Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: 75,
      ),
      content: const Text(
        'Upload Successful!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName(Routes.homeScreen),
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
