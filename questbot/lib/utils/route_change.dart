import 'package:flutter/material.dart';

void routeChangeNamed(
    BuildContext context,
    String routeName, {
      Object? arguments,
      bool replace = false,
    }) {
  if (replace) {
    Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
    );
  } else {
    Navigator.pushNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }
}
