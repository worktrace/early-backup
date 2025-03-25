import 'dart:async';

import 'package:custom_app/src/size/adapt_size_data.dart';
import 'package:flutter/widgets.dart';
import 'package:inherit/inherit.dart';
import 'package:state_reuse/state_reuse.dart';

import 'adapt_size.dart';

class AdaptiveSize extends StatefulWidget {
  const AdaptiveSize({super.key, required this.child});

  final Widget child;

  @override
  State<AdaptiveSize> createState() => _AdaptiveSizeState();
}

class _AdaptiveSizeState extends State<AdaptiveSize> with AdaptSize {
  late SizeAdapter _adapter = initAdapter;

  @override
  void initState() {
    super.initState();
    unawaited(
      adaptPlatformSize.then((adapter) => setState(() => _adapter = adapter)),
    );
  }

  @override
  Widget render(BuildContext context) {
    return widget.child.inherit(
      AdaptedSize.adapt(_adapter, size ?? const Size(1000, 800)),
    );
  }
}
