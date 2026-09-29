---
name: dart-migrate-to-checks-package
description: |-
  Replace the usage of `expect` and similar functions from `package:matcher`
  to `package:checks` equivalents.
---
# Migrating Dart Tests to Package Checks

Use this skill when you need to migrate a Dart test suite from the legacy
`package:matcher` (which is exported by default from `package:test/test.dart`)
to the modern, type-safe, and literate `package:checks` assertion library.

## When to Use This Skill
- When asked to "migrate tests to checks", "use package:checks", or
  "modernize test assertions".
- When updating legacy test suites where static type safety, better
  autocomplete in IDEs, and highly detailed failure diagnostics are desired.

---

## How to Use This Skill (The Workflow)

Follow this structured workflow to safely and systematically migrate a test suite:

### 1. Dependency Setup
- Add `package:checks` as a `dev_dependency` in `pubspec.yaml`:
  ```bash
  dart pub add dev:checks
  ```
- Remove `package:matcher` if it is explicitly listed under `dev_dependencies`
  (it is typically transitively included by `package:test`, which is fine).

### 2. Identify and Plan Target Files
- Use the grep patterns in [Strategies for Discovery](#strategies-for-discovery)
  to locate all test files containing legacy `expect` or `expectLater` calls.
- Decide whether to migrate files fully or incrementally.

### 3. Migrating a File (Incremental or Full)
For any target test file:
1. **Update Imports**:
   - Replace the generic `import 'package:test/test.dart';` with:
     ```dart
     import 'package:test/scaffolding.dart';
     import 'package:checks/checks.dart';
     ```
   - **For Incremental Migration**: If you only want to migrate some test cases
     in the file, or want to migrate one step at a time, add:
     ```dart
     import 'package:test/expect.dart'; // Temporarily allows legacy expect()
     ```
2. **Translate Assertions**: Rewrite legacy `expect` and `expectLater` calls
   to `check` syntax following the [Key Syntax Differences and
   Pitfalls](#key-syntax-differences-and-pitfalls) and the
   [Matcher-to-Checks Mapping Table](#matcher-to-checks-mapping-table).
3. **Verify via Compiler**: If migrating fully, remove the `import
   'package:test/expect.dart';` line. Any remaining un-migrated `expect`
   calls will immediately surface as compiler errors, making them easy to
   find and fix.

### 4. Verification and Feedback Loops
- **Static Analysis**: Run static analysis on the target package:
  ```bash
  dart analyze
  ```
  Pay close attention to generic type parameters on `.isA<Type>()` and
  ensure asynchronous expectations are properly awaited (check for
  `unawaited_futures` warnings).
- **Run Tests**: Execute the tests to verify both behavior and correct
  assertion runtime logic:
  ```bash
  dart test
  ```
  If a test fails, review the extremely detailed failure output of
  `package:checks` to diagnose if the test is genuinely failing or if the
  expectation was translated incorrectly.

---

## Conversion reference

Read [matcher conversion details](references/conversion.md) for collection equality, asynchronous expectations, custom matchers, and the mapping table when they apply to the target tests.
