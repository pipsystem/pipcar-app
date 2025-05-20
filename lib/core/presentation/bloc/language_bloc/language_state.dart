part of 'language_bloc.dart';

enum LanguageStatus {
  initial,
  loading,
  success,
  failed,
}

class LanguageState extends Equatable {
  final LanguageStatus status;
  final Locale locale;

  const LanguageState({required this.status, required this.locale});

  factory LanguageState.initial() => const LanguageState(
        status: LanguageStatus.initial,
        locale: Locale(LanguageConstants.en),
      );

  LanguageState copyWith({LanguageStatus? status, Locale? locale}) =>
      LanguageState(
        status: status ?? this.status,
        locale: locale ?? this.locale,
      );

  @override
  List<Object?> get props => [status, locale];
}
