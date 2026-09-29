# Signals and terminal cleanup

Read this when a CLI changes terminal modes, hides the cursor, owns a listening socket, or streams to a pipe.

Before changing `stdin.echoMode` or `stdin.lineMode`, check `stdin.hasTerminal`. Save both original values. Restore them in `finally` after the interactive task finishes, and in a signal cancellation handler when the task is interrupted. Cancel signal subscriptions when done. Guard `ProcessSignal.sigterm.watch()` on Windows, where SIGTERM is unavailable.

If hiding the cursor with an ANSI escape, show it again during cleanup. Emit ANSI only when output is a terminal, ANSI escapes are supported, and `NO_COLOR` is absent.

Close owned sockets and terminate owned child processes during cancellation. Prefer cooperative cleanup and setting `exitCode` over immediate `exit()`. An immediate process exit is an exceptional last resort after synchronous terminal restoration, not a normal CLI completion path.

When a downstream pipe closes, stop producing output. Handle the platform's broken-pipe error without treating every `SocketException` as a successful pipe close.
