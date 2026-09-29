---
name: dart-collect-coverage
description: Collect and inspect LCOV test coverage for Dart or Flutter projects. Use when the user requests a coverage report or needs to find untested behavior.
---

# Collect Dart test coverage

Use the project's existing coverage command if one exists. For Flutter, `flutter test --coverage` writes `coverage/lcov.info`. For Dart packages, use `package:coverage` and `dart run coverage:test_with_coverage` when that tool fits the test setup. In a workspace, run coverage in the correct package or pass the required test targets.

Read the resulting LCOV file and identify meaningful gaps. Do not treat a percentage alone as proof of test quality. Add `coverage:ignore-line`, `coverage:ignore-start`/`coverage:ignore-end`, or `coverage:ignore-file` only for code that cannot meaningfully be exercised; explain the exclusion.

Use manual VM service collection only if the standard runner cannot capture the needed coverage. Keep the VM service on loopback and retain its authentication unless the test environment requires otherwise. Verify that the report includes the intended source files.
