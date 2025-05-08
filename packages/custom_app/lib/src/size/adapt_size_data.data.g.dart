// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartAnnotationsBuilder
// **************************************************************************

part of 'adapt_size_data.dart';

extension CopyAdaptedSize on AdaptedSize {
  AdaptedSize copyWith({WindowMode? mode, double? ratio}) {
    return AdaptedSize(mode: mode ?? this.mode, ratio: ratio ?? this.ratio);
  }
}

extension CopyDesktopSizeAdapter on DesktopSizeAdapter {
  DesktopSizeAdapter copyWith({
    double? landscapeWidth,
    double? portraitWidth,
    double? ratio,
  }) {
    return DesktopSizeAdapter(
      landscapeWidth: landscapeWidth ?? this.landscapeWidth,
      portraitWidth: portraitWidth ?? this.portraitWidth,
      ratio: ratio ?? this.ratio,
    );
  }
}

extension CopyMobileSizeAdapter on MobileSizeAdapter {
  MobileSizeAdapter copyWith({double? ratio, double? landscapeWidth}) {
    return MobileSizeAdapter(
      ratio: ratio ?? this.ratio,
      landscapeWidth: landscapeWidth ?? this.landscapeWidth,
    );
  }
}
