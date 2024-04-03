import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_profile_entity.dart';
import 'package:my_sutra/features/presentation/common/profile/change_data_page.dart';
import 'package:my_sutra/features/presentation/common/profile/cubit/profile_cubit.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfileEntity? user;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProfileCubit>().getProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyF3,
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            user = state.data;
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              CircleAvatar(
                radius: 50,
                foregroundImage:
                    NetworkImage(user?.profilePic ?? Constants.tempNetworkUrl),
              ),
              const SizedBox(height: 16),
              Text(
                user?.name ?? '',
                style: theme.publicSansFonts.mediumStyle(fontSize: 25),
              ),
              const SizedBox(height: 24),
              cardItem(context, true),
              cardItem(context, false),
            ],
          );
        },
      ),
    );
  }

  Container cardItem(BuildContext context, bool isMobile) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              isMobile ? Icons.phone : Icons.email_outlined,
              color: Colors.grey.shade500,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isMobile ? 'Mobile Number' : 'Email Address',
                  style: theme.publicSansFonts
                      .mediumStyle(fontSize: 14, fontColor: AppColors.grey92),
                ),
                Text(
                  isMobile
                      ? user?.phoneNumber.toString() ?? ''
                      : user?.email.toString() ?? '',
                  style: theme.publicSansFonts.semiBoldStyle(fontSize: 16),
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              AiloitteNavigation.intentWithData(context,
                  AppRoutes.changeDataRoute, UpdateProfileParams(!isMobile));
            },
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }
}
