import 'dart:ui';

import 'package:drawable/src/drawables/drawable.dart';

class ColorDrawable with Drawable {
  ColorDrawable(this.color);
  final Color color;
}
