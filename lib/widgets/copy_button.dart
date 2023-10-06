
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyTextButton extends StatelessWidget {
  final String textToCopy; 

  const CopyTextButton(this.textToCopy, {super.key});

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: textToCopy));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Text copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _copyToClipboard(context),
      icon: Icon(Icons.content_copy),
      
    );
  }
}