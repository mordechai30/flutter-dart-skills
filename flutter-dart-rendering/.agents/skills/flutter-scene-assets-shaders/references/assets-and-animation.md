# Assets and animation

## Import path

Use `dart run flutter_scene:init` once to set up Scene's build hook. Put shipped `.glb`, `.fscene`, `.fmat`, and loose images under `assets/`. The generated hook discovers them. In a custom `hook/build.dart`, use `buildScenes` for `.glb` and `.fscene`, `buildMaterials` for `.fmat`, and `buildTextures` for an explicit loose-image list. The model hook preprocesses shipped `.glb` files into `.fsceneb`. If a custom hook builds local file paths, add `path` as a dependency and use `package:path` to join or inspect them across platforms. Keep glTF resource URLs as URIs and resolve siblings with `Uri.resolve`. Load converted assets by their original source path:

```dart
final model = await loadScene('assets/model.glb');
final color = await loadTexture('assets/color.png');
scene.add(model);
```

For a binary model that arrives at runtime, use `Node.fromGlbBytes(bytes)`. `Node.fromGlbAsset('assets/model.glb')` imports an asset at runtime when build-time conversion is not appropriate; declare it in `pubspec.yaml`. For a multi-file `.gltf`, use `Node.fromGltfBytes(gltfBytes, resolveUri: (uri) => fetchResource(baseUri.resolve(uri).toString()))` so its `.bin` and image siblings resolve relative to the `.gltf` URL. The current example keeps multi-file `.gltf` on this runtime path. These imports preserve the glTF node hierarchy, meshes, textures, and animations. Use the preprocessed path for shipped `.glb` content to avoid repeated parsing and GPU preparation.

`loadTexture` returns a `TextureSource`. Bind it to a material slot such as `PhysicallyBasedMaterial.baseColorTexture`; do not substitute a raw `gpu.Texture` for a `TextureSource`. glTF referenced textures import with the model. Use `TextureSampling` when the default trilinear-repeat sampling is unsuitable. Keep shared sources cached and call `releaseTexture` when their cache entry is no longer needed.

For built-in shapes, construct `Mesh(Geometry, Material)` after static resources are ready. Use `MeshGeometry` or `GeometryBuilder` for custom vertices and indices. Give `geometry.setCustomAttribute(name, values, components: count)` exactly one value per vertex when a `.fmat` vertex shader declares that attribute. A custom attribute used for displacement is not fetched in Scene's depth/shadow pass; use position and material parameters when displaced shadows must match.

## Animation

Read a loaded model's `parsedAnimations` or use `findAnimationByName`. Bind an animation to the model subtree with `createAnimationClip`, then `play()`. Clips own playback state. Use `loop`, `weight`, `playbackTime`, and `playbackTimeScale` for repeated motion, blending, scrubbing, and speed. Blend state changes by keeping clips active and changing their weights. `SceneModel` can instead take `SceneAnimationSpec` entries for declarative playback. Scene advances active clips each frame; do not add a second manual animation pump.

Keep a loading `ResourceGroup` for imperative model, texture, and environment futures when the first visible frame must be complete. Register loads before awaiting them. For declarative content, `SceneModel` loads and mounts the model and can take `SceneAnimationSpec` entries, a material `variant`, and scene-subtree `placeholder` and `error` builders. `SceneView.declarative` with `loadingBuilder` holds reveal until its `SceneModel` children load; `warmUp: true` compiles attached pipelines before reveal. Use per-model placeholders when the scene should appear incrementally.

## References

- [Assets and loading](sources/assets-and-loading.txt)
- [Geometry](sources/geometry.txt)
- [Animation](sources/animation.txt)
- [Declarative scenes and model loading](sources/declarative-scenes.txt)
- [Example build hook for models and loose textures](../examples/build-hook.txt)
- [Example runtime `.glb` and multi-file `.gltf` importer](../examples/stress-tests.txt)
- [Example imported animation](../examples/animation.txt)
