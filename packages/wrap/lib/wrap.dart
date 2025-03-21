/// Chain-style encapsulations to simplify Flutter widget coding.
///
/// Those encapsulations in this library are designed to be chain-style,
/// which means that you can use them in a chain, such as:
///
/// ```dart
/// Text('message')
///     .asText()
///     .center()
///     .textDirection(TextDirection.ltr)
///     .mediaAsView(context);
/// ```
///
/// Rather than:
///
/// ```dart
/// MediaQuery(
///   data: MediaQueryData.fromView(View.of(context)),
///   child: Directionality(
///     textDirection: TextDirection.ltr,
///     child: Center(
///       child: Text('message'),
///     ),
///   ),
/// );
/// ```
///
/// Such encapsulation will make the code more readable and maintainable,
/// and here are tips:
///
/// 1. You can easily comment out a single line to cancel a single layer.
/// 2. You can easily move a single line up and down to modify the layers.
/// 3. You can think from inside to outside, from exactly what is required.
///
/// # About Performance
///
/// Such encapsulation will definitely decrease the performance
/// because of the extra layers of functions.
/// But it's worth in most cases because of its readability and maintainability.
/// And thanks to the compiler optimization, it's not a problem in most cases.
/// However, it's not recommended to use such encapsulations
/// in performance sensitive cases such as long loops.
library;

export 'src/wrap/decorate.dart';
export 'src/wrap/environment.dart';
export 'src/wrap/geometry.dart';
export 'src/wrap/interact.dart';
export 'src/wrap/paint.dart';
export 'src/wrap/style.dart';
