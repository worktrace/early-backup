import 'package:compat_utils/types.dart';
import 'package:data_build/annotation.dart';
import 'package:flutter/widgets.dart';

part 'adapt_size_data.data.g.dart';

class AdaptedSize with _$Copy$AdaptedSize implements Copyable<AdaptedSize> {
  @copy
  const AdaptedSize({this.mode = WindowMode.landscape, this.ratio = 1})
    : assert(ratio > 0);

  factory AdaptedSize.adapt(SizeAdapter adapter, Size size) {
    return AdaptedSize(mode: adapter.adapt(size), ratio: adapter.ratio);
  }

  final WindowMode mode;
  final double ratio;
}

abstract class SizeAdapter
    implements Scalable<SizeAdapter>, Copyable<SizeAdapter> {
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

  @override
  DesktopSizeAdapter scale(double times) => copyWith(ratio: ratio * times);

  @override
  DesktopSizeAdapter copyWith({
    double? ratio,
    double? landscapeWidth,
    double? portraitWidth,
  }) => DesktopSizeAdapter(
    ratio: ratio ?? this.ratio,
    landscapeWidth: landscapeWidth ?? this.landscapeWidth,
    portraitWidth: portraitWidth ?? this.portraitWidth,
  );
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

  @override
  MobileSizeAdapter scale(double times) => copyWith(ratio: ratio * times);

  @override
  MobileSizeAdapter copyWith({double? ratio, double? landscapeWidth}) {
    return MobileSizeAdapter(
      ratio: ratio ?? this.ratio,
      landscapeWidth: landscapeWidth ?? this.landscapeWidth,
    );
  }
}

enum WindowMode { landscape, medium, portrait }

const kDesktopWindowSize = Size(1000, 800);
const kMobileScreenSize = Size(430, 932);
