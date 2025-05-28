import 'package:flutter/material.dart';


class UserProvider extends InheritedWidget {
  final dynamic userId;

  const UserProvider({
    super.key,
    required this.userId,
    required super.child,
  });

  @override
  bool updateShouldNotify(UserProvider oldWidget) {
    return userId != oldWidget.userId;
  }

  static UserProvider? of(BuildContext context) {
    // This finds the nearest UserProvider up the widget tree.
    return context.dependOnInheritedWidgetOfExactType<UserProvider>();
  }
}
