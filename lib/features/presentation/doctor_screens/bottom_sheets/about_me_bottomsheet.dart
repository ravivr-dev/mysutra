import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class AboutMeBottomSheet extends StatefulWidget {
  const AboutMeBottomSheet({super.key});

  @override
  State<AboutMeBottomSheet> createState() => _AboutMeBottomSheetState();
}

class _AboutMeBottomSheetState extends State<AboutMeBottomSheet> {
  late TextEditingController _controller;

  @override
  void initState() {
    ///we were getting controller used after being desposed that's why i'm initilizing it here
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              component.text('About me',
                  style: theme.publicSansFonts.semiBoldStyle(
                    fontSize: 18,
                    fontColor: AppColors.color0xFF1E293B,
                  )),
              InkWell(
                  onTap: () => AiloitteNavigation.back(context),
                  child: const Icon(Icons.close, color: AppColors.black21))
            ],
          ),
          component.spacer(height: 8),
          _buildTextField(),
          component.spacer(height: 20),
          CustomButton(
            text: 'Save',
            height: 70,
            onPressed: () {},
            titleStyle: theme.publicSansFonts.semiBoldStyle(
              fontSize: 20,
              fontColor: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return SizedBox(
      child: component.textField(
        controller: _controller,
        fillColor: AppColors.white,
        maxLines: 8,
        borderRadius: 20,
        filled: true,
        focusedBorderColor: AppColors.primaryColor,
        borderColor: AppColors.color0xFFDADCE0,
      ),
    );
  }
}
