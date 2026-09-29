---
name: flutter-add-integration-test
description: Add and run Flutter integration tests with integration_test. Use for device-level app flows, platform behavior, and end-to-end interactions.
---

# Add Flutter integration tests

## Set up

Inspect existing tests and target platforms. Add `integration_test` as a Flutter SDK dev dependency if missing. Place tests in `integration_test/` and name files `*_test.dart`.

Initialize `IntegrationTestWidgetsFlutterBinding.ensureInitialized()` in the test's `main()`. Import the app and use `testWidgets`, `WidgetTester`, and finders. Add stable keys only where existing text or semantics do not identify the target reliably.

Do not add `enableFlutterDriverExtension()` to the application for an `integration_test` test. Keep `flutter_driver` setup only when maintaining a legacy Flutter Driver suite.

## Explore and verify

If the Dart and Flutter MCP server exposes app launch and interaction tools, use them to inspect a running app. Check which tools are available; do not assume a particular tool name. Write the observed behavior as a repeatable test.

Run `flutter test integration_test/<file>_test.dart -d <device>` on supported mobile or desktop targets. Use `flutter drive` and a host driver only for a target or workflow that requires one, such as the documented web setup or performance collection. Follow the project's CI and device configuration. Verify the test fails for the intended regression and passes after the fix when practical.

Use `pumpAndSettle` only when animations settle. For continuous animations, wait for the specific state with bounded pumps or finders.
