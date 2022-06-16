import 'package:flutter/material.dart';
import 'package:madeit/composition/profile/widget/menu.dart';

class MenuInkWell extends StatelessWidget {
  final double cornerRaidus;
  final bool isFirst;
  final bool isLast;
  final Widget child;

  const MenuInkWell({
    Key? key,
    required this.cornerRaidus,
    this.isFirst = false,
    this.isLast = false,
    required this.child,
  }) : super(key: key);

  BorderRadius getBorderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(isFirst ? cornerRaidus : 0.0),
      topRight: Radius.circular(isFirst ? cornerRaidus : 0.0),
      bottomLeft: Radius.circular(
        isLast ? cornerRaidus : 0.0,
      ),
      bottomRight: Radius.circular(
        isLast ? cornerRaidus : 0.0,
      ),
    );
  }

  void Function()? getOnTap() {
    final item = child;

    if (item is ProfileMenu) {
      return item.onTap;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: getOnTap(),
      borderRadius: getBorderRadius(),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: getBorderRadius(),
        ),
        child: child,
      ),
    );
  }
}
