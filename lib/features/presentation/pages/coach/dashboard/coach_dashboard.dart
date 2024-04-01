import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/styles_and_decorations.dart';
import 'package:my_sutra/features/presentation/pages/coach/dashboard/cubit/dashboard_cubit.dart';
import 'package:my_sutra/features/presentation/pages/coach/dashboard/widgets/batch_widget.dart';
import 'package:my_sutra/features/presentation/pages/coach/dashboard/widgets/check_in_card_widget.dart';
import 'package:my_sutra/features/presentation/pages/coach/dashboard/widgets/dashboard_helper_items.dart';
import 'package:my_sutra/features/presentation/pages/common/home/cubit/home_cubit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashboardCoach extends StatefulWidget {
  const DashboardCoach({super.key});

  @override
  State<DashboardCoach> createState() => _DashboardCoachState();
}

class _DashboardCoachState extends State<DashboardCoach> {
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 22),
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
          decoration: StylesAndDecorations.generalContainerDecoration(),
          child: const Column(
            children: [
              CheckInCardWidget(),
              SizedBox(height: 28),
              DashboardHelperItems(),
              SizedBox(height: 16),

              /// removed this widget as per clients request
              // RateNowDashboardWidget(),
            ],
          ),
        ),
        BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is MyBatchesLoaded) {}
          },
          builder: (context, state) {
            HomeCubit cubit = context.read<HomeCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    "My Batches",
                    style: theme.publicSansFonts.regularStyle(
                        fontSize: 16, fontColor: AppColors.blackTokens),
                  ),
                ),
                ...List<BatchCard>.generate(
                  cubit.batches.length,
                  (index) => BatchCard(data: cubit.batches[index]),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 35),
      ],
    );
  }

  getCurrentLocation() async {
    bool isPremission = await _handleLocationPermission();

    if (isPremission) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double lat = position.latitude;
      double long = position.longitude;

      String? address = await _getAddressFromLatLng(lat, long);
      // WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      context.read<DashboardCubit>().setLocation(address);
      // });
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        widget.showErrorToast(
            context: context,
            message:
                'Location services are disabled. Please enable the services');
      }
      return false;
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          widget.showErrorToast(
              context: context, message: 'Location permissions are denied');
        }
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        widget.showErrorToast(
            context: context,
            message:
                'Location permissions are permanently denied, we cannot request permissions.');
      }

      return false;
    }
    return true;
  }

  Future<String?> _getAddressFromLatLng(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    return place.subAdministrativeArea;
  }
}
