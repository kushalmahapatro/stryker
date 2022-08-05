import 'package:stryker/stryker.dart';

extension StringExtension on String {
  Widget button(BuildContext context,
      {@required void Function()? onTap, Color? color, double? size}) {
    return SizedBox(
      child: Material(
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

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(this),
      ),
    );
  }
}