# DRAWABLE

<p align="center">
  <a href="https://pub.dev/packages/drawable"><img src="https://img.shields.io/pub/v/drawable.svg" alt="pub.dev"></a>
  <a href="https://github.com/ueman/drawable/actions?query=workflow%3Abuild"><img src="https://github.com/ueman/drawable/workflows/build/badge.svg?branch=main" alt="GitHub Workflow Status"></a>
  <a href="https://codecov.io/gh/ueman/drawable"><img src="https://codecov.io/gh/ueman/drawable/branch/main/graph/badge.svg" alt="code coverage"></a>
  <a href="https://github.com/ueman#sponsor-me"><img src="https://img.shields.io/github/sponsors/ueman" alt="Sponsoring"></a>
  <a href="https://pub.dev/packages/drawable/score"><img src="https://badges.bar/drawable/likes" alt="likes"></a>
  <a href="https://pub.dev/packages/drawable/score"><img src="https://badges.bar/drawable/popularity" alt="popularity"></a>
  <a href="https://pub.dev/packages/drawable/score"><img src="https://badges.bar/drawable/pub%20points" alt="pub points"></a>
</p>

---

A Flutter plugin to share images between Flutter and Android.
For iOS please use [ios_platform_images](https://pub.dev/packages/ios_platform_images).

## Usage

```dart
import 'package:drawable/drawable.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Image(image: DrawableImage("flutter")),
      ),
    ),
  );
}
```

If you want to do something different with the drawables you 
receive them directly like this:

```dart
import 'package:drawable/drawable.dart';

Future<void> main() async {
    const androidDrawable = AndroidDrawable();
    final drawable = await androidDrawable.loadBitmap('drawable_id');
} 
```

## Supported drawables

| Drawable type | Supported | Additional notes     |
|---------------|:---------:|----------------------|
| [AdaptiveIconDrawable](https://developer.android.com/reference/android/graphics/drawable/AdaptiveIconDrawable) | ✅ | |
| [BitmapDrawable](https://developer.android.com/guide/topics/resources/drawable-resource#Bitmap)               | ✅ | |
| [ColorDrawable](https://developer.android.com/reference/android/graphics/drawable/ColorDrawable) | ✅ | |
| [VectorDrawable](https://developer.android.com/reference/android/graphics/drawable/VectorDrawable) | ✅ | Because of limitations of Android, this is not a vector on the Flutter side. |

The following drawable are supported as Bitmap Drawables.
Please note, that all of these drawable are currently converted to a bitmap.
More sophisticated support is planned, but currently not available.

| Drawable type |
|---------------|
| [ColorStateListDrawable](https://developer.android.com/reference/android/graphics/drawable/ColorStateListDrawable) |
| [GradientDrawable](https://developer.android.com/reference/android/graphics/drawable/GradientDrawable) | 
| [LayerDrawable](https://developer.android.com/reference/android/graphics/drawable/LayerDrawable) | 
| [LevelListDrawable](https://developer.android.com/reference/android/graphics/drawable/LevelListDrawable) |
| [PictureDrawable](https://developer.android.com/reference/android/graphics/drawable/PictureDrawable) |
| [ShapeDrawable](https://developer.android.com/reference/android/graphics/drawable/ShapeDrawable) | 
| [StateListDrawable](https://developer.android.com/reference/android/graphics/drawable/StateListDrawable) |
| [TransitionDrawable](https://developer.android.com/reference/android/graphics/drawable/TransitionDrawable) |


List of currently unsupported drawables:

- [AnimatedImageDrawable](https://developer.android.com/reference/android/graphics/drawable/AnimatedImageDrawable)
- [AnimatedStateListDrawable](https://developer.android.com/reference/android/graphics/drawable/AnimatedStateListDrawable)
- [AnimatedVectorDrawable](https://developer.android.com/reference/android/graphics/drawable/AnimatedVectorDrawable)
- [AnimationDrawable](https://developer.android.com/reference/android/graphics/drawable/AnimationDrawable)
- [ClipDrawable](https://developer.android.com/reference/android/graphics/drawable/ClipDrawable)
- [InsetDrawable](https://developer.android.com/reference/android/graphics/drawable/InsetDrawable)
- [NinePatchDrawable](https://developer.android.com/reference/android/graphics/drawable/NinePatchDrawable)
- [PaintDrawable](https://developer.android.com/reference/android/graphics/drawable/PaintDrawable)
- [RippleDrawable](https://developer.android.com/reference/android/graphics/drawable/RippleDrawable)
- [RotateDrawable](https://developer.android.com/reference/android/graphics/drawable/RotateDrawable)
- [ScaleDrawable](https://developer.android.com/reference/android/graphics/drawable/ScaleDrawable)

## 📣  Author

- Jonas Uekötter [GitHub](https://github.com/ueman) [Twitter](https://twitter.com/ue_man)

## Sponsoring

I'm working on my packages on my spare time, but I don't have as much time as I would like.
If this package or any other package I maintain is helping you, please consider to [sponsor](https://github.com/ueman#sponsor-me) me.
By doing so, I will prioritize your issues or your pull-requests before the others.