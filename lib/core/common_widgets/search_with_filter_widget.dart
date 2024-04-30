import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/generated/assets.dart';

import '../../features/presentation/patient/search_filter_screen.dart';
import '../../routes/routes_constants.dart';

class SearchWithFilter extends StatefulWidget {
  const SearchWithFilter({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText,
    this.onTapFilter,
    this.backgroundColor,
    this.onTap,
    this.filter,
  });

  final Function(String onChange)? onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final void Function(SearchFilterArgs args)? onTapFilter;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final SearchFilterArgs? filter;

  @override
  State<SearchWithFilter> createState() => _SearchWithFilterState();
}

class _SearchWithFilterState extends State<SearchWithFilter> {
  final double radius = 8;

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
          color: widget.backgroundColor ?? AppColors.backgroundColor),
    );
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            key: widget.key,
            onTap: widget.onTap,
            controller: widget.controller,
            onChanged: widget.onChanged,
            textAlignVertical: TextAlignVertical.center,
            style: theme.publicSansFonts.regularStyle(fontSize: 16),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              prefixIcon: const Icon(Icons.search, color: AppColors.black24),
              hintStyle: theme.publicSansFonts
                  .regularStyle(fontSize: 14, fontColor: AppColors.selected),
              hintText: widget.hintText ?? "Search",
              filled: true,
              fillColor: widget.backgroundColor ?? AppColors.backgroundColor,
              border: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              errorBorder: outlineInputBorder,
              disabledBorder: outlineInputBorder,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          //todo please check this one where should we call onTapFilter
          onTap: () async {
            if (widget.onTapFilter != null) {
              final result = await AiloitteNavigation.intentWithData(
                  context, AppRoutes.searchFilterScreen, widget.filter);
              if (result != null && result is SearchFilterArgs) {
                widget.onTapFilter?.call(result);
              }
            }
          },
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: widget.backgroundColor ?? AppColors.backgroundColor,
            ),
            child: component.assetImage(path: Assets.iconsFilter),
          ),
        ),
      ],
    );
  }
}
