import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const LocaleState());

  Future<void> localeChanged(Locale locale) async {
    emit(state.copyWith(locale: locale, isChanged: true));
  }
}
