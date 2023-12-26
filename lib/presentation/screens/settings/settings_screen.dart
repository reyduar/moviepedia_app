import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia_app/presentation/providers/settings/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  static const name = 'settings-screen';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkmode = ref.watch(appThemeNotifierProvider).isDarkmode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(!isDarkmode
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined),
            onPressed: () {
              ref.read(appThemeNotifierProvider.notifier).toggleDarkmode();
            },
          ),
        ],
      ),
      body: const SettingsAppView(),
    );
  }
}

enum Language { spanish, english, portuguese }

Language getLanguageValue(String lan) {
  switch (lan) {
    case 'es-MX':
      return Language.spanish;
    case 'pt-BR':
      return Language.portuguese;
    case 'en-US':
      return Language.english;
    default:
      return Language.english;
  }
}

class SettingsAppView extends ConsumerStatefulWidget {
  const SettingsAppView({super.key});

  @override
  SettingsAppViewState createState() => SettingsAppViewState();
}

class SettingsAppViewState extends ConsumerState<SettingsAppView> {
  bool isSafeSearch = true;
  String languge = 'en-US';
  Language selectLanguage = getLanguageValue('en-US');

  @override
  void initState() {
    super.initState();
    isSafeSearch = ref.read(isSafeSearchProvider);
    languge = ref.read(languageProvider);
    selectLanguage = getLanguageValue(languge);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        SwitchListTile(
            title: const Text('Safe Search'),
            subtitle: const Text('Filter explicit results'),
            value: isSafeSearch,
            onChanged: (value) => setState(() {
                  isSafeSearch = !isSafeSearch;
                })),
        ExpansionTile(
          initiallyExpanded: true,
          title: const Text('Languages'),
          subtitle:
              const Text('Changes titles and movie descriptions languages'),
          children: [
            RadioListTile(
                title: const Text('Spanish'),
                subtitle: const Text('Español MX'),
                value: Language.spanish,
                groupValue: selectLanguage,
                onChanged: (value) => setState(() {
                      selectLanguage = Language.spanish;
                      ref.read(languageProvider.notifier).state = 'es-MX';
                    })),
            RadioListTile(
                title: const Text('English'),
                subtitle: const Text('English US'),
                value: Language.english,
                groupValue: selectLanguage,
                onChanged: (value) => setState(() {
                      selectLanguage = Language.english;
                      ref.read(languageProvider.notifier).state = 'en-US';
                    })),
            RadioListTile(
                title: const Text('Portuguese'),
                subtitle: const Text('Português BR'),
                value: Language.portuguese,
                groupValue: selectLanguage,
                onChanged: (value) => setState(() {
                      selectLanguage = Language.portuguese;
                      ref.read(languageProvider.notifier).state = 'pt-BR';
                    })),
          ],
        ),
      ],
    );
  }
}
