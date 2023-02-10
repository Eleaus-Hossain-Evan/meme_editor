import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/data.dart';
import '../../utils/utils.dart';

class HomeState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final Data data;

  const HomeState({
    required this.loading,
    required this.failure,
    required this.data,
  });

  factory HomeState.init() => HomeState(
        failure: CleanFailure.none(),
        loading: false,
        data: const Data(memes: []),
      );
  HomeState copyWith({
    bool? loading,
    CleanFailure? failure,
    Data? data,
  }) {
    return HomeState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      data: data ?? this.data,
    );
  }

  @override
  String toString() =>
      'HomeState(loading: $loading, failure: $failure, data: $data)';

  @override
  List<Object> get props => [loading, failure, data];

  Map<String, dynamic> toMap() {
    return {
      'loading': loading,
      'failure': failure,
      'data': data.toMap(),
    };
  }

  factory HomeState.fromMap(Map<String, dynamic> map) {
    return HomeState(
      loading: map['loading'] ?? false,
      failure: map['failure'],
      data: Data.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeState.fromJson(String source) =>
      HomeState.fromMap(json.decode(source));
}
