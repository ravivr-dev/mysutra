import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/generated/assets.dart';

class TopThree extends StatelessWidget {
  const TopThree.first({
    required this.userName,
    required this.description,
    required this.points,
    super.key,
  })  : radius = 50,
        position = 1;

  const TopThree.second({
    required this.userName,
    required this.description,
    required this.points,
    super.key,
  })  : radius = 40,
        position = 2;

  const TopThree.third({
    required this.userName,
    required this.description,
    required this.points,
    super.key,
  })  : radius = 40,
        position = 3;

  final double radius;
  final int position;
  final String userName;
  final String description;
  final int points;

  Color get posColor => position == 1
      ? AppColors.colorFF9F12
      : position == 2
          ? AppColors.greyD9
          : AppColors.color56CA7E;

  Size get imageSize => position == 1 ? const Size(50, 33) : const Size(40, 40);

  double get baseline => position == 1 ? 140 : 210;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (context.screenWidth - 60) / 3,
      child: Baseline(
        baselineType: TextBaseline.alphabetic,
        baseline: baseline,
        child: Container(
          decoration: BoxDecoration(
            gradient: (position == 1)
                ? LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.colorFF9F12.withOpacity(0.05),
                      Colors.white,
                    ],
                  )
                : null,
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (position == 1) component.assetImage(path: Assets.iconsCrown),
              const SizedBox(height: 5),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: CircleAvatar(
                      radius: radius,
                      backgroundColor: posColor,
                      child: CircleAvatar(
                        radius: radius - 3,
                        backgroundImage:
                            const NetworkImage(Constants.tempNetworkUrl),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: (position == 1) ? 45 : 35,
                    child: Transform.rotate(
                      angle: 0.8,
                      child: Container(
                        height: 17,
                        width: 17,
                        padding: const EdgeInsets.only(left: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color:
                                (position == 2) ? AppColors.black39 : posColor),
                        child: Transform.rotate(
                            angle: -0.8,
                            child: Text(
                              position.toString(),
                              style: theme.publicSansFonts.semiBoldStyle(
                                  fontSize: 10, fontColor: AppColors.white),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                userName,
                style: theme.publicSansFonts.mediumStyle(),
              ),
              position == 1
                  ? const SizedBox(
                      height: 16,
                    )
                  : const SizedBox(
                      height: 5,
                    ),
              Text(
                '$points',
                style: theme.publicSansFonts
                    .mediumStyle(fontSize: 18, fontColor: posColor),
              ),
              position == 1
                  ? const SizedBox(
                      height: 14,
                    )
                  : const SizedBox(
                      height: 5,
                    ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: theme.publicSansFonts
                    .regularStyle(fontSize: 12, fontColor: AppColors.grey92),
              )
            ],
          ),
        ),
      ),
    );
  }
}
