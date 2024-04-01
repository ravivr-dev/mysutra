import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_app_bar.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/presentation/pages/common/leaderboard/widgets/top_three_widget.dart';
import 'package:my_sutra/injection_container.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  final firstThreeUsers = [
    'user1',
    'user2',
    'user3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Leaderboard',
        centerTitle: true,
      ),
      body: ListView(
        children: [
          if (sl<LocalDataSource>().getUserRole() == "COACH")
            buildTopDropdown(context)
          else
            Container(
              color: AppColors.greyF3,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Logged-in Students :",
                    style: theme.publicSansFonts.mediumStyle(
                        fontSize: 14,
                        fontColor: AppColors.black21.withOpacity(0.5)),
                  ),
                  Text(
                    "108",
                    style: theme.publicSansFonts.mediumStyle(
                        fontSize: 18, fontColor: AppColors.black21),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Card(
              surfaceTintColor: AppColors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (firstThreeUsers.length > 1)
                    const TopThree.second(
                      userName: 'Eiden',
                      description: 'Elite Pathway Pioneer',
                      points: 2345,
                    ),
                  const TopThree.first(
                    userName: 'Jackson',
                    description: 'Grandmaster Gauntlet',
                    points: 4569834,
                  ),
                  if (firstThreeUsers.length > 2)
                    const TopThree.third(
                      userName: 'Emma Aria',
                      description: 'Elite Explorer Apprentice',
                      points: 465,
                    ),
                ],
              ),
            ),
          ),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(
                    width: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 4}',
                          style:
                              theme.publicSansFonts.semiBoldStyle(fontSize: 15),
                        ),
                        const CircleAvatar(
                          foregroundImage:
                              NetworkImage(Constants.tempNetworkUrl),
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    'Bessie Cooper',
                    style: theme.publicSansFonts.mediumStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    'Mastery Marathon',
                    style: theme.publicSansFonts.regularStyle(
                        fontSize: 15, fontColor: AppColors.grey92),
                  ),
                  trailing: Text(
                    '5678',
                    style: theme.publicSansFonts.semiBoldStyle(fontSize: 17),
                  ),
                );
              },
              separatorBuilder: (_, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: 20)
        ],
      ),
    );
  }
}

Widget buildTopDropdown(BuildContext context) {
  List<String> list = <String>['test1', 'test2', 'test3', 'test4'];
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Skill'),
          const SizedBox(
            height: 10,
          ),
          DropdownMenu(
            width: context.screenWidth / 2 - 12,
            inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)))),
            trailingIcon: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.keyboard_arrow_down_outlined)),
            dropdownMenuEntries:
                list.map((e) => DropdownMenuEntry(value: e, label: e)).toList(),
            onSelected: (_) {},
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Center'),
          const SizedBox(
            height: 10,
          ),
          DropdownMenu(
            width: context.screenWidth / 2 - 12,
            inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)))),
            trailingIcon: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.keyboard_arrow_down_outlined)),
            dropdownMenuEntries:
                list.map((e) => DropdownMenuEntry(value: e, label: e)).toList(),
          ),
        ],
      )
      // CustomDropDown(),
    ],
  );
}
