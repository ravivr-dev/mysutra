import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/generated/assets.dart';

class CustomNavBar extends StatefulWidget {
  final Function(int) onChnageScreen;
  final int currentIndex;
  const CustomNavBar({
    super.key,
    required this.onChnageScreen,
    required this.currentIndex,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar>
    with TickerProviderStateMixin {
  late AnimationController idleAnimation;
  late AnimationController onSelectedAnimation;

  Duration animationDuration = const Duration(milliseconds: 700);

  // int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    idleAnimation = AnimationController(vsync: this);
    onSelectedAnimation =
        AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    super.dispose();
    idleAnimation.dispose();
    onSelectedAnimation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 10,
        )
      ]),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.black33,
        unselectedItemColor: Colors.grey[600],
        currentIndex: widget.currentIndex,
        onTap: (index) {
          onSelectedAnimation.reset();
          onSelectedAnimation.forward();

          if (widget.currentIndex != index) {
            widget.onChnageScreen(index);
          }

          // setState(() {
          //   _selectIndex = index;
          // });
        },
        items: [
          _navItem(itemIndx: 0, icon: Assets.animProfile, title: "My profile"),
          _navItem(itemIndx: 1, icon: Assets.animHome, title: "Home"),
          _navItem(itemIndx: 2, icon: Assets.animBatches, title: "My Batches"),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navItem(
      {required int itemIndx, required String icon, required String title}) {
    return BottomNavigationBarItem(
      icon: Stack(children: [
        Lottie.asset(icon,
            height: 20,
            controller: widget.currentIndex == itemIndx
                ? onSelectedAnimation
                : idleAnimation),
        if (widget.currentIndex != itemIndx)
          Container(
            height: 20,
            width: 20,
            color: Colors.white.withOpacity(0.4),
          )
      ]),
      label: title,
    );
  }
}
