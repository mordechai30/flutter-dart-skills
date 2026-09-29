# Assets and animation

## Import path

Use `dart run flutter_scene:init` once to set up Scene's build hook. Put shipped `.glb`, multi-buffer `.gltf` with its referenced buffers and images, `.fscene`, `.fmat`, and loose images under `assets/`. The hook preprocesses shipped models into `.fsceneb`, compiles materials, and prepares textures. Load by the original source path:

```dart
final model = await loadScene('assets/model.glb');
final color = await loadTexture('assets/color.png');
scene.add(model);
```

For a binary model that arrives at runtime, use `Node.fromGlbBytes(bytes)`. `Node.fromGlbAsset('assets/model.glb')` imports an asset at runtime when build-time conversion is not appropriate. Declare such an asset in `pubspec.yaml`. Both paths preserve the glTF node hierarchy, meshes, textures, and imported animations. Use the preprocessed path for content shipped with the app to avoid repeated glTF parsing and GPU preparation.

`loadTexture` returns a `TextureSource`. Bind it to a material slot such as `PhysicallyBasedMaterial.baseColorTexture`; do not substitute a raw `gpu.Texture` for a `TextureSource`. glTF referenced textures import with the model. Use `TextureSampling` when the default trilinear-repeat sampling is unsuitable. Keep shared sources cached and call `releaseTexture` when their cache entry is no longer needed.

For built-in shapes, construct `Mesh(Geometry, Material)` after static resources are ready. Use `MeshGeometry` or `GeometryBuilder` for custom vertices and indices. Give `geometry.setCustomAttribute(name, values, components: count)` exactly one value per vertex when a `.fmat` vertex shader declares that attribute. A custom attribute used for displacement is not fetched in Scene's depth/shadow pass; use position and material parameters when displaced shadows must match.

## Animation

Read a loaded model's `parsedAnimations` or use `findAnimationByName`. Bind an animation to the model subtree with `createAnimationClip`, then `play()`. Clips own playback state. Use `loop`, `weight`, `playbackTime`, and `playbackTimeScale` for repeated motion, blending, scrubbing, and speed. Blend state changes by keeping clips active and changing their weights. `SceneModel` can instead take `SceneAnimationSpec` entries for declarative playback. Scene advances active clips each frame; do not add a second manual animation pump.

Keep a loading `ResourceGroup` for model, texture, and environment futures when the first visible frame must be complete. Use `SceneView.loading` with a `loadingBuilder`, and `warmUp: true` to compile attached scene pipelines before reveal. Register loads before awaiting them.

## References

- [Assets and loading](https://fscene.dev/guides/assets-and-loading/)
- [Geometry](https://fscene.dev/guides/geometry/)
- [Animation](https://fscene.dev/guides/animation/)
