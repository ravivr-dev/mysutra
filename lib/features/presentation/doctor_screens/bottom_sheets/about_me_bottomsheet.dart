import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/presentation/doctor_screens/setting_screen/bloc/setting_cubit.dart';

class AboutMeBottomSheet extends StatefulWidget {
  const AboutMeBottomSheet({super.key});

  @override
  State<AboutMeBottomSheet> createState() => _AboutMeBottomSheetState();
}

class _AboutMeBottomSheetState extends State<AboutMeBottomSheet> {
  late TextEditingController _aboutMeController;

  @override
  void initState() {
    ///we were getting controller used after being desposed that's why i'm initilizing it here
    _aboutMeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _aboutMeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingCubit, SettingState>(
      listener: (context, state) {
        if (state is UpdateAboutOrFeesSuccessState) {
          _showToast(message: 'Details Updated Successfully');
          _popScreen();
        } else if (state is UpdateAboutOrFeesErrorState) {
          _showToast(message: state.message);
        }
      },
      child: Container(
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
                    onTap: () => _popScreen(),
                    child: const Icon(Icons.close, color: AppColors.black21))
              ],
            ),
            component.spacer(height: 8),
            _buildTextField(),
            component.spacer(height: 20),
            CustomButton(
              text: 'Save',
              height: 70,
              onPressed: () {
                if (_aboutMeController.text.isEmpty) {
                  _showToast(message: 'Please Enter About Me');
                  return;
                }
                _updateAboutMe();
              },
              titleStyle: theme.publicSansFonts.semiBoldStyle(
                fontSize: 20,
                fontColor: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateAboutMe() {
    context
        .read<SettingCubit>()
        .updateAboutOrFees(about: _aboutMeController.text);
  }

  Widget _buildTextField() {
    return SizedBox(
      child: component.textField(
        controller: _aboutMeController,
        fillColor: AppColors.white,
        maxLines: 8,
        borderRadius: 20,
        filled: true,
        focusedBorderColor: AppColors.primaryColor,
        borderColor: AppColors.color0xFFDADCE0,
      ),
    );
  }

  void _popScreen() {
    AiloitteNavigation.back(context);
  }

  void _showToast({required String message}) {
    widget.showErrorToast(context: context, message: message);
  }
}
