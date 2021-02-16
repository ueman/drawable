import 'dart:typed_data';

import 'package:drawable/src/drawables/drawable.dart';

/// See also:
/// - [AdaptiveIcon Guidelines](https://developer.android.com/guide/practices/ui_guidelines/icon_design_adaptive)
/// - [AdaptiveIconDrawable](https://developer.android.com/reference/android/graphics/drawable/AdaptiveIconDrawable)
class AdaptiveIconDrawable with Drawable {
  AdaptiveIconDrawable(this.foreground, this.background);
  final Uint8List foreground;
  final Uint8List background;
}
