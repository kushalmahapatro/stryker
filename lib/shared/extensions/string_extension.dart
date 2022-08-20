import 'package:stryker/stryker.dart';

extension StringExtension on String {
  Widget button(BuildContext context,
      {@required void Function()? onTap,
      Color? color,
      double? size,
      double? radius}) {
    return SizedBox(
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(radius ?? 0),
        color: color ?? context.colors.primary,
        elevation: 3,
        shadowColor: context.colors.surface,
        child: TextButton(
          onPressed: onTap,
          child: Text(
            toUpperCase(),
            style: context.textTheme.bodyText1!.copyWith(
                color: context.colors.background, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget buttonStyle(BuildContext context) {
    return Text(
      toUpperCase(),
      style: context.textTheme.bodyText1!.copyWith(
          color: context.colors.background, fontWeight: FontWeight.bold),
    );
  }

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(this),
      ),
    );
  }

  Widget assetImage(
      {double? width, double? height, BoxFit? fit, Color? color}) {
    return Image.asset(
      this,
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }
}
