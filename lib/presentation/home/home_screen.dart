import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../utils/utils.dart';
import '../../widgets/k_list_view_separated.dart';
import '../../widgets/widgets.dart';

import '../../application/home/home_provider.dart';
import 'screens/image_details.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  static const route = '/home';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);

    useEffect(() {
      Future.microtask(() {
        ref.read(homeProvider.notifier).getMemeData();
      });
      return () {};
    }, []);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: KListViewSeparated(
        shrinkWrap: true,
        count: state.data.memes.length,
        separator: Divider(
          color: Colors.grey,
          height: 2.h,
        ),
        builder: (context, index) {
          final meme = state.data.memes[index];
          return InkWell(
            onTap: () {
              context.push(
                "${ImageDetails.route}?index=$index",
              );
            },
            child: Hero(
              tag: "image${meme.id}",
              child: Column(
                children: [
                  gap20,
                  // Image.network(meme.url),
                  //CachedNetworkImage(imageUrl: meme.url),
                  KCachedNetworkImageLoading(
                    imageUrl: meme.url,
                    height: 200.h,
                    width: 200.w,
                    fit: BoxFit.cover,
                  ),
                  gap10,
                  Text(
                    meme.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Dimensions.mediumTextSize,
                      color: context.color.shadow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
