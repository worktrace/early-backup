import 'adapt_size_data.dart';

SizeAdapter get initAdapter => const DesktopSizeAdapter();

Future<SizeAdapter> get adaptPlatformSize async => const DesktopSizeAdapter();
