import 'dart:convert';

import '../domain/meme_response.dart';
import '../server/api_routes.dart';
import '../utils/utils.dart';

class MemeRepo {
  final myApi = NetworkHandler.instance;

  Future<Either<CleanFailure, MemeResponse>> getMemes() async {
    final data = await myApi.get(
      endPoint: APIRoute.getMemes,
      fromData: (data) => MemeResponse.fromMap(data),
      withToken: true,
    );

    return data.fold((l) {
      final error = jsonDecode(l.error);
      final failure = l.copyWith(error: error['error']['message']);
      return left(failure);
    }, (r) {
      return right(r);
    });
  }
}
