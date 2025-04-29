import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:wrap/wrap.dart';

extension WrapEnsureText on Widget {
  EnsureText ensureText({
    Key? key,
    TextDirection defaultDirection = TextDirection.ltr,
  }) => EnsureText(key: key, defaultDirection: defaultDirection, child: this);
}

class EnsureText extends StatelessWidget {
  const EnsureText({
    super.key,
    this.defaultDirection = TextDirection.ltr,
    required this.child,
  });

  final TextDirection defaultDirection;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var temp = child;
    if (MediaQuery.maybeOf(context) == null) temp = child.mediaAsView(context);
    if (Directionality.maybeOf(context) == null) {
      temp = temp.textDirection(defaultDirection);
    }
    return temp;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final d = defaultDirection;
    properties.add(EnumProperty<TextDirection>('defaultDirection', d));
  }
}
