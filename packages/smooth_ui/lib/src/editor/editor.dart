import 'package:flutter/widgets.dart';
import 'package:wrap/wrap.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  Widget build(BuildContext context) {
    return 'placeholder'.asText();
  }
}
