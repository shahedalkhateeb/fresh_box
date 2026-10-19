import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

final ValueNotifier<Locale> appLocale = ValueNotifier(const Locale('en'));

void toggleLanguage() {
  final next = appLocale.value.languageCode == 'en' ? 'ar' : 'en';
  appLocale.value = Locale(next);
  GetStorage().write('lang', next);
}

class AppStrings {
  static const Map<String, Map<String, String>> _values = {
    'en': {
      'yourLocation': 'Your Location',
      'searchHint': 'what do you want to eat?',
      'featured': 'Featured',
      'nearbyYou': 'Nearby you',
      'trending': 'Trending',
      'newest': 'Newest',
      'breakfast': 'Breakfast',
      'lunch': 'Lunch',
      'dinner': 'Dinner',
      'snacks': 'Snacks',
      'popularFood': 'Popular Food',
      'nearbyRestaurant': 'Nearby Restaurant',
      'seeAll': 'See All',
      'openAt': 'Open at',
      'min': 'Min',
    },
    'ar': {
      'yourLocation': 'موقعك',
      'searchHint': 'ماذا تفضل ؟',
      'featured': 'المميز',
      'nearbyYou': 'قريب منك',
      'trending': 'الأكثر رواجاً',
      'newest': 'الأحدث',
      'breakfast': 'فطور',
      'lunch': 'غداء',
      'dinner': 'عشاء',
      'snacks': 'سناكس',
      'popularFood': 'الأكثر شعبية',
      'nearbyRestaurant': 'مطاعم قريبة',
      'seeAll': 'عرض الكل',
      'openAt': 'يفتح الساعة',
      'min': 'دقيقة',
    },
  };

  static String tr(BuildContext context, String key) {
    final lang = Localizations.localeOf(context).languageCode;
    return _values[lang]?[key] ?? _values['en']![key] ?? key;
  }
}