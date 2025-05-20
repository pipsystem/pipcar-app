import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/themes/theme_color.dart';
import 'package:pipcar/common/themes/theme_text.dart';
import 'package:pipcar/core/presentation/widgets/text_field_widget/text_field_widget.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:pipcar/features/domain/enterties/agency/district_entity.dart';
import 'package:pipcar/features/ui/dash_board/search/cubit/search_cubit.dart';

class AddressSearchWidget extends StatefulWidget {
  final bool district;
  
  AddressSearchWidget({super.key, required this.district});

  @override
  State<AddressSearchWidget> createState() => district ? _DistrictSearchWidget() : _ProvinceSearchWidget();
}

class _ProvinceSearchWidget extends State<AddressSearchWidget> {
  TextEditingController _controller = TextEditingController();
  List<ProvinceEntity> _listProvices = [];
  List<ProvinceEntity> _searchResult = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchTextField(),
        _buildItemProvince()
      ],
    ).expand();
  }

  Widget _buildSearchTextField () {
    return SizedBox(
      child: TextFieldWidget(
          controller: _controller,
          hintText: "Tìm kiếm",
          hintStyle: ThemeText.note.copyWith(color: AppColor.hintColor, height: 1.5),
          textStyle: ThemeText.style12Regular.copyWith(fontWeight: FontType.regular),
          borderColor: AppColor.hintColor,
          prefixIcon: const Icon(Icons.search),
          onChanged: onSearchTextChanged,
          ).paddingAll(AppDimens.paddingLarge)
    );
  }

  Widget _buildItemProvince() {
    return Expanded(
      child: BlocBuilder<SearchCubit, SearchState> (
        builder: ((context, state) {
          _listProvices = state.provinces;
          return SingleChildScrollView(
            child: Column(
              children: _searchResult.isEmpty
                        ? _listProvices.map((e) {
                          return ListTile(
                            title: Column(
                              children: [
                                StyleLabel(
                                  title: e.name,
                                  textAlign: TextAlign.center,
                                  style: ThemeText.style12Regular,
                                ).paddingBottom(AppDimens.paddingSmall),
                                const Divider(color: AppColor.dividerColor),
                              ]
                            ),
                            onTap: () {
                              context.read<SearchCubit>().selectProvince(e);
                              context.pop();
                            },
                          );
                        }).toList()
                        : _searchResult.map((e) {
                          return ListTile(
                            title: Column(
                              children: [
                                StyleLabel(
                                  title: e.name,
                                  textAlign: TextAlign.center,
                                  style: ThemeText.style12Regular,
                                ).paddingBottom(AppDimens.paddingMedium),
                                const Divider(color: AppColor.dividerColor),
                              ]
                            ),
                            onTap: () {
                              context.read<SearchCubit>().selectProvince(e);
                              context.pop();
                            },
                          );
                        }).toList()
            ),
          );
        }),
      )
    );
  }

  onSearchTextChanged(String text) async {
    List<ProvinceEntity> entities = [];
    await context.read<SearchCubit>().getListProvinceSearch(text, entities);
    setState(() {
      _searchResult.clear();
      _searchResult = entities;
      log(_searchResult.length);
    });
  }
}

class _DistrictSearchWidget extends State<AddressSearchWidget> {
  TextEditingController _controller = TextEditingController();
  List<DistrictEntity> _listDistricts = [];
  List<DistrictEntity> _searchResult = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchTextField(),
        _buildItemDistrict()
      ],
    ).expand();
  }

  Widget _buildSearchTextField () {
    return SizedBox(
      child: TextFieldWidget(
          controller: _controller,
          hintText: "Tìm kiếm",
          hintStyle: ThemeText.note.copyWith(color: AppColor.hintColor, height: 1.5),
          textStyle: ThemeText.style12Regular.copyWith(fontWeight: FontType.regular),
          borderColor: AppColor.hintColor,
          prefixIcon: const Icon(Icons.search),
          onChanged: onSearchTextChanged,
          ).paddingAll(AppDimens.paddingLarge)
    );
  }

  Widget _buildItemDistrict() {
    return Expanded(
      child: BlocBuilder<SearchCubit, SearchState> (
        builder: ((context, state) {
          _listDistricts = state.districts;
          return SingleChildScrollView(
            child: Column(
              children: _searchResult.isEmpty
                        ? _listDistricts.map((e) {
                          return ListTile(
                            title: Column(
                              children: [
                                StyleLabel(
                                  title: e.name,
                                  textAlign: TextAlign.center,
                                  style: ThemeText.style12Regular,
                                ).paddingBottom(AppDimens.paddingSmall),
                                const Divider(color: AppColor.dividerColor),
                              ]
                            ),
                            onTap: () {
                              context.read<SearchCubit>().selectDistrict(e);
                              context.pop();
                            },
                          );
                        }).toList()
                        : _searchResult.map((e) {
                          return ListTile(
                            title: Column(
                              children: [
                                StyleLabel(
                                  title: e.name,
                                  textAlign: TextAlign.center,
                                  style: ThemeText.style12Regular,
                                ).paddingBottom(AppDimens.paddingMedium),
                                const Divider(color: AppColor.dividerColor),
                              ]
                            ),
                            onTap: () {
                              context.read<SearchCubit>().selectDistrict(e);
                              context.pop();
                            },
                          );
                        }).toList()
            ),
          );
        }),
      )
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
      List<DistrictEntity> entities = [];
      String provinceId = context.read<SearchCubit>().state.selectedProvinceConfig?.id ?? context.read<SearchCubit>().state.selectedProvince!.id;
      await context.read<SearchCubit>().getListDistrictSearch(provinceId, text, entities);
    setState(() {
      _searchResult = entities;
      log(_searchResult.length);
    });
  }
}