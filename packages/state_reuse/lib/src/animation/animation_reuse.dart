import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'animation.dart';

abstract class SingleAnimationWidget extends StatefulWidget {
  const SingleAnimationWidget({
    super.key,
    this.animation = const AnimationData(),
  });

  final AnimationData animation;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AnimationData>('animation', animation));
  }
}

/// The animation [controller] had been bind with [setState] callback here.
/// You may consider [SingleAnimationStateBare] instead.
abstract class SingleAnimationState<W extends StatefulWidget>
    extends SingleAnimationStateBare<W>
    with SingleAnimationDefault {}

/// The animation [controller] had not been bind with [setState] callback here.
/// You may consider [SingleAnimationState] instead.
abstract class SingleAnimationStateBare<W extends StatefulWidget>
    extends State<W>
    with SingleTickerProviderStateMixin, SingleAnimationMixin {}

mixin SingleAnimationDefault<W extends StatefulWidget>
    on SingleAnimationMixin<W> {
  /// Encapsulate [setState] for [dispose] to call the same one.
  void _setState() => setState(() {});

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    controller.addListener(_setState);
  }

  @override
  @mustCallSuper
  void dispose() {
    controller.removeListener(_setState);
    super.dispose();
  }
}

mixin SingleAnimationMixin<W extends StatefulWidget>
    on SingleTickerProviderStateMixin<W> {
  late final AnimationController controller = setupController();

  AnimationController setupController() => AnimationController(vsync: this);

  @override
  @mustCallSuper
  void initState() {
    super.initState();
  }

  @override
  @mustCallSuper
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  @mustCallSuper
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final c = controller;
    properties.add(DiagnosticsProperty<AnimationController>('controller', c));
  }
}
