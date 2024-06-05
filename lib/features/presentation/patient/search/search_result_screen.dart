import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/search_with_filter_widget.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/search_doctor_usecase.dart';
import 'package:my_sutra/features/presentation/patient/search/cubit/search_doctor_cubit.dart';
import 'package:my_sutra/features/presentation/patient/search_filter_screen.dart';
import 'package:my_sutra/routes/routes_constants.dart';

import '../../../../generated/assets.dart';
import '../../../domain/usecases/user_usecases/follow_user_usecase.dart';

class SearchResultScreen extends StatefulWidget {
  final SearchResultArgs? args;

  const SearchResultScreen({super.key, required this.args});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final TextEditingController _searchController = TextEditingController();
  late SearchFilterArgs? _doctorFilterDetails = widget.args?.filter;

  @override
  void didChangeDependencies() {
    _callSearchDoctorApi(
        reviews: _doctorFilterDetails?.reviews,
        experience: _doctorFilterDetails?.experience,
        specializationId: _doctorFilterDetails?.specializationId);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<DoctorEntity> doctorsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          title: component.text(context.stringForKey(StringKeys.searchResult),
              style: theme.publicSansFonts.mediumStyle(fontSize: 20))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocConsumer<SearchDoctorCubit, SearchDoctorState>(
          listener: (context, state) {
            if (state is SearchDoctorError) {
              _showToast(message: state.error);
            } else if (state is SearchDoctorLoaded) {
              doctorsList = state.data;
            } else if (state is FollowDoctorSuccessState) {
              doctorsList[state.followedDoctorIndex!].reInitIsFollowing();
              setState(() {});
            } else if (state is GetDoctorDetailsErrorState) {
              _showToast(message: state.message);
            } else if (state is GetDoctorDetailsSuccessState) {
              _searchController.clear();
              _navigateToDoctorDetailScreen(state.doctorEntity);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                SearchWithFilter(
                  controller: _searchController,
                  filter: _doctorFilterDetails,
                  onTapFilter: (data) {
                    _initFilterData(data);
                    _callSearchDoctorApi(
                      specializationId: data.specializationId,
                      reviews: data.reviews,
                      experience: data.experience,
                    );
                  },
                  hintText: 'Search for doctors',
                  backgroundColor: AppColors.white,
                  onChanged: (value) {
                    _callSearchDoctorApi(search: value);
                  },
                ),
                component.spacer(height: 30),
                if (doctorsList.isEmpty)
                  component.text('No Data Found',
                      style: theme.publicSansFonts.mediumStyle(
                          fontColor: AppColors.grey92, fontSize: 20))
                else
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

  void _initFilterData(SearchFilterArgs args) {
    setState(() {
      _doctorFilterDetails = args;
    });
  }

  Widget _buildCard(DoctorEntity data, int index) {
    final isFollowed = data.isFollowing == true;

    return InkWell(
      onTap: () {
        if (data.id == null) {
          _showToast(
              message: 'Facing issue with doctor please choose another one');
          return;
        }
        _getDoctorDetails(data.id!);
      },
      child: Container(
        decoration: AppDeco.cardDecoration,
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: component.text(
                          data.fullName?.capitalizeFirstLetter,
                          style: theme.publicSansFonts.mediumStyle(
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (data.isVerified != null) ...[
                        component.spacer(width: 4),
                        component.assetImage(
                            height: 14, width: 14, path: Assets.iconsVerify),
                      ]
                    ],
                  ),
                  component.text(
                      '${data.specialization}'.capitalizeFirstLetterOfEveryWord,
                      style: theme.publicSansFonts.regularStyle(
                        fontSize: 14,
                        fontColor: AppColors.black81,
                      )),
                  component.spacer(height: 4),
                  Row(
                    children: [
                      if (data.ratings != null) ...[
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: AppColors.color0xFFFEFFD1,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, color: AppColors.star),
                              component.text(
                                  data.ratings?.ceilToDouble().toString(),
                                  style: theme.publicSansFonts.regularStyle())
                            ],
                          ),
                        ),
                        component.spacer(width: 8),
                      ],
                      if ((data.reviews ?? 0) > 0)
                        component.text(
                          '(${data.reviews} reviews)',
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
                          params: FollowUserParams(userId: data.id!),
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
            component.spacer(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: component.networkImage(
                url: data.profilePic ?? '',
                fit: BoxFit.fill,
                width: 70,
                height: 70,
                errorWidget:
                    component.assetImage(path: Assets.imagesDefaultAvatar),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _callSearchDoctorApi(
      {String? search,
      int? reviews,
      int? experience,
      String? specializationId}) {
    context.read<SearchDoctorCubit>().getData(SearchDoctorParams(
          search: search,
          reviews: reviews,
          experience: experience,
          specializationId: specializationId,
          start: 1,
          limit: 100,
        ));
  }

  void _getDoctorDetails(String doctorId) {
    context.read<SearchDoctorCubit>().getDoctorDetails(doctorId: doctorId);
  }

  void _showToast({required String message}) {
    widget.showErrorToast(context: context, message: message);
  }

  void _navigateToDoctorDetailScreen(DoctorEntity entity) {
    AiloitteNavigation.intentWithData(context, AppRoutes.doctorDetail, entity)
        .then((_) => _callSearchDoctorApi(
            reviews: _doctorFilterDetails?.reviews,
            experience: _doctorFilterDetails?.experience,
            specializationId: _doctorFilterDetails?.specializationId));
    // Navigator.pushNamed(context, AppRoutes.doctorDetail, arguments: entity)
    //     .then((value) => setState(() {}));
  }
}

class SearchResultArgs {
  final SearchFilterArgs? filter;

  SearchResultArgs({this.filter});
}
