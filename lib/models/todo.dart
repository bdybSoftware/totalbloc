// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:uuid/uuid.dart';

import "package:equatable/equatable.dart";

var uuid = const Uuid();

class Todo extends Equatable {
  final String todoUuid;
  final String todoName;
  final String todoDescription;
  final bool todoFav;
  Todo({
    String? todoUuid,
    required this.todoName,
    required this.todoDescription,
    required this.todoFav,
  }) : todoUuid = todoUuid ?? uuid.v4();

  Todo copyWith({
    String? todoUuid,
    String? todoName,
    String? todoDescription,
    bool? todoFav,
  }) {
    return Todo(
      todoUuid: todoUuid ?? this.todoUuid,
      todoName: todoName ?? this.todoName,
      todoDescription: todoDescription ?? this.todoDescription,
      todoFav: todoFav ?? this.todoFav,
    );
  }

  @override
  List<Object> get props => [todoUuid, todoName, todoDescription, todoFav];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todoUuid': todoUuid,
      'todoName': todoName,
      'todoDescription': todoDescription,
      'todoFav': todoFav,
    };
  }

// the sqflite methods

// for storing to sqflite
  Map<String, dynamic> toSfqlite() {
    return <String, dynamic>{
      'todoUuid': todoUuid,
      'todoName': todoName,
      'todoDescription': todoDescription,
      'todoFav': todoFav
          ? 1
          : 0, //sqflite does not have a bool variable, store as INTEGER, if true store 1, else 0.
    };
  }

// from retreiving from sqflite
  factory Todo.fromSqflite(Map<String, dynamic> map) {
    return Todo(
      todoUuid: map['todoUuid'] as String,
      todoName: map['todoName'] as String,
      todoDescription: map['todoDescription'] as String,
      todoFav: map['todoFav'] == 1
          ? true
          : false, // when fetching from sqflite (INTEGER) assign true if 1 , false else
    );
  }
// end of sqflite methods
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      todoUuid: map['todoUuid'] as String,
      todoName: map['todoName'] as String,
      todoDescription: map['todoDescription'] as String,
      todoFav: map['todoFav'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}
