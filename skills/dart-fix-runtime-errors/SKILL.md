---
name: dart-fix-runtime-errors
description: Diagnose and fix observed Dart or Flutter runtime failures from a stack trace, failing test, or running app. Use for exceptions, failed casts, late initialization errors, and similar failures.
---

# Fix Dart runtime errors

## Diagnose

1. Capture the exact exception, stack trace, command or user action, and SDK version. Use available Dart and Flutter MCP runtime tools when connected to the app; otherwise use logs or a focused reproduction.
2. Find the first relevant application frame. Trace the value and control flow that produced the failure.
3. Reproduce the failure with a focused test when that test would protect against recurrence. Preserve the intended behavior.

## Fix and verify

Fix the cause, such as incorrect parsing, an unsafe cast, missing initialization, or an invalid lifecycle assumption. Do not add `late`, `!`, or a broad catch merely to silence the failure. Catch exceptions only when the application can recover or add useful context.

Run the focused reproduction, then relevant tests and analysis. For a running Flutter app, use hot reload for compatible implementation changes; use hot restart when initialization or global state must be rebuilt. Check the available MCP tools before invoking them. If no app is running, report that runtime verification was not possible.

For analyzer diagnostics without an observed runtime failure, use `dart-run-static-analysis` instead.
