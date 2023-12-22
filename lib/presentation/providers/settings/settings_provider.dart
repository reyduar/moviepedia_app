import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia_app/config/theme/app_theme.dart';

final isDarkmodeProvider = StateProvider<bool>((ref) => true);
final isSafeSearchProvider = StateProvider<bool>((ref) => true);
final languageProvider = StateProvider<String>((ref) => '');

final appThemeNotifierProvider =
    StateNotifierProvider<ThemeNotififier, AppTheme>(
        (ref) => ThemeNotififier());

class ThemeNotififier extends StateNotifier<AppTheme> {
  // STATE = Estado = new AppTheme()
  ThemeNotififier() : super(AppTheme());

  void toggleDarkmode() {
    state = state.copyWith(isDarkmode: !state.isDarkmode);
  }
}
