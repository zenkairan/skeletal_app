import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;


class CustomLocalization {

  final Locale locale;
  CustomLocalization(this.locale);

  static CustomLocalization of(BuildContext context){
    return Localizations.of<CustomLocalization>(context, CustomLocalization);
  }

//localized strings
  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'welcome': 'Welcome',
      'welcome_message': 'Welcome message',
      'login': 'Log in',
      'register': 'Register',
      'user_name': 'User name',
      'user_name_required': 'User name is required',
      'email': 'E-mail',
      'email_required': 'E-mail is required',
      'password': 'Password',
      'password_required': 'Password is required',
      'send': 'Send',
      'home': 'Home',
      'product': 'Product',
      'edit': 'Edit',
      'user_description': 'About me',
      'save': 'Save',
      'facebook': 'Login with Facebook',
      'connectionError': 'Connection error, try again later',
      'defaultError': 'An error has occurred, try again later', 
      'loginError': 'Invalid username or password',
    },
    'pt': {
      'welcome': 'Bem Vindo',
      'welcome_message': 'Mensagem inicial',
      'login': 'Log in',
      'register': 'Cadastrar',
      'user_name': 'Nome de usuário',
      'user_name_required': 'Nome de usuário é obrigatório',
      'email': 'E-mail',
      'email_required': 'E-mail é obrigatório',
      'password': 'Senha',
      'password_required': 'Senha é obrigatório',
      'send': 'Enviar',
      'home': 'Home',
      'product': 'Produto',
      'edit': 'Editar',
      'user_description': 'Minha descrição',
      'save': 'Salvar',
      'facebook': 'Login com Facebook',
      'connectionError': 'Erro de conexão, tente novamente mais tarde',
      'defaultError': 'Ocorreu um erro, tente novamente mais tarde',
      'loginError': 'Usuário ou senha inválidos',
    },
  };

//retrieve strings
  String get welcome{
    return _localizedValues[locale.languageCode]['welcome'];
  }
  String get welcomeMessage{
    return _localizedValues[locale.languageCode]['welcome_message'];
  }
  String get login{
    return _localizedValues[locale.languageCode]['login'];
  }
  String get register{
    return _localizedValues[locale.languageCode]['register'];
  }
  String get userName{
    return _localizedValues[locale.languageCode]['user_name'];
  }
  String get userNameRequired{
    return _localizedValues[locale.languageCode]['user_name_required'];
  }
  String get email{
    return _localizedValues[locale.languageCode]['email'];
  }
  String get emailRequired{
    return _localizedValues[locale.languageCode]['email_required'];
  }
  String get password{
    return _localizedValues[locale.languageCode]['password'];
  }
  String get passwordRequired{
    return _localizedValues[locale.languageCode]['password_required'];
  }
  String get send{
    return _localizedValues[locale.languageCode]['send'];
  }
  String get home{
    return _localizedValues[locale.languageCode]['home'];
  }
  String get product{
    return _localizedValues[locale.languageCode]['product'];
  }
  String get edit{
    return _localizedValues[locale.languageCode]['edit'];
  }
  String get userDescription{
    return _localizedValues[locale.languageCode]['user_description'];
  }
  String get save{
    return _localizedValues[locale.languageCode]['save'];
  }
  String get facebook{
    return _localizedValues[locale.languageCode]['facebook'];
  }
  String get connectionError{
    return _localizedValues[locale.languageCode]['connectionError'];
  }
  String get defaultError{
    return _localizedValues[locale.languageCode]['defaultError'];
  }
  String get loginError{
    return _localizedValues[locale.languageCode]['loginError'];
  }
}

class CustomLocalizationDelegate extends LocalizationsDelegate<CustomLocalization>{

  const CustomLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'pt'].contains(locale.languageCode);

  @override
  Future<CustomLocalization> load(Locale locale){
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of CustomLocalization.
    return SynchronousFuture<CustomLocalization>(CustomLocalization(locale));
  }

  @override
  bool shouldReload(CustomLocalizationDelegate old) => false;
}