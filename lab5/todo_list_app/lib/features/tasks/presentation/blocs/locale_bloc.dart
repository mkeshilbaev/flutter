import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class LocaleEvent {}

class ChangeLocaleEvent extends LocaleEvent {
  final Locale newLocale;

  ChangeLocaleEvent(this.newLocale);
}

class LocaleState {
  final Locale currentLocale;

  LocaleState(this.currentLocale);
}

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleState(Locale('en')));

  @override
  Stream<LocaleState> mapEventToState(LocaleEvent event) async* {
    if (event is ChangeLocaleEvent) {
      yield LocaleState(event.newLocale);
    }
  }
}
