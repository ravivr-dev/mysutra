import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/generated/assets.dart';

class SelectCenterBottomSheet extends StatelessWidget {
  final Function(CenterItem) callback;

  const SelectCenterBottomSheet({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    List<CenterItem> centersList = [
      CenterItem(name: "Playhard Academy", address: 'Sector 12, noida'),
      CenterItem(
          name: "Shivalik Academy",
          address: 'Sector 14, central hoptown, dehradun'),
      CenterItem(name: "Naval Academy", address: 'Parade ground, dehradun'),
      CenterItem(name: "Doon Defence Academy", address: 'Sector 108, dehradun'),
    ];

    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      decoration: const BoxDecoration(
        color: AppColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select a center",
            style: theme.publicSansFonts.semiBoldStyle(fontSize: 24),
          ),
          const SizedBox(height: 24),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: ListView.separated(
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        callback(centersList[index]);
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  centersList[index].name,
                                  style: theme.publicSansFonts
                                      .semiBoldStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: AppColors.grey92,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      centersList[index].address,
                                      style: theme.publicSansFonts.regularStyle(
                                          fontSize: 14,
                                          fontColor: AppColors.black49),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          component.assetImage(path: Assets.iconsArrowForward)
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      child: Divider(
                        color: AppColors.greyD9.withOpacity(0.5),
                      ),
                    );
                  },
                  itemCount: centersList.length),
            ),
          )
        ],
      ),
    );
  }
}

class CenterItem {
  final String name;
  final String address;

  CenterItem({required this.name, required this.address});
}
