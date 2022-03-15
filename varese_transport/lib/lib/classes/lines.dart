import 'package:flutter/material.dart';

class Lines {
  String line;
  String color;

  Lines(this.line, this.color);

  factory Lines.fromJson(dynamic json) {
    return Lines(json[0] as String, json[1] as String);
  }

  @override
  String toString() {
    return '[${this.line} + ${this.color}]';
  }
}
