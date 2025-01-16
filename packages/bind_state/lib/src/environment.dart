import 'package:flutter/widgets.dart';

abstract class WidgetBindingState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  @mustCallSuper
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
