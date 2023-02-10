import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'data.dart';

class MemeResponse extends Equatable {
  final bool success;
  final Data data;
  MemeResponse({
    required this.success,
    required this.data,
  });

  MemeResponse copyWith({
    bool? success,
    Data? data,
  }) {
    return MemeResponse(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'data': data.toMap(),
    };
  }

  factory MemeResponse.fromMap(Map<String, dynamic> map) {
    return MemeResponse(
      success: map['success'] ?? false,
      data: Data.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MemeResponse.fromJson(String source) =>
      MemeResponse.fromMap(json.decode(source));

  @override
  String toString() => 'MemeResponse(success: $success, data: $data)';

  @override
  List<Object> get props => [success, data];
}
