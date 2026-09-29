---
name: dart-resolve-package-conflicts
description: Diagnose and resolve Dart or Flutter pub dependency conflicts. Use when pub get fails, a package is retracted, or constraints block a needed upgrade.
---

# Resolve pub dependency conflicts

## Inspect the resolution

Read the `pub get` error, `pubspec.yaml`, SDK constraints, workspace configuration, and relevant `pubspec.lock` entries. Use `dart pub outdated` and `dart pub deps` when they help identify the constraint chain. In Flutter projects, use `flutter pub` commands where appropriate.

## Change the smallest constraint

Prefer a targeted `dart pub upgrade <package>` or a justified change to the direct dependency constraint. If a transitive package is the blocker, identify its parent before changing constraints. Use `dart pub add <package>:<constraint>` when it accurately expresses the intended supported range. Follow the package's compatibility requirements; caret constraints are common, not mandatory.

Do not hand-edit individual `pubspec.lock` blocks to force resolution. Preserve the lockfile policy for the package or application. Use dependency overrides only as a temporary, explicit project decision, and remove them when proper compatible releases are available.

Run `pub get`, inspect the resulting dependency diff, then run relevant analysis and tests. Report any remaining incompatibility with the exact package constraints involved.
