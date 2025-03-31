import 'package:auto_stories/utils.dart';
import 'package:auto_stories/web.dart';
import 'package:flutter/widgets.dart';

void autoStoriesRoot() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(const AutoStoriesRoot());
}

class AutoStoriesRoot extends StatelessWidget {
  const AutoStoriesRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return 'auto stories'.asText().center();
  }
}
