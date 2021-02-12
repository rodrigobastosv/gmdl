part of 'i18n_cubit.dart';

abstract class I18nState extends Equatable {
  const I18nState();

  @override
  List<Object> get props => [];
}

class I18nInitial extends I18nState {}

class I18nLocaleChange extends I18nState {
  const I18nLocaleChange(this.locale);

  final String locale;

  @override
  List<Object> get props => [
        locale,
      ];
}

class I18nResourcesFetchSuccess extends I18nState {}

class I18nResourcesFetchFailure extends I18nState {}
