import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'animation_data.dart';

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
abstract class SingleAnimationState<S extends StatefulWidget>
    extends SingleAnimationStateBare<S>
    with SingleAnimationDefault {}

/// The animation [controller] had not been bind with [setState] callback here.
/// You may consider [SingleAnimationState] instead.
abstract class SingleAnimationStateBare<S extends StatefulWidget>
    extends State<S>
    with SingleTickerProviderStateMixin, SingleAnimationMixin {}

mixin SingleAnimationDefault<S extends StatefulWidget>
    on SingleAnimationMixin<S> {
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

mixin SingleAnimationMixin<S extends StatefulWidget>
    on SingleTickerProviderStateMixin<S> {
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
