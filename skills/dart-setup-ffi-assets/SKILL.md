---
name: dart-setup-ffi-assets
description: Package native libraries as Dart Code Assets with build or link hooks. Use when a Dart or Flutter package needs to compile or bundle C, C++, Rust, or prebuilt native code.
---

# Set up Dart Code Assets

Inspect the package's SDK constraint, target platforms, native sources, license, and current hook setup. Follow the installed versions of `package:hooks`, `package:code_assets`, and the chosen native toolchain package; their APIs can change. Preserve an existing working build system where it meets the task.

Use `hook/build.dart` to produce target-specific Code Assets. Use `hook/link.dart` only when link-time work is needed. For C or C++ sources, `package:native_toolchain_c` can manage compilation. For prebuilt binaries, validate platform and architecture, checksum, provenance, license, and offline behavior before using a download. Do not download or execute a binary from an unverified URL.

Dart 3.13 supports native library tree shaking through `@RecordUse` and `package:record_use`. Add record-use mapping and link-time stripping only when binary size matters and the selected binding generator and toolchain support it. Generated-file names and locations should follow the package's conventions; no fixed `lib/src/third_party/` path is required.

Run the package's native build and focused test on each available target. Check that the asset is bundled and loadable. For a tree-shaking change, compare symbols or binary size with a representative build. Report targets that could not be tested.
