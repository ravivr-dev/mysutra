import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';

class ArticleDetailScreen extends StatefulWidget {
  final ArticleEntity article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(context.stringForKey(StringKeys.article)),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: AppColors.white),
        child: Column(
          children: [
            component.text(widget.article.heading,
                style: theme.publicSansFonts.semiBoldStyle(fontSize: 20)),
            component.spacer(height: 24),
            _buildInfo(),
            component.spacer(height: 24),
            component.text(widget.article.content,
                style: theme.publicSansFonts
                    .regularStyle(fontColor: AppColors.grey92, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      children: [
        component.divider(color: AppColors.dividerColor, thickness: 1),
      ],
    );
  }
}
