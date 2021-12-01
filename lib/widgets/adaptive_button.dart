import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Function func;

  AdaptiveButton(this.text, this.func);

  @override
  Widget build(BuildContext context) {
    print('build adaptive button');
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              func(context);
            },
          )
        : TextButton(
            onPressed: () {
              func(context);
            },
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
            ),
          );
  }
}
