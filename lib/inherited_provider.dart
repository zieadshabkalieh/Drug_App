import 'package:flutter/material.dart';
import 'model.dart';
class InheritedDataProvider extends InheritedWidget {
  final List<Model> data;
  InheritedDataProvider({
    required Widget child,
    required this.data,
  }) : super(child: child);
  @override
  bool updateShouldNotify(InheritedDataProvider oldWidget) {
    return data != oldWidget.data;
  }
  static InheritedDataProvider? of(BuildContext context) =>  context.dependOnInheritedWidgetOfExactType<InheritedDataProvider>();
}