// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `left to spent`
  String get left_to_spent {
    return Intl.message(
      'left to spent',
      name: 'left_to_spent',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Enter new value`
  String get enter_new_value {
    return Intl.message(
      'Enter new value',
      name: 'enter_new_value',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get newS {
    return Intl.message(
      'New',
      name: 'newS',
      desc: '',
      args: [],
    );
  }

  /// `Add new\n subscription`
  String get add_new_subscription {
    return Intl.message(
      'Add new\\n subscription',
      name: 'add_new_subscription',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Monthly price`
  String get monthly_price {
    return Intl.message(
      'Monthly price',
      name: 'monthly_price',
      desc: '',
      args: [],
    );
  }

  /// `Add this platform`
  String get add_this_platform {
    return Intl.message(
      'Add this platform',
      name: 'add_this_platform',
      desc: '',
      args: [],
    );
  }

  /// `Calender`
  String get calender {
    return Intl.message(
      'Calender',
      name: 'calender',
      desc: '',
      args: [],
    );
  }

  /// `Subs\nSchedule`
  String get subs_schedule {
    return Intl.message(
      'Subs\\nSchedule',
      name: 'subs_schedule',
      desc: '',
      args: [],
    );
  }

  /// `subscription for today`
  String get subscription_for_today {
    return Intl.message(
      'subscription for today',
      name: 'subscription_for_today',
      desc: '',
      args: [],
    );
  }

  /// `in upcoming bills`
  String get in_upcoming_bills {
    return Intl.message(
      'in upcoming bills',
      name: 'in_upcoming_bills',
      desc: '',
      args: [],
    );
  }

  /// `Add New Card`
  String get add_new_card {
    return Intl.message(
      'Add New Card',
      name: 'add_new_card',
      desc: '',
      args: [],
    );
  }

  /// `Card Name`
  String get card_name {
    return Intl.message(
      'Card Name',
      name: 'card_name',
      desc: '',
      args: [],
    );
  }

  /// `Holder Name`
  String get holder_name {
    return Intl.message(
      'Holder Name',
      name: 'holder_name',
      desc: '',
      args: [],
    );
  }

  /// `Last 4 Digits`
  String get last_4_digits {
    return Intl.message(
      'Last 4 Digits',
      name: 'last_4_digits',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date (MM/YY)`
  String get exp_date {
    return Intl.message(
      'Expiry Date (MM/YY)',
      name: 'exp_date',
      desc: '',
      args: [],
    );
  }

  /// `Credit Cards`
  String get credit_cards {
    return Intl.message(
      'Credit Cards',
      name: 'credit_cards',
      desc: '',
      args: [],
    );
  }

  /// `Subscriptions`
  String get subscriptions {
    return Intl.message(
      'Subscriptions',
      name: 'subscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Expenses`
  String get monthly_expenses {
    return Intl.message(
      'Monthly Expenses',
      name: 'monthly_expenses',
      desc: '',
      args: [],
    );
  }

  /// `View Your Wallet`
  String get view_your_wallet {
    return Intl.message(
      'View Your Wallet',
      name: 'view_your_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Active subs`
  String get active_subs {
    return Intl.message(
      'Active subs',
      name: 'active_subs',
      desc: '',
      args: [],
    );
  }

  /// `Highest sub`
  String get highest_sub {
    return Intl.message(
      'Highest sub',
      name: 'highest_sub',
      desc: '',
      args: [],
    );
  }

  /// `Lowest sub`
  String get lowest_sub {
    return Intl.message(
      'Lowest sub',
      name: 'lowest_sub',
      desc: '',
      args: [],
    );
  }

  /// `Memberships`
  String get memberships {
    return Intl.message(
      'Memberships',
      name: 'memberships',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming Bills`
  String get upcoming_bills {
    return Intl.message(
      'Upcoming Bills',
      name: 'upcoming_bills',
      desc: '',
      args: [],
    );
  }

  /// `budget`
  String get budget {
    return Intl.message(
      'budget',
      name: 'budget',
      desc: '',
      args: [],
    );
  }

  /// `Your budgets are on tack`
  String get y_budget_on_tack {
    return Intl.message(
      'Your budgets are on tack',
      name: 'y_budget_on_tack',
      desc: '',
      args: [],
    );
  }

  /// `Add new category`
  String get add_new_category {
    return Intl.message(
      'Add new category',
      name: 'add_new_category',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Info`
  String get subscription_info {
    return Intl.message(
      'Subscription Info',
      name: 'subscription_info',
      desc: '',
      args: [],
    );
  }

  /// `How about controlling all your expenses\n under one roof?`
  String get welcome_screen_message {
    return Intl.message(
      'How about controlling all your expenses\n under one roof?',
      name: 'welcome_screen_message',
      desc: '',
      args: [],
    );
  }

  /// `Let's Get Started`
  String get lets_start {
    return Intl.message(
      'Let\'s Get Started',
      name: 'lets_start',
      desc: '',
      args: [],
    );
  }

  /// `$`
  String get currency {
    return Intl.message(
      '\$',
      name: 'currency',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
