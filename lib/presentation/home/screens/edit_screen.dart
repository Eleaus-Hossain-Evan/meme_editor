import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../router/router.dart';
import '../../../widgets/common_widget.dart';
import '../../../application/crop_editor_helper.dart';

class EditorScreen extends HookConsumerWidget {
  static const String route = '/image_editor';
  final String url;

  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  bool _cropping = false;

  EditorScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context, ref) {
    EditorCropLayerPainter? _cropLayerPainter = const EditorCropLayerPainter();
    return Scaffold(
      appBar: AppBar(
        title: const Text('image editor demo'),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.photo_library),
          //   onPressed: _getImage,
          // ),
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              _cropImage(ref);
            },
          ),
        ],
      ),
      body: Column(children: <Widget>[
        Expanded(
            child:
                // _memoryImage != null
                //     ?
                ExtendedImage.network(
          url,
          fit: BoxFit.contain,
          mode: ExtendedImageMode.editor,
          enableLoadState: true,
          extendedImageEditorKey: editorKey,
          initEditorConfigHandler: (ExtendedImageState? state) {
            return EditorConfig(
              maxScale: 8.0,
              cropRectPadding: const EdgeInsets.all(20.0),
              hitTestSize: 20.0,
              cropLayerPainter: _cropLayerPainter,
              initCropRectType: InitCropRectType.imageRect,
              cropAspectRatio: CropAspectRatios.custom,
            );
          },
          cacheRawData: true,
        )
            // : ExtendedImage.asset(
            //     'assets/image.jpg',
            //     fit: BoxFit.contain,
            //     mode: ExtendedImageMode.editor,
            //     enableLoadState: true,
            //     extendedImageEditorKey: editorKey,
            //     initEditorConfigHandler: (ExtendedImageState? state) {
            //       return EditorConfig(
            //         maxScale: 8.0,
            //         cropRectPadding: const EdgeInsets.all(20.0),
            //         hitTestSize: 20.0,
            //         cropLayerPainter: _cropLayerPainter!,
            //         initCropRectType: InitCropRectType.imageRect,
            //         cropAspectRatio: _aspectRatio!.value,
            //       );
            //     },
            //     cacheRawData: true,
            //   ),
            ),
      ]),
      bottomNavigationBar: BottomAppBar(
        //color: Colors.lightBlue,
        shape: const CircularNotchedRectangle(),
        child: ButtonTheme(
          minWidth: 0.0,
          padding: EdgeInsets.zero,
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                FlatButtonWithIcon(
                  icon: const Icon(Icons.crop),
                  label: const Text(
                    'Crop',
                    style: TextStyle(fontSize: 10.0),
                  ),
                  textColor: Colors.white,
                  onPressed: () {},
                ),
                FlatButtonWithIcon(
                  icon: const Icon(Icons.flip),
                  label: const Text(
                    'Flip',
                    style: TextStyle(fontSize: 10.0),
                  ),
                  textColor: Colors.white,
                  onPressed: () {
                    editorKey.currentState!.flip();
                  },
                ),
                FlatButtonWithIcon(
                  icon: const Icon(Icons.rotate_left),
                  label: const Text(
                    'Rotate Left',
                    style: TextStyle(fontSize: 8.0),
                  ),
                  textColor: Colors.white,
                  onPressed: () {
                    editorKey.currentState!.rotate(right: false);
                  },
                ),
                FlatButtonWithIcon(
                  icon: const Icon(Icons.rotate_right),
                  label: const Text(
                    'Rotate Right',
                    style: TextStyle(fontSize: 8.0),
                  ),
                  textColor: Colors.white,
                  onPressed: () {
                    editorKey.currentState!.rotate(right: true);
                  },
                ),
                FlatButtonWithIcon(
                  icon: const Icon(Icons.restore),
                  label: const Text(
                    'Reset',
                    style: TextStyle(fontSize: 10.0),
                  ),
                  textColor: Colors.white,
                  onPressed: () {
                    editorKey.currentState!.reset();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _cropImage(WidgetRef ref) async {
    if (_cropping) {
      return;
    }
    String msg = '';
    try {
      _cropping = true;

      //await showBusyingDialog();

      Uint8List? fileData;

      /// native library

      fileData =
          await cropImageDataWithNativeLibrary(state: editorKey.currentState!);

      final String? filePath =
          await ImageSaver.save('extended_image_cropped_image.jpg', fileData!);
      // var filePath = await ImagePickerSaver.saveFile(fileData: fileData);

      msg = 'save image : $filePath';
    } catch (e, stack) {
      msg = 'save failed: $e\n $stack';
      print(msg);
    }

    ref.watch(routerProvider).pop();
    ref.watch(routerProvider).pop();
    BotToast.showText(text: msg);
    Logger.v('msg: $msg');
    _cropping = false;
  }

  Uint8List? _memoryImage;
}
