import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

// 1 - class of InputTile
class InputTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final IconData? trailingIcon;
  final VoidCallback onTap;
  final VoidCallback? onPressed;

  const InputTile({
    super.key,
    required this.icon,
    required this.title,
    required this.trailingIcon,
    required this.onTap,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: BlaTextStyles.body,
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: Icon(trailingIcon),
        color: BlaColors.primary,
      ),
      onTap: onTap,
    );
  }
}
