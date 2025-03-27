import 'package:flutter/widgets.dart';

import 'adapt_size_data.dart';

Size get initSize => kDesktopWindowSize;

SizeAdapter get initAdapter => const DesktopSizeAdapter();

Future<SizeAdapter> get adaptPlatformSize async => const DesktopSizeAdapter();
