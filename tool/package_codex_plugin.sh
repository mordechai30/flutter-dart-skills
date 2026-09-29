#!/bin/bash
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
package="$root/plugins/dart-flutter"
mkdir -p "$package/.codex-plugin" "$package/skills"
cp "$root/.codex-plugin/plugin.json" "$package/.codex-plugin/plugin.json"
rsync -a --delete "$root/skills/" "$package/skills/"
