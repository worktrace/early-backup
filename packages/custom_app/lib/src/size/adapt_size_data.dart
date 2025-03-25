import 'package:flutter/widgets.dart';

class AdaptedSize {
  const AdaptedSize({this.mode = WindowMode.landscape, this.ratio = 1})
    : assert(ratio > 0);

  factory AdaptedSize.adapt(SizeAdapter adapter, Size size) {
    return AdaptedSize(mode: adapter.adapt(size), ratio: adapter.ratio);
  }

  final WindowMode mode;
  final double ratio;
}

abstract class SizeAdapter {
  const SizeAdapter({this.ratio = 1}) : assert(ratio > 0);

  final double ratio;

  WindowMode adapt(Size size);
}

class DesktopSizeAdapter extends SizeAdapter {
  const DesktopSizeAdapter({
    this.landscapeWidth = 1000,
    this.portraitWidth = 600,
    super.ratio,
  });

  final double landscapeWidth;
  final double portraitWidth;

  @override
  WindowMode adapt(Size size) {
    if (size.width >= landscapeWidth * ratio) return WindowMode.landscape;
    if (size.width >= portraitWidth * ratio) return WindowMode.medium;
    return WindowMode.portrait;
  }
}

class MobileSizeAdapter extends SizeAdapter {
  const MobileSizeAdapter({super.ratio, this.landscapeWidth = 1200});

  final double landscapeWidth;

  @override
  WindowMode adapt(Size size) {
    if (size.height >= size.width) return WindowMode.portrait;
    if (size.width >= landscapeWidth * ratio) return WindowMode.landscape;
    return WindowMode.medium;
  }
}

enum WindowMode { landscape, medium, portrait }

const kDesktopWindowSize = Size(1000, 800);
const kMobileScreenSize = Size(430, 932);
