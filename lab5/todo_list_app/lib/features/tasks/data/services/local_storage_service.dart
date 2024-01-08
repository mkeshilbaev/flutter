import 'package:hive/hive.dart';

class LocalStorageService {
  static const _localeBoxKey = 'localeBox';
  static const _localeKey = 'currentLocale';

  Future<void> saveLocale(String locale) async {
    final box = await Hive.openBox(_localeBoxKey);
    await box.put(_localeKey, locale);
    await box.close();
  }

  Future<String?> getSavedLocale() async {
    final box = await Hive.openBox(_localeBoxKey);
    final locale = box.get(_localeKey) as String?;
    await box.close();
    return locale;
  }
}
