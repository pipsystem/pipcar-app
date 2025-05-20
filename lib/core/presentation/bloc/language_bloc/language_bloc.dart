import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/configs/constants/language_constants.dart';
import '../base_bloc/base_bloc.dart';
part 'language_state.dart';

@lazySingleton
class LanguageBloc extends BaseBloc<LanguageState> {
  LanguageBloc() : super(LanguageState.initial());

  Future<void> loadLanguageFromSharePreference() async {
    //final prefs = await SharedPreferences.getInstance();

    //final locale = Locale(prefs.getString('lang') ?? LanguageConstants.en);
    const locale = Locale(LanguageConstants.en);
    emit(
      state.copyWith(
        status: LanguageStatus.success,
        locale: locale,
      ),
    );
  }

  Future<void> updateLanguage(Locale locale) async {
    emit(
      state.copyWith(
        status: LanguageStatus.loading,
        locale: locale,
      ),
    );
    // final prefs = await SharedPreferences.getInstance();
    //await prefs.setString('lang', locale.toString());

    emit(
      state.copyWith(
        status: LanguageStatus.success,
        locale: locale,
      ),
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
  }
}
