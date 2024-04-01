import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/styles_and_decorations.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/training_program.dart';
import 'package:my_sutra/features/domain/entities/user_entities/academy_center_entity.dart';
import 'package:my_sutra/features/presentation/pages/coach/dashboard/widgets/batch_widget.dart';
import 'package:my_sutra/features/presentation/pages/coach/my_batches/cubit/my_batches_cubit.dart';
import 'package:my_sutra/features/presentation/pages/coach/my_batches/widgets/training_widget.dart';
import 'package:my_sutra/features/presentation/pages/common/home/cubit/home_cubit.dart';
import 'package:my_sutra/generated/assets.dart';

class MyBatchesScreen extends StatefulWidget {
  const MyBatchesScreen({
    super.key,
  });

  @override
  State<MyBatchesScreen> createState() => _MyBatchesScreenState();
}

class _MyBatchesScreenState extends State<MyBatchesScreen> {
  List<TrainingProgram> trainingPrograms = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MyBatchesCubit>().getTrainingPrograms(
          context.read<HomeCubit>().currentAcademy?.id ?? "");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalSpace = 24;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is ChangeAcademy) {
          context
              .read<MyBatchesCubit>()
              .getTrainingPrograms(state.data.id ?? "");
        }
      },
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
        return ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 22),
              padding: const EdgeInsets.only(
                  left: horizontalSpace,
                  right: horizontalSpace,
                  top: 12,
                  bottom: 20),
              decoration: StylesAndDecorations.generalContainerDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField(
                    value: cubit.currentAcademy,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 20,
                      ),
                      border: _borderDeco(),
                      focusedBorder: _borderDeco(),
                      enabledBorder: _borderDeco(),
                      errorBorder: _borderDeco(),
                      disabledBorder: _borderDeco(),
                    ),
                    onChanged: (value) {
                      cubit.changeAcademy(value!);
                    },
                    icon: component.assetImage(path: Assets.iconsDropdown),
                    items: cubit.academies.map((AcademyCenter items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items.name ?? "",
                          style: theme.publicSansFonts.mediumStyle(
                            fontSize: 14,
                            fontColor: AppColors.black39,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  if (cubit.currentAcademy != null) ...[
                    Text("Center name", style: smallTextStyle()),
                    Text(
                      cubit.currentAcademy!.name!,
                      style: theme.publicSansFonts.semiBoldStyle(fontSize: 18),
                    ),
                    if (cubit.currentAcademy!.city != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 18,
                            color: AppColors.grey92,
                          ),
                          Text(cubit.academies.first.city!,
                              style: smallTextStyle()),
                        ],
                      ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: horizontalSpace),
              child: Text(
                "My Batches",
                style: theme.publicSansFonts.semiBoldStyle(
                    fontSize: 16, fontColor: AppColors.blackTokens),
              ),
            ),
            ...List<BatchCard>.generate(
              cubit.batches.length,
              (index) => BatchCard(data: cubit.batches[index]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 11),
              child: Divider(
                color: AppColors.greyD9.withOpacity(0.5),
                indent: horizontalSpace,
                endIndent: horizontalSpace,
              ),
            ),
            BlocConsumer<MyBatchesCubit, MyBatchesState>(
              listener: (context, state) {
                if (state is TrainingProgramLoaded) {
                  trainingPrograms = state.data;
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: horizontalSpace, top: 20),
                      child: Text(
                        "Training Programs",
                        style: theme.publicSansFonts.semiBoldStyle(
                            fontSize: 16, fontColor: AppColors.blackTokens),
                      ),
                    ),
                    ...List<TrainingCard>.generate(
                      trainingPrograms.length,
                      (batch) => TrainingCard(data: trainingPrograms[batch]),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }

  OutlineInputBorder _borderDeco() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );
  }

  TextStyle smallTextStyle() {
    return theme.publicSansFonts.regularStyle(
      fontSize: 14,
      fontColor: AppColors.black49,
      height: 23,
    );
  }
}
