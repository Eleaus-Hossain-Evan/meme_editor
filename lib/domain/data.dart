import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'meme.dart';

class Data extends Equatable {
  final List<Meme> memes;
  const Data({
    required this.memes,
  });

  Data copyWith({
    List<Meme>? memes,
  }) {
    return Data(
      memes: memes ?? this.memes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'memes': memes.map((x) => x.toMap()).toList(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      memes: List<Meme>.from(map['memes']?.map((x) => Meme.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() => 'Data(memes: $memes)';

  @override
  List<Object> get props => [memes];
}
