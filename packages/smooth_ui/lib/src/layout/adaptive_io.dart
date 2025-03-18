import 'dart:io';

import 'adaptive_data.dart';

AdaptedLayout initLayout() {
  return AdaptedLayout(
    mode:
        Platform.isAndroid || Platform.isIOS
            ? WindowMode.portrait
            : WindowMode.landscape,
  );
}

Future<AdaptedLayout> adaptLayout() async {
  return const AdaptedLayout();
}
