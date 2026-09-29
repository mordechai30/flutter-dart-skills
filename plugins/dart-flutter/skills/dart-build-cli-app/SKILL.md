---
name: dart-build-cli-app
description: Build Dart command-line tools with sound argument parsing, streams, exit status, packaging, and subprocess behavior. Use for console apps and installed Dart executables.
---

# Build Dart CLI applications

## Structure and process behavior

Keep `bin/` entrypoints small and put reusable command logic in `lib/`. Use `package:args` for options or subcommands. Send results to stdout and diagnostics to stderr. Show help on stdout when requested; show usage errors on stderr with a nonzero status.

Return from `main` after setting `exitCode`, or return an integer from `CommandRunner<int>`. Avoid `exit()` in normal paths because it can discard buffered output and cleanup. Use standard exit statuses only when they suit the tool's interface.

Declare `executables:` in `pubspec.yaml` for named commands. Use `dart run` during development and `dart install` or `dart compile exe` when distribution requires an AOT binary.

## Conditional details

- If the CLI launches another Dart process from an AOT binary, read [AOT SDK discovery](references/aot_sdk_discovery.md). Do not assume `Platform.resolvedExecutable` is the Dart SDK executable.
- If it changes terminal modes, listens for signals, or pipes large output, read [signals and terminal cleanup](references/signals_and_terminal.md).
- Use [single-command](examples/single_command_tool.dart) or [multi-command](examples/multi_command_runner.dart) examples only when their shape fits the task. Adapt required options and help handling to the installed `package:args` version.

Test parsing and core logic directly. Add a subprocess test when OS exit status, stdout/stderr routing, or binary packaging is part of the contract.
