import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meme_editor/presentation/home/screens/edit_screen.dart';
import 'package:go_router/go_router.dart';

import '../../../application/home/home_provider.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class ImageDetails extends HookConsumerWidget {
  const ImageDetails({super.key, required this.index});
  static const route = '/image-detail';
  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final memeDetails = state.data.memes[index];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Details'),
        actions: [
          IconButton(
            onPressed: () => context.push(
              "${EditorScreen.route}?url=${memeDetails.url}",
            ),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Column(
          mainAxisAlignment: mainCenter,
          crossAxisAlignment: crossCenter,
          children: [
            Expanded(
              child: ExtendedImage.network(
                memeDetails.url,
                layoutInsets: padding20,
                fit: BoxFit.contain,
                //enableLoadState: false,
                mode: ExtendedImageMode.gesture,
                initGestureConfigHandler: (state) {
                  return GestureConfig(
                    minScale: 0.9,
                    animationMinScale: 0.7,
                    maxScale: 3.0,
                    animationMaxScale: 3.5,
                    speed: 1.0,
                    inertialSpeed: 100.0,
                    initialScale: 1.0,
                    inPageView: false,
                    initialAlignment: InitialAlignment.center,
                  );
                },
              ),
            ),
            // ExtendedImage.network(
            //   memeDetails.url,
            //   height: 500.h,
            //   width: double.infinity,
            //   fit: BoxFit.contain,
            //   mode: ExtendedImageMode.editor,
            //   //extendedImageEditorKey: ,
            //   initEditorConfigHandler: (state) {
            //     return EditorConfig(
            //       maxScale: 8.0,
            //       cropRectPadding: const EdgeInsets.all(20.0),
            //       hitTestSize: 20.0,
            //       cropAspectRatio: 1.8 / 2.7,
            //     );
            //   },
            // ),
            gap10,
            Container(
              color: Colors.grey[200],
              padding: padding20,
              width: 1.sw,
              child: Column(
                children: [
                  Text(
                    "Name: ${memeDetails.name}",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  gap4,
                  Text(
                    "ID: ${memeDetails.id}",
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  gap4,
                  Text(
                    "Captions: ${memeDetails.captions}",
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  gap4,
                  Text(
                    "Width: ${memeDetails.width}",
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  gap4,
                  Text(
                    "Height: ${memeDetails.height}",
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  gap4,
                  Text(
                    "Box Count: ${memeDetails.box_count}",
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
