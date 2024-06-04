import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Semantics(
        button: true,
        enabled: true,
        onLongPressHint: 'Press to go back.',
        child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)));
  }
}
