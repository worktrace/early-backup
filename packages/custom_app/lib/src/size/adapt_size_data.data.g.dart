// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: DataBuilder
// **************************************************************************

part of 'adapt_size_data.dart';

mixin _$Copy$AdaptedSize {
  AdaptedSize get _template => this as AdaptedSize;

  AdaptedSize copyWith({WindowMode? mode, double? ratio}) => AdaptedSize(
    mode: mode ?? _template.mode,
    ratio: ratio ?? _template.ratio,
  );
}

mixin _$Copy$DesktopSizeAdapter {
  DesktopSizeAdapter get _template => this as DesktopSizeAdapter;

  DesktopSizeAdapter copyWith({
    double? landscapeWidth,
    double? portraitWidth,
    double? ratio,
  }) => DesktopSizeAdapter(
    landscapeWidth: landscapeWidth ?? _template.landscapeWidth,
    portraitWidth: portraitWidth ?? _template.portraitWidth,
    ratio: ratio ?? _template.ratio,
  );
}

mixin _$Copy$MobileSizeAdapter {
  MobileSizeAdapter get _template => this as MobileSizeAdapter;

  MobileSizeAdapter copyWith({double? ratio, double? landscapeWidth}) =>
      MobileSizeAdapter(
        ratio: ratio ?? _template.ratio,
        landscapeWidth: landscapeWidth ?? _template.landscapeWidth,
      );
}
