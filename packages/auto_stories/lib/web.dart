// see https://dart.dev/interop/js-interop/package-web#conditional-imports
export 'src/web/route.dart'
    if (dart.library.io) 'src/web/route_io.dart'
    if (dart.library.js_interop) 'src/web/route_web.dart';
