---
name: dart-generate-test-mocks
description: Generate Mockito test doubles for Dart or Flutter dependencies when hand-written fakes are impractical. Use for controlled service responses and interaction verification.
---

# Generate Dart test mocks

First check whether a simple fake or injected in-memory implementation can cover the behavior. If Mockito is useful, add `mockito` and `build_runner` as dev dependencies and keep the production dependency injectable.

Place `@GenerateNiceMocks([MockSpec<Dependency>()])` or `@GenerateMocks` on the test library according to the desired unstubbed-call behavior. Import its generated `.mocks.dart` file, then run `dart run build_runner build`. Stub each call whose return value matters, and verify interactions only when they are part of the behavior under test.

Run the focused test and analysis. Do not refactor unrelated production architecture merely to use mocks.
