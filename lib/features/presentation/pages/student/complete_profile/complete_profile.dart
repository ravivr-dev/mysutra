import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_app_bar.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/common_widgets/custom_date_picker.dart';
import 'package:my_sutra/core/common_widgets/text_form_field_widget.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/generated/assets.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  DateTime selectedDate = DateTime.now();
  List listOfGenders = ['Male', 'Female', 'Others'];
  final TextEditingController _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Complete Profile',
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(
                      'https://source.unsplash.com/random?profile-picture'),
                ),
                IconButton(
                    onPressed: () {},
                    icon: component.assetImage(path: Assets.iconsEditIcon)),
              ]),
              const SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                title: 'Full Name',
                hintText: 'Full Name',
                hintTextStyle: theme.publicSansFonts.regularStyle(
                  fontSize: 16,
                  fontColor: AppColors.greyD9,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                title: 'Email',
                hintText: 'Email',
                hintTextStyle: theme.publicSansFonts.regularStyle(
                  fontSize: 16,
                  fontColor: AppColors.greyD9,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Gender',
                    style: theme.publicSansFonts.semiBoldStyle(fontSize: 14),
                  )),
              DropdownMenu(
                  width: context.screenWidth - 44,
                  hintText: 'Select Gender',
                  trailingIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                  inputDecorationTheme: const InputDecorationTheme(
                      contentPadding: EdgeInsets.symmetric(horizontal: 25),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.greyD9, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(
                      value: 'Male',
                      label: 'Male',
                    ),
                    DropdownMenuEntry(
                      value: 'Female',
                      label: 'Female',
                    ),
                    DropdownMenuEntry(
                      value: 'Others',
                      label: 'Others',
                    ),
                  ]),
              const SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                controller: _dobController,
                readOnly: true,
                suffixWidget: const Icon(Icons.calendar_today_outlined),
                title: 'Date of Birth',
                hintText: 'Date of Birth',
                hintTextStyle: theme.publicSansFonts
                    .regularStyle(fontSize: 16, fontColor: AppColors.greyD9),
                onTap: () {
                  showCalender((val) {
                    _dobController.text =
                        DateFormat('dd MMMM yyyy').format(val);
                    Navigator.pop(context);
                  });
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: CustomButton(
          text: 'Finish',
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  showCalender(Function(DateTime) callback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
              height: 400,
              width: 400,
              child: CustomDatePicker(
                callback: callback,
              )),
        );
      },
    );
  }
}
