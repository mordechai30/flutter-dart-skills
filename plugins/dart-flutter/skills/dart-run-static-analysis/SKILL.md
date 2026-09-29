---
name: dart-run-static-analysis
description: Run Dart or Flutter static analysis, interpret diagnostics, and apply focused analyzer fixes. Use for analyzer errors, warnings, lint setup, and mechanical fixes.
---

# Run Dart static analysis

## Analyze

Inspect the project's `analysis_options.yaml`. Preserve its existing lint set and severity policy. For a new Dart package, `package:lints/recommended.yaml` is a common base; for Flutter, use `package:flutter_lints/flutter.yaml` when that dependency is present.

Run `dart analyze <target>` or `flutter analyze <target>`. Use an available Dart MCP analysis tool when it provides better project context. Read each diagnostic before changing code. Enable strict casts, inference, or raw-type checks only when requested or consistent with the project's policy.

## Fix

Use `dart fix --dry-run` to preview mechanical fixes. Apply only fixes relevant to the task, then format changed Dart files and analyze again. Prefer correcting code over suppressing a diagnostic. Use a narrow `ignore` with a reason only when a diagnostic is demonstrably inapplicable. Avoid broad generated-file exclusions that could hide errors.

Check relevant tests if analysis fixes can change behavior. Report unresolved diagnostics and their scope.
