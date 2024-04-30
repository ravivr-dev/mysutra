import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/features/presentation/common/registration/cubit/registration_cubit.dart';

import '../../ailoitte_component_injector.dart';
import '../utils/app_colors.dart';

class UserNameTextField extends StatefulWidget {
  final TextEditingController userNameController;

  const UserNameTextField({super.key, required this.userNameController});

  @override
  State<UserNameTextField> createState() => _UserNameTextFieldState();
}

class _UserNameTextFieldState extends State<UserNameTextField> {
  bool _isUserNameAvailable = false;
  String? _selectedUserName;
  List<String> _userNames = [];
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(_onFocusNodeChanges);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(() {});
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationCubit, RegistrationState>(
      listener: (_, state) {
        if (state is GenerateUserNamesSuccessState) {
          _isUserNameAvailable = state.entity.userNameAvailable;
          _userNames = state.entity.userNames;
        } else if (state is GenerateUserNamesErrorState) {
          _isUserNameAvailable = false;
          widget.showErrorToast(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            component.textField(
              validator: (value) => value!.isEmpty
                  ? 'Please Enter UserName'
                  : value.contains(' ')
                      ? 'Can\'t add space in username'
                      : !_isUserNameAvailable && _selectedUserName == null
                          ? 'UserName is not Available'
                          : null,
              focusNode: _focusNode,
              fillColor: AppColors.white,
              contentPadding:
                  const EdgeInsets.only(top: 25, bottom: 25, left: 33),
              borderRadius: 90,
              filled: true,
              focusedBorderColor: AppColors.color0xFFDADCE0,
              borderColor: AppColors.color0xFFDADCE0,
              controller: widget.userNameController,
            ),
            component.spacer(height: 10),
            if (!_isUserNameAvailable)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _userNames.map((e) => _buildUserName(e)).toList(),
              ),
          ],
        );
      },
    );
  }

  void _onFocusNodeChanges() {
    if (!_focusNode.hasFocus && widget.userNameController.text.isNotEmpty) {
      _callUserNameApi();
    }
  }

  Widget _buildUserName(String userName) {
    final isSelected = _selectedUserName == userName;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedUserName = userName;
          widget.userNameController.text = userName;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            color:
                isSelected ? AppColors.primaryColor : AppColors.color0xFFFCFCFD,
            borderRadius: BorderRadius.circular(44),
            border: Border.all(color: AppColors.color0xFFDBDBDB)),
        child: component.text(userName,
            style: theme.publicSansFonts.mediumStyle(
                fontSize: 16,
                fontColor:
                    isSelected ? AppColors.white : AppColors.color0xFF85799E)),
      ),
    );
  }

  void _callUserNameApi() {
    context
        .read<RegistrationCubit>()
        .generateUsernames(userName: widget.userNameController.text);
  }
}
