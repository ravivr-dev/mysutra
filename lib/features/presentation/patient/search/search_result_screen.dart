import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/search_with_filter_widget.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/generated/assets.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          backgroundColor: AppColors.transparent,
          title: component.text(context.stringForKey(StringKeys.searchResult),
              style: theme.publicSansFonts.mediumStyle(fontSize: 20))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SearchWithFilter(
              onTapFilter: () {},
              hintText: 'Search for doctors',
              backgroundColor: AppColors.white,
            ),
            component.spacer(height: 30),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (_, __) => component.spacer(height: 12),
                itemBuilder: (_, index) {
                  return _buildCard();
                })
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      decoration: AppDeco.cardDecoration,
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                component.text('Dr. Rita Rawat',
                    style: theme.publicSansFonts.mediumStyle(
                      fontSize: 16,
                    )),
                component.text('Oncologist',
                    style: theme.publicSansFonts.regularStyle(
                      fontSize: 14,
                      fontColor: AppColors.black81,
                    )),
                component.spacer(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: AppColors.color0xFFFEFFD1,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: AppColors.star),
                          component.text('4.4',
                              style: theme.publicSansFonts.regularStyle())
                        ],
                      ),
                    ),
                    component.spacer(width: 8),
                    component.text(
                      '(503 reviews)',
                      style: theme.publicSansFonts.regularStyle(
                        fontColor: AppColors.color0xFF8338EC,
                      ),
                    ),
                  ],
                ),
                component.spacer(
                  height: 4,
                ),
                component.text(
                  '₹2000 - ₹5000.0',
                  style: theme.publicSansFonts.regularStyle(
                    fontColor: AppColors.color0xFF526371,
                  ),
                ),
                component.spacer(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.color0xFFF5F5F5,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add, color: AppColors.color0xFF8338EC),
                      component.text(
                        'Follow',
                        style: theme.publicSansFonts.regularStyle(
                          fontColor: AppColors.color0xFF8338EC,
                        ),
                      )
                    ],
                  ),
                )
                // TextButton.icon(
                //     onPressed: () {},
                //     style: TextButton.styleFrom(
                //         fixedSize: const Size(79, 34),
                //         padding: EdgeInsets.zero,
                //         shape: RoundedRectangleBorder(
                //         )),
                //     icon:,
                //     label:)
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: component.assetImage(
              path: Assets.iconsDoctor,
              height: 72,
              width: 72,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
