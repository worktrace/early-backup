import 'dart:async';

import 'package:custom_app/src/size/adapt_size_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/binding.dart';
import 'package:state_reuse/size.dart';

import 'adapt_size.dart';

class AdaptiveSize extends StatefulWidget {
  const AdaptiveSize({super.key, this.ratio = 1, required this.child})
    : assert(ratio > 0);

  /// Additional ratio applied to the size scale,
  /// which is usually configured by local user settings.
  final double ratio;
  final Widget child;

  @override
  State<AdaptiveSize> createState() => _AdaptiveSizeState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('ratio', ratio));
  }
}

class _AdaptiveSizeState extends State<AdaptiveSize> with AdaptSize {
  late SizeAdapter _adapter = initAdapter;

  @override
  void initState() {
    super.initState();
    unawaited(
      adaptPlatformSize.then((adapter) {
        setState(() => _adapter = adapter);
      }),
    );
  }

  @override
  Widget render(BuildContext context) {
    final adapter = _adapter.scale(widget.ratio);
    final size = this.size ?? initSize;
    return widget.child.inherit(AdaptedSize.adapt(adapter, size));
  }
}
