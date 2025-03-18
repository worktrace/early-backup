import 'package:flutter_web_plugins/flutter_web_plugins.dart' as web;

/// Configure Flutter to use the path instead `#` parameters.
///
/// This function is an encapsulation over the raw [web.usePathUrlStrategy]
/// which cannot be called on native platform.
/// There is an empty function with the same name for conditional import.
///
/// see: https://docs.flutter.dev/ui/navigation/url-strategies
void usePathUrlStrategy() => web.usePathUrlStrategy();
