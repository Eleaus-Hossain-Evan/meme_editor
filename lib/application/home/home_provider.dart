import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infastructure/meme_repo.dart';
import 'home_state.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) => HomeNotifier(MemeRepo(), ref),
  name: "homeProvider",
);

class HomeNotifier extends StateNotifier<HomeState> {
  final MemeRepo repo;

  final Ref _ref;

  HomeNotifier(this.repo, this._ref) : super(HomeState.init());

  void getMemeData() async {
    state = state.copyWith(loading: true);
    final result = await repo.getMemes();

    // log(result.toString());

    result.fold(
      (l) {
        return state = state.copyWith(failure: l, loading: false);
      },
      (r) => state = state.copyWith(data: r.data, loading: false),
    );
  }
}
