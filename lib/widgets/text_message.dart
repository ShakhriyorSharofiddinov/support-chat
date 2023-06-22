import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  const TextMessage(
    this.message, this.isSend,
      {Key? key,
  }) : super(key: key);

  final String message;
  final bool isSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: isSend ? Colors.green.shade600 : Colors.green.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isSend
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1!.color,
        ),
      ),
    );
  }
}
