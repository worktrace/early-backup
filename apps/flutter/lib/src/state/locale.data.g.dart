// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartAnnotationsBuilder
// **************************************************************************

part of 'locale.dart';

extension CopyLocale on Locale {
  Locale copyWith({
    String? name,
    LocaleID? id,
    TextDirection? direction,
    String? loading,
    String? worktrace,
  }) {
    return Locale(
      name: name ?? this.name,
      id: id ?? this.id,
      direction: direction ?? this.direction,
      loading: loading ?? this.loading,
      worktrace: worktrace ?? this.worktrace,
    );
  }
}
