---
name: dart-use-ffigen
description: Generate Dart FFI bindings from native headers with package:ffigen. Use for new bindings, binding updates, and relevant native interop migrations.
---

# Generate FFI bindings

Inspect the existing bindings, headers, generator configuration, target platforms, and installed `ffigen` version. Prefer extending the project's generator setup. Use the current `ffigen` API for that version; do not assume a fixed generator script path, header folder, output folder, or file suffix.

Select the declarations the task needs and preserve ABI details, ownership rules, callbacks, and library loading behavior. Place generated code under the package's existing convention and mark it as generated. Include license notices required by the source and project; do not copy a third-party copyright header without checking its terms.

For Dart 3.13 native library tree shaking, use `@RecordUse` and a mapping when the target build uses Code Assets and the installed generator supports it. Treat this as optional for ordinary FFI bindings.

Regenerate bindings, inspect the diff, run analysis, and exercise at least one native call on each available target. Fix generator configuration before editing generated code manually. If the generator itself produces invalid code, record a minimal reproduction and report the limitation.
