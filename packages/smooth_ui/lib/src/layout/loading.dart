import 'dart:async';

import 'package:compat_utils/compat_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class LoadingContainer extends StatefulWidget {
  const LoadingContainer({
    super.key,
    this.process = const [],
    required this.onFinish,
    required this.onError,
    required this.child,
  });

  final List<FutureCallback> process;
  final VoidCallback onFinish;
  final ErrorCallback onError;

  final Widget child;

  @override
  State<LoadingContainer> createState() => _LoadingContainerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<FutureOrCallback>('process', process))
      ..add(ObjectFlagProperty<VoidCallback>.has('onFinish', onFinish))
      ..add(ObjectFlagProperty<ErrorCallback>.has('onError', onError));
  }
}

class _LoadingContainerState extends State<LoadingContainer> {
  @override
  void initState() {
    super.initState();
    unawaited(
      Future.wait(widget.process.map((process) => process()))
          .then((_) => widget.onFinish())
          .onError(widget.onError),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
