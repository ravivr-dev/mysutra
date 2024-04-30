// import 'package:ailoitte_components/ailoitte_components.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:my_sutra/ailoitte_component_injector.dart';
// import 'package:my_sutra/core/common_widgets/custom_button.dart';
// import 'package:my_sutra/core/main_cubit/main_cubit.dart';
// import 'package:my_sutra/core/utils/app_colors.dart';
// import 'package:my_sutra/core/utils/constants.dart';
// import 'package:my_sutra/features/presentation/common/home/cubit/home_cubit.dart';
// import 'package:my_sutra/generated/assets.dart';
// import 'package:my_sutra/routes/routes_constants.dart';
//
// enum DrawerSelection { dashboard, studentPerformance, logOut }
//
// class CustomDrawer extends StatefulWidget {
//   const CustomDrawer({super.key});
//
//   @override
//   State<CustomDrawer> createState() => _CustomDrawerState();
// }
//
// class _CustomDrawerState extends State<CustomDrawer> {
//   TextStyle fontStyle = theme.publicSansFonts
//       .mediumStyle(fontSize: 16, fontColor: AppColors.black33);
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Padding(
//         padding: const EdgeInsets.all(22.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             headerWidget(),
//             const SizedBox(height: 25),
//             Text(
//               "OVERVIEW",
//               style: theme.publicSansFonts.mediumStyle(
//                   fontColor: AppColors.blackColor.withOpacity(0.4), height: 14),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 children: [
//                   ListTile(
//                     selectedTileColor: AppColors.white,
//                     hoverColor: AppColors.white,
//                     horizontalTitleGap: 10,
//                     leading: component.assetImage(path: Assets.iconsHome),
//                     title: Text(
//                       'Dashboard',
//                       style: fontStyle,
//                     ),
//                     onTap: () {
//                       AiloitteNavigation.intentWithClearAllRoutes(
//                           context, AppRoutes.homeRoute);
//                     },
//                   ),
//
//                     ListTile(
//                       selectedTileColor: AppColors.white,
//                       hoverColor: AppColors.white,
//                       focusColor: AppColors.white,
//                       horizontalTitleGap: 10,
//                       // leading: component.assetImage(path: Assets.iconsSwitch),
//                       title: Text(
//                         'Switch Academy',
//                         style: fontStyle,
//                       ),
//                       onTap: () {},
//                     ),
//                     ListTile(
//                       selectedTileColor: AppColors.white,
//                       hoverColor: AppColors.white,
//                       focusColor: AppColors.white,
//                       horizontalTitleGap: 10,
//                       // leading: component.assetImage(path: Assets.iconsMessage),
//                       title: Text(
//                         'Write feedback',
//                         style: fontStyle,
//                       ),
//                       onTap: () {},
//                     ),
//                   ]
//
//               ),
//             ),
//             ListTile(
//               selectedTileColor: AppColors.white,
//               hoverColor: AppColors.white,
//               horizontalTitleGap: 10,
//               leading: const Icon(
//                 Icons.logout_outlined,
//                 color: AppColors.grey92,
//                 size: 20,
//               ),
//               title: Text(
//                 'Log Out',
//                 style: fontStyle,
//               ),
//               onTap: () {
//                 logoutDialog();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget headerWidget() {
//     return SafeArea(
//       child: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           HomeCubit cubit = context.read<HomeCubit>();
//           return Row(
//             children: [
//               const CircleAvatar(
//                 radius: 22,
//                 backgroundImage: NetworkImage(
//                      Constants.tempNetworkUrl),
//               ),
//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                      "User Name",
//                     style: theme.publicSansFonts.mediumStyle(
//                         fontSize: 16, fontColor: AppColors.black33, height: 24),
//                   ),
//                   Text(
//                     'My profile',
//                     style: theme.publicSansFonts.mediumStyle(
//                         fontSize: 14,
//                         fontColor: AppColors.black01.withOpacity(0.6),
//                         height: 24),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               IconButton(
//                 icon: component.assetImage(path: Assets.iconsClose),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   logoutDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(20),
//             ),
//           ),
//           iconPadding: const EdgeInsets.only(top: 40, bottom: 25),
//           icon: SizedBox(
//             height: 70,
//             width: 70,
//             child: component.assetImage(
//               path: Assets.imagesLogout,
//               fit: BoxFit.contain,
//             ),
//           ),
//           title: component.text(
//             "Logout",
//             style: theme.publicSansFonts
//                 .semiBoldStyle(fontSize: 36, fontColor: Colors.grey),
//             textAlign: TextAlign.center,
//           ),
//           content: Text(
//             "Are you sure you want to logout ?",
//             style: theme.publicSansFonts
//                 .regularStyle(fontSize: 16, fontColor: Colors.grey),
//             textAlign: TextAlign.center,
//           ),
//           actionsPadding:
//               const EdgeInsets.only(left: 20, right: 20, bottom: 20),
//           actions: [
//             Column(
//               children: [
//                 CustomButton(
//                   text: "Logout",
//                   onPressed: () {
//                     AiloitteNavigation.intentWithClearAllRoutes(
//                         context, AppRoutes.loginRoute);
//                     context.read<MainCubit>().logout();
//                   },
//                 ),
//                 const SizedBox(height: 15),
//                 CustomButton(
//                   text: "Cancel",
//                   buttonColor: Colors.grey.shade200,
//                   textColor: Colors.grey.shade700,
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
