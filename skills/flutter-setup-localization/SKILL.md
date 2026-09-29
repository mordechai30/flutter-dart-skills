---
name: flutter-setup-localization
description: Set up or update generated Flutter localizations from ARB files. Use for localization configuration, translated strings, and localization delegates.
---

# Set up Flutter localization

## Choose the existing UI stack

Inspect the Flutter version, imports, and localization setup before editing. Preserve an existing Material or Cupertino setup. Flutter 3.47 also offers opt-in standalone `material_ui` and `cupertino_ui` packages; do not migrate design packages as part of an ordinary localization task.

For SDK design libraries, use `flutter_localizations` from the Flutter SDK and `intl`. For standalone design packages, use their matching localization delegates. `GlobalMaterialLocalizations.delegates` includes the Material, Cupertino, and Widgets delegates in the standalone package.

## Generate localizations

1. Add `flutter_localizations` and `intl` only if the project needs them. Keep `flutter: generate: true` in `pubspec.yaml`.
2. Keep or create `l10n.yaml` and ARB files. For example:

   ```yaml
   arb-dir: lib/l10n
   template-arb-file: app_en.arb
   output-localization-file: app_localizations.dart
   ```

3. Generate with `flutter gen-l10n` or the project's existing build workflow.
4. Import generated source from its actual location under `lib/`, such as `package:my_app/l10n/app_localizations.dart`. Do not use `synthetic-package: true` or `package:flutter_gen`.
5. Use `AppLocalizations.localizationsDelegates` and `AppLocalizations.supportedLocales` when they match the app's design-library setup. If the app uses standalone UI packages, follow those packages' delegate configuration.
6. Add or update each translated ARB message, including placeholder metadata. Run generation, analysis, and a localization test or app check.

Keep the project's locale list and fallback behavior. Do not invent translations for languages the user has not requested.
