import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';

class ReportingBottomSheet extends StatelessWidget {
  final String postId;

  const ReportingBottomSheet({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is ReportPostLoaded) {
          AiloitteNavigation.back(context);
          showSuccessToast(
              context: context, message: 'Post Reported Successfully');
        }

        if (state is ReportPostError) {
          showErrorToast(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return Container(
          color: AppColors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeading(),
              component.spacer(height: 20),
              InkWell(
                onTap: () {
                  context.read<PostsCubit>().reportPost(
                      postId: postId,
                      reportReason: 'DONOT_LIKE_IT',
                      description: '');
                },
                child: _buildTextWidget(value: 'I just don\'t like it'),
              ),
              component.spacer(height: 10),
              _buildDivider(),
              InkWell(
                  onTap: () {
                    context.read<PostsCubit>().reportPost(
                        postId: postId,
                        reportReason: 'FRAUD_OR_SCAM',
                        description: '');
                  },
                  child: _buildTextWidget(value: 'Fraud or scam')),
              component.spacer(height: 10),
              _buildDivider(),
              InkWell(
                  onTap: () {
                    context.read<PostsCubit>().reportPost(
                        postId: postId, reportReason: 'DRUGS', description: '');
                  },
                  child: _buildTextWidget(value: 'Drugs')),
              component.spacer(height: 10),
              _buildDivider(),
              InkWell(
                  onTap: () {
                    context.read<PostsCubit>().reportPost(
                        postId: postId,
                        reportReason: 'FALSE_INFORMATION',
                        description: '');
                  },
                  child: _buildTextWidget(value: 'Something else')),
              component.spacer(height: 10),
              _buildDivider(),
              InkWell(
                  onTap: () {
                    context.read<PostsCubit>().reportPost(
                        postId: postId,
                        reportReason: 'NUDITY',
                        description: '');
                  },
                  child: _buildTextWidget(value: 'False information')),
              component.spacer(height: 10),
              _buildDivider(),
              InkWell(
                  onTap: () {
                    context.read<PostsCubit>().reportPost(
                        postId: postId,
                        reportReason: 'SOMETHING_ELSE',
                        description: '');
                  },
                  child: _buildTextWidget(value: 'Nudity or sexual activity')),
              component.spacer(height: 10),
              _buildDivider(),
              InkWell(
                  onTap: () {
                    context.read<PostsCubit>().reportPost(
                        postId: postId,
                        reportReason: 'DONOT_LIKE_IT',
                        description: '');
                  },
                  child: _buildTextWidget(value: 'Something else')),
              component.spacer(height: 10),
              _buildDivider(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDivider() {
    return const Divider(color: AppColors.color0xFFEAECF0);
  }

  Widget _buildTextWidget({required String value}) {
    return component.text(
      value,
      style: theme.publicSansFonts.regularStyle(
        fontSize: 16,
        fontColor: AppColors.color0xFF1E293B,
      ),
    );
  }

  Widget _buildHeading() {
    return component.text(
      'Why are you reporting this post?',
      style: theme.publicSansFonts.semiBoldStyle(
        fontSize: 18,
        fontColor: AppColors.color0xFF1E293B,
      ),
    );
  }
}
