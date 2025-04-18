// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartDataBuilder
// **************************************************************************

part of 'adapt_size_data.dart';

mixin _$Copy$AdaptedSize implements Copyable {
  AdaptedSize get _template => this as AdaptedSize;

  @override
  AdaptedSize copyWith({WindowMode? mode, double? ratio}) => AdaptedSize(
    mode: mode ?? _template.mode,
    ratio: ratio ?? _template.ratio,
  );
}

mixin _$Copy$DesktopSizeAdapter implements Copyable {
  DesktopSizeAdapter get _template => this as DesktopSizeAdapter;

  @override
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

mixin _$Copy$MobileSizeAdapter implements Copyable {
  MobileSizeAdapter get _template => this as MobileSizeAdapter;

  @override
  MobileSizeAdapter copyWith({double? ratio, double? landscapeWidth}) =>
      MobileSizeAdapter(
        ratio: ratio ?? _template.ratio,
        landscapeWidth: landscapeWidth ?? _template.landscapeWidth,
      );
}
