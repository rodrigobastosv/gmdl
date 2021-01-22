part of 'i18n_cubit.dart';

abstract class I18nState extends Equatable {
  const I18nState();

  @override
  List<Object> get props => [];
}

class I18nInitial extends I18nState {}

class LocaleChanged extends I18nState {
  const LocaleChanged(this.locale);

  final String locale;

  @override
  List<Object> get props => [
        locale,
      ];
}
