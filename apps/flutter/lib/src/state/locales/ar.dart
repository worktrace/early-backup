import 'package:auto_stories/helpers.dart';
import 'package:flutter/widgets.dart';
import 'package:worktrace/state.dart';

class ArLocale extends EnLocale {
  const ArLocale({
    super.name = 'العربية',
    super.id = const LocaleID('ar'),
    super.direction = TextDirection.rtl,
    // Machine translated, might not be accurate. Only for debug propose of ltr.
    super.loading = 'تحميل',
    super.worktrace = 'تتبع العمل',
  });
}

const arEG = ArLocale(
  name: 'العربية (مصر)', // Machine translated, might not be accurate.
  id: LocaleID('ar', areaCode: 'eg'),
);
