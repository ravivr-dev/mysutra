import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ailoitte_component_injector.dart';
import '../../features/domain/usecases/patient_usecases/follow_doctor_usecase.dart';
import '../../features/presentation/patient/search/cubit/search_doctor_cubit.dart';
import '../../injection_container.dart';
import '../utils/app_colors.dart';

class FollowButton extends StatefulWidget {
  final String followingUserId;
  final bool isFollowing;
  final void Function(bool)? onFollowingChanged;

  const FollowButton({
    super.key,
    required this.followingUserId,
    required this.isFollowing,
    required this.onFollowingChanged,
  });

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late bool _isFollowing = widget.isFollowing;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SearchDoctorCubit>(),
      child: BlocConsumer<SearchDoctorCubit, SearchDoctorState>(
        listener: (context, state) {
          ///we have to add this condition (state.doctorId == widget.doctorEntity.id) because we can add this in ListView
          if (state is FollowDoctorSuccessState &&
              state.doctorId == widget.followingUserId) {
            widget.onFollowingChanged?.call(!_isFollowing);
            _isFollowing = !_isFollowing;
          }
        },
        buildWhen: (prevState, newState) =>
            newState is FollowDoctorSuccessState &&
            newState.doctorId == widget.followingUserId,
        builder: (context, state) {
          return InkWell(
            onTap: () {
              context.read<SearchDoctorCubit>().followDoctor(
                    params:
                        FollowDoctorParams(doctorId: widget.followingUserId),
                  );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.color0xFFF5F5F5,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isFollowing ? Icons.check : Icons.add,
                    color: _isFollowing
                        ? AppColors.color0xFF15C0B6
                        : AppColors.color0xFF8338EC,
                    size: 18,
                  ),
                  component.spacer(width: 4),
                  component.text(
                    _isFollowing ? 'Following' : 'Follow',
                    style: theme.publicSansFonts.regularStyle(
                      fontColor: _isFollowing
                          ? AppColors.color0xFF15C0B6
                          : AppColors.color0xFF8338EC,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
