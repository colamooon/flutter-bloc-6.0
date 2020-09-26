part of 'locale_cubit.dart';

class LocaleState extends Equatable {
  const LocaleState({
    this.locale,
    this.isChanged = false,
  });

  final Locale locale;
  final bool isChanged;

  LocaleState copyWith({
    Locale locale,
    bool isChanged,
  }) {
    return LocaleState(
      locale: locale ?? this.locale,
      isChanged: isChanged ?? this.isChanged,
    );
  }

  @override
  List<Object> get props => [locale, isChanged];
}
