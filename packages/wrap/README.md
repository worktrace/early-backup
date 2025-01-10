# Wrap

Chain style programming syntax sugar utilities for Flutter widgets.

Too many `child` or `children` parameters with their nestings and indents makes Flutter code less readable, so here comes this package. This package provides a chain style programming syntax to make your code clean and tidy, especially with so many single child widgets.

For example:

Before:

```dart
import 'package:flutter/widgets.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromView(View.of(context)),
      child: const Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: Text('Wrap Example Before'),
        ),
      ),
    );
  }
}
```

After:

```dart
import 'package:flutter/widgets.dart';
import 'package:wrap/wrap.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => 'Wrap Example'
      .asText()
      .center()
      .textDirection(TextDirection.ltr)
      .mediaAsView(context);
}
```

Simplify your code is not the only benefit of using such package. The chain-style programming also makes comment to cancel code easier: such as you can simply cancel a line to remove a layer of widget, and when you want to use them again, you can simply cancel the comment to add them back to your code, that you don't need to worry about the indents. For example:

```dart
import 'package:flutter/widgets.dart';
import 'package:wrap/wrap.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => 'Wrap Example'
      .asText()
      // .center()
      .textDirection(TextDirection.ltr)
      .mediaAsView(context);
}
```
