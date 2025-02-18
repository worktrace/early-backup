import 'package:flutter/widgets.dart';

extension WrapAdaptSize on Widget {
  NotificationListener<SizeChangedLayoutNotification> listenSize({
    Key? key,
    required VoidCallback onResize,
  }) {
    return NotificationListener(
      key: key,
      child: SizeChangedLayoutNotifier(child: this),
      onNotification: (notification) {
        onResize();
        return true;
      },
    );
  }

  NotificationListener<SizeChangedLayoutNotification> adaptSize(
    AdaptSize state, {
    Key? key,
  }) {
    return listenSize(key: key, onResize: state._onResize);
  }
}

mixin AdaptSize<S extends StatefulWidget> on State<S> {
  Size? _size;
  Size? get size => _size;
  Size get sizeOrZero => size ?? Size.zero;

  /// The default action here is to call [setState].
  /// You can override this method to do something else.
  void onResize(Size size) => setState(() {});

  void onSizeAvailable(Size size) => setState(() {});

  void _onResize() {
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      if (!mounted) return;
      _size = context.size;
      onResize(size!);
    });
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      if (!mounted) return;
      _size = context.size;
      onSizeAvailable(size!);
    });
  }

  /// Override this method to define how to build the widget.
  /// This method is like the [build] method in most [State]s,
  /// but here the [build] method is used to wrap [WrapAdaptSize.adaptSize],
  /// so that it's supposed to override this method to define how to build.
  Widget render(BuildContext context);

  /// Use [render] instead,
  /// it's strongly not recommended to override this method here.
  @override
  @protected
  Widget build(BuildContext context) {
    return render(context).adaptSize(this);
  }
}
