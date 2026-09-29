---
name: flutter-gpu-scene-setup
description: Set up a Flutter app for current Flutter GPU and flutter_scene rendering across native and web targets, including the Scene asset build hook. Use for new projects and setup repairs.
---

# Flutter GPU and Scene setup

Target Flutter 3.47.1 or newer and the current `flutter_scene` API. Use `flutter_scene` for a scene graph and `package:flutter_gpu/gpu.dart` when the task needs direct GPU commands. On native targets, both use Impeller. Scene supplies its own WebGL2 backend on web; direct `flutter_gpu` is a native API.

## Set up

1. Add `flutter_scene` with `flutter pub add flutter_scene`. For direct GPU code, add the SDK dependency below and import `package:flutter_gpu/gpu.dart` with a `gpu` prefix.

   ```yaml
   dependencies:
     flutter_gpu:
       sdk: flutter
   ```

2. Enable Flutter GPU in each native target that the app ships. Put `<key>FLTEnableFlutterGPU</key><true/>` in the top-level `<dict>` of `ios/Runner/Info.plist` and `macos/Runner/Info.plist`. Put `<meta-data android:name="io.flutter.embedding.android.EnableFlutterGPU" android:value="true" />` inside `<application>` in `android/app/src/main/AndroidManifest.xml`. Set `fl_dart_project_set_enable_flutter_gpu(project, TRUE)` on the Linux runner's `FlDartProject`; set `project.set_enable_flutter_gpu(true)` on the Windows runner's `flutter::DartProject`. Web needs no Flutter GPU switch. `flutter run --enable-flutter-gpu` is useful for a native development run.

3. For Scene assets, run `dart run flutter_scene:init`. It creates or updates the build-hook integration and adds `flutter_scene_generated/` to `flutter.assets`. Preserve any platform-filtered generated-asset entries it adds. Keep source assets in version control and generated output ignored. If `hook/build.dart` already exists, integrate `buildScenes` and `buildMaterials` into its `build()` callback; `init` prints the required block instead of replacing the hook. The generated hook discovers loose images; a custom hook can call `buildTextures` for an explicit image list. Keep one coordinated hook when a raw shader bundle also uses it.

4. First render a built-in `CuboidGeometry` with `UnlitMaterial` in `SceneView.declarative`, using a `SceneMesh` child and a `PerspectiveCamera`. An app-owned `Scene` with `SceneView(scene)` is the equivalent imperative path. `SceneView` waits for shared resources before drawing; a `loadingBuilder` can show a placeholder. Keep geometry, materials, and components stable across rebuilds, and keep an app-owned `Scene` in widget state. Confirm this scene on each target before adding imported assets.

## Verify

Run `flutter analyze` after setup or build-hook changes. Open the small scene on each supported target: native for direct Flutter GPU, and native or web for Scene. Confirm that generated assets load and the first frame renders. Use a device integration test when a platform setup or asset-loading failure needs regression coverage.

## Current references

- [Scene installation and platform settings](https://fscene.dev/getting-started/installation/)
- [Scene first scene](https://fscene.dev/getting-started/your-first-scene/)
- [Scene core concepts](https://fscene.dev/getting-started/core-concepts/)
- [Flutter GPU Dart API](https://api.flutter.dev/flutter/flutter_gpu/)
- [Scene repository and build hook](https://github.com/bdero/flutter_scene)
- [Current example build hook](https://github.com/bdero/flutter_scene/blob/master/examples/flutter_app/hook/build.dart)
- [Current example asset declarations](https://github.com/bdero/flutter_scene/blob/master/examples/flutter_app/pubspec.yaml)

Use the linked current API for exact signatures when editing a project.
