import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/search_with_filter_widget.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/search_doctor_usecase.dart';
import 'package:my_sutra/features/presentation/patient/search/cubit/search_doctor_cubit.dart';
import '../../../domain/usecases/patient_usecases/follow_doctor_usecase.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void didChangeDependencies() {
    context.read<SearchDoctorCubit>().getData(SearchDoctorParams());
    super.didChangeDependencies();
  }

  List<DoctorEntity> doctorsList = [];

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
        child: BlocConsumer<SearchDoctorCubit, SearchDoctorState>(
          listener: (context, state) {
            if (state is SearchDoctorError) {
              widget.showErrorToast(context: context, message: state.error);
            } else if (state is SearchDoctorLoaded) {
              doctorsList = state.data;
            } else if (state is FollowDoctorSuccessState) {
              doctorsList[state.followedDoctorIndex].reInitIsFollowing();

              setState(() {});
            }
          },
          builder: (context, state) {
            return Column(
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
                    itemCount: doctorsList.length,
                    separatorBuilder: (_, __) => component.spacer(height: 12),
                    itemBuilder: (_, index) {
                      return _buildCard(doctorsList[index], index);
                    })
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard(DoctorEntity data, int index) {
    final isFollowed = data.isFollowing == true;

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
                component.text(data.fullName,
                    style: theme.publicSansFonts.mediumStyle(
                      fontSize: 16,
                    )),
                component.text(data.specialization,
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
                          component.text(data.ratings.toString(),
                              style: theme.publicSansFonts.regularStyle())
                        ],
                      ),
                    ),
                    component.spacer(width: 8),
                    component.text(
                      '(${data.ratings} reviews)',
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
                  '₹ ${data.fees}',
                  style: theme.publicSansFonts.regularStyle(
                    fontColor: AppColors.color0xFF526371,
                  ),
                ),
                component.spacer(height: 4),
                InkWell(
                  onTap: () {
                    context.read<SearchDoctorCubit>().followDoctor(
                        params: FollowDoctorParams(doctorId: data.id!),
                        followedDoctorIndex: index);
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
                          isFollowed ? Icons.check : Icons.add,
                          color: isFollowed
                              ? AppColors.color0xFF15C0B6
                              : AppColors.color0xFF8338EC,
                          size: 18,
                        ),
                        component.spacer(width: 4),
                        component.text(
                          isFollowed ? 'Following' : 'Follow',
                          style: theme.publicSansFonts.regularStyle(
                            fontColor: isFollowed
                                ? AppColors.color0xFF15C0B6
                                : AppColors.color0xFF8338EC,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                data.profilePic ?? Constants.tempNetworkUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
