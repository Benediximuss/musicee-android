import 'package:flutter/material.dart';
import 'package:musicee_app/widgets/loaders/custom_loader_indicator.dart';

class FutureBuilderWithLoader extends StatelessWidget {
  final Future<dynamic>? future;
  final Widget Function(AsyncSnapshot<dynamic> snapshot) onComplete;

  const FutureBuilderWithLoader({
    super.key,
    required this.future,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomLoaderIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      size: 100,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Error loading data:\n${snapshot.error}',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ]),
            ),
          );
        } else {
          return onComplete(snapshot);
        }
      },
    );
  }
}
