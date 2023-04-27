// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NoteModel {
  String? id;
  String title;
  String text;
  DateTime createdAt;
  DateTime updataedAt;
  NoteModel({
    this.id,
    required this.title,
    required this.text,
    required this.createdAt,
    required this.updataedAt,
  });

  NoteModel copyWith({
    String? id,
    String? title,
    String? text,
    DateTime? createdAt,
    DateTime? updataedAt,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      updataedAt: updataedAt ?? this.updataedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'text': text,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updataedAt': updataedAt.millisecondsSinceEpoch,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] as String,
      text: map['text'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updataedAt: DateTime.fromMillisecondsSinceEpoch(map['updataedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) => NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoteModel(id: $id, title: $title, text: $text, createdAt: $createdAt, updataedAt: $updataedAt)';
  }

  @override
  bool operator ==(covariant NoteModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.text == text &&
      other.createdAt == createdAt &&
      other.updataedAt == updataedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      text.hashCode ^
      createdAt.hashCode ^
      updataedAt.hashCode;
  }
}
