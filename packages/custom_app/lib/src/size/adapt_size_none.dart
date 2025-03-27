import 'package:flutter/widgets.dart';

import 'adapt_size_data.dart';

/// Encapsulate init size to avoid invalid `io` or `js_interop` calls.
Size get initSize => kDesktopWindowSize;

/// Init size adapter once setup.
/// This getter might not accurate enough in some cases.
/// It just works as a placeholder before the async [adaptPlatformSize].
SizeAdapter get initAdapter => const DesktopSizeAdapter();

/// Detect platform size and return adapter according to device info.
/// You may use [initAdapter] before this async getter.
Future<SizeAdapter> get adaptPlatformSize async => const DesktopSizeAdapter();
