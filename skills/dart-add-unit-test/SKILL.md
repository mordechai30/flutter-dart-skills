---
name: dart-add-unit-test
description: Add focused unit tests for Dart code with package:test, or flutter_test in Flutter projects. Use for new logic and regressions that can be checked without a running app.
---

# Add Dart unit tests

Place `*_test.dart` files under `test/`, near the structure of the code they cover when useful. Use `package:test/test.dart` for Dart packages and `package:flutter_test/flutter_test.dart` for Flutter packages. Test public behavior, edge cases, and relevant failures with `test`, `group`, and `expect`.

Use real, in-memory dependencies where simple. Inject a fake, stub, or generated mock only when the dependency makes the test slow, nondeterministic, or hard to control. If a generated mock is needed, follow `dart-generate-test-mocks`.

Run the focused file with `dart test <file>` or `flutter test <file>`, then any wider suite justified by the change. Keep device integration tests in `integration_test/` and use the project's device runner rather than treating them as ordinary unit tests.
