import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final IconData iconData;
  const MyIconButton(this.iconData, {super.key});

  @override
  Widget build(BuildContext context) {
    return  IconButton(
      onPressed: () {},
      icon: const Icon(Icons.image),
    );
  }
}
