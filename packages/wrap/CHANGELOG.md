## 1.0.0

This package is now been included inside the [WorkTrace](https://github.com/worktrace/worktrace) monorepo. And many APIs had changed, that such package is no longer compatible with the older versions of `0.x.x`. It's strongly not recommended to use versions before `1.0.0` because those versions are far not mature enough for production usages.

## 0.7.0

- **Incompatible**: API about ReContext changed.
- Use `builder` instead of `ReContext`, which is conciser.
- Optimize tests and tidy code structure.

## 0.6.0

- Inherit data from widget tree ancestors.
- Wrapper to handle data onto widget tree.
- Replace the old `package:inherit`.
- Apply strict linter options.

## 0.5.2

- Fix bug about calling `setState` when build.

## 0.5.1

- **Deprecated**: still contains bugs.
- Fix bug: get size when build conflict.

## 0.5.0

- **Deprecated**: still contains bugs.
- Widget size change listener.
- Wrap padding (edge insets).
- Text wrapper on string with parameters.

## 0.4.1

- Doc alert value modify cover in the same context.
- Update example code.

## 0.4.0

- Wrap string into text widget.
- Modification about text style in context.
- Optimize file structure and add corresponding tests.

## 0.3.0

- `ReContext` as a conciser way for `Builder`.
- Wrap `ReContext` on widgets.

## 0.2.0

- Wrap `Center`.
- Wrap `Row`, `Column`, and `Stack`, and apply all corresponding parameters.
- Syntax sugar for center row and center column.

## 0.1.0

- Wrap background using `ColoredBox`.
- Wrap decoration using `DecoratedBox`;
- Wrap foreground including icon and text color.

## 0.0.0

- Initial release.
