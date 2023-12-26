import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia_app/config/theme/app_theme.dart';

final isDarkmodeProvider = StateProvider<bool>((ref) => true);
final isSafeSearchProvider = StateProvider<bool>((ref) => true);
final languageProvider = StateProvider<String>((ref) => 'es-MX');

// final dioQueryParamsProvider = StateProvider<Map<String, dynamic>>((ref) {
//   // Read other providers or any necessary configurations
//   final isSafeSearch = ref.watch(isSafeSearchProvider);
//   final languageSelected = ref.watch(languageProvider);
//   final Map<String, dynamic> queryParams = {
//     'language': languageSelected,
//     'include_adult': isSafeSearch
//   };

//   return queryParams;
// });

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
