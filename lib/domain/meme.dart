import 'dart:convert';

import 'package:equatable/equatable.dart';

class Meme extends Equatable {
  final String id;
  final String name;
  final String url;
  final int width;
  final int height;
  final int box_count;
  final int captions;
  const Meme({
    required this.id,
    required this.name,
    required this.url,
    required this.width,
    required this.height,
    required this.box_count,
    required this.captions,
  });

  Meme copyWith({
    String? id,
    String? name,
    String? url,
    int? width,
    int? height,
    int? box_count,
    int? captions,
  }) {
    return Meme(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      width: width ?? this.width,
      height: height ?? this.height,
      box_count: box_count ?? this.box_count,
      captions: captions ?? this.captions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'width': width,
      'height': height,
      'box_count': box_count,
      'captions': captions,
    };
  }

  factory Meme.fromMap(Map<String, dynamic> map) {
    return Meme(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      url: map['url'] ?? '',
      width: map['width']?.toInt() ?? 0,
      height: map['height']?.toInt() ?? 0,
      box_count: map['box_count']?.toInt() ?? 0,
      captions: map['captions']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Meme.fromJson(String source) => Meme.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Meme(id: $id, name: $name, url: $url, width: $width, height: $height, box_count: $box_count, captions: $captions)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      url,
      width,
      height,
      box_count,
      captions,
    ];
  }
}
