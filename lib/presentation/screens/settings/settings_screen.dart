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
      body: const _SettingsAppView(),
    );
  }
}

// spanish, english, portuguese, french
enum Language { spanish, english, portuguese, french }

class _SettingsAppView extends StatefulWidget {
  const _SettingsAppView();

  @override
  State<_SettingsAppView> createState() => _SettingsAppViewState();
}

class _SettingsAppViewState extends State<_SettingsAppView> {
  bool isSafeSearch = true;
  Language selectLanguage = Language.spanish;

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
          subtitle: Text('$selectLanguage'),
          children: [
            RadioListTile(
                title: const Text('Spanish'),
                subtitle: const Text('Español MX'),
                value: Language.spanish,
                groupValue: selectLanguage,
                onChanged: (value) => setState(() {
                      selectLanguage = Language.spanish;
                    })),
            RadioListTile(
                title: const Text('English'),
                subtitle: const Text('English US'),
                value: Language.english,
                groupValue: selectLanguage,
                onChanged: (value) => setState(() {
                      selectLanguage = Language.english;
                    })),
            RadioListTile(
                title: const Text('Portuguese'),
                subtitle: const Text('Português BR'),
                value: Language.portuguese,
                groupValue: selectLanguage,
                onChanged: (value) => setState(() {
                      selectLanguage = Language.portuguese;
                    })),
            RadioListTile(
                title: const Text('French'),
                subtitle: const Text('Français FR'),
                value: Language.french,
                groupValue: selectLanguage,
                onChanged: (value) => setState(() {
                      selectLanguage = Language.french;
                    }))
          ],
        ),
      ],
    );
  }
}
