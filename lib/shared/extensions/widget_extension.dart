import 'package:stryker/stryker.dart';

extension WidgetExtensions on Widget {
  Widget circularBorder(BuildContext context, {Color? color}) {
    return SizedBox(
      width: double.maxFinite,
      height: 50,
      child: Material(
        borderOnForeground: true,
        color: color,
        elevation: 3,
        shadowColor: context.colors.surface,
        borderRadius: BorderRadius.circular(30),
        child: this,
      ),
    );
  }

  Widget circularButton(BuildContext context, {Color? color, double? size}) {
    return SizedBox(
      width: size ?? 30,
      height: size ?? 30,
      child: Material(
        color: color,
        elevation: 3,
        shadowColor: context.colors.surface,
        borderRadius: BorderRadius.circular(size ?? 30),
        child: this,
      ),
    );
  }

  Widget paddingAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget paddingSymmetric({double? horizontal, double? vertical}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontal ?? 0, vertical: vertical ?? 0),
      child: this,
    );
  }
}
