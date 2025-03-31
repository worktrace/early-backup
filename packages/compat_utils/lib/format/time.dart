extension FormatDateTime on DateTime {
  String get formatDate {
    final m = month.pad2;
    final d = day.pad2;
    return '$year.$m.$d(${weekday == 7 ? 0 : weekday})';
  }

  String get formatTime {
    final h = hour.pad2;
    final m = minute.pad2;
    final s = second.pad2;
    return '$h:$m:$s';
  }

  String get formatTimezone {
    if (isUtc) return 'utc';
    final offset = timeZoneOffset;
    final sign = offset.isNegative ? '-' : '+';
    final h = offset.inHours.abs().pad2;
    final m = (offset.inMinutes.abs() % Duration.minutesPerHour).pad2;
    return '$sign$h:$m';
  }
}

extension PadNumber on int {
  String get pad2 => toString().padLeft(2, '0');
  String get pad3 => toString().padLeft(3, '0');
}
