import 'dart:async';

import 'package:flutter/material.dart';

import 'loading_screen_controller.dart';

class LoadingScreen {
  factory LoadingScreen() => _shared;
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  LoadingScreen._sharedInstance();

  LoadingScreenController? controller;
// hide the overlay and dispose the current controller
  void hide() {
    controller?.close();
    controller = null;
  }
// display an overlay
  void show({required BuildContext context, required String text}) {
    // if the overlay already exists
    if (controller?.update(text) ?? false) {
      return;
    } else {
      // create a new one my boiii
      controller = showOverlay(context: context, text: text);
    }
  }
// create the overlay
  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final _text = StreamController<String>();
    _text.add(text);
    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        // default stateful widget
        return Material(
          color: Colors.black.withAlpha(150),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
                child: Container(
              constraints: BoxConstraints(
                  maxWidth: size.width * 0.8,
                  maxHeight: size.height * 1,
                  minWidth: size.width * 0.5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    StreamBuilder(
                      stream: _text.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data as String);
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                ),
              ),
            )),
          ),
        );
      },
    );
    state?.insert(overlay);
  // specify the passed function
    return LoadingScreenController(close: () {
      _text.close();
      overlay.remove();
      return true;
    }, update: (text) {
      _text.add(text);
      return true;
    });
  }
}
