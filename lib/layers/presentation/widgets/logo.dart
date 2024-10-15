import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.notes,
          size: 100,
        ),
        Text(
          'Notes',
          style: Theme.of(context).textTheme.headlineLarge,
        )
      ],
    );
  }
}
