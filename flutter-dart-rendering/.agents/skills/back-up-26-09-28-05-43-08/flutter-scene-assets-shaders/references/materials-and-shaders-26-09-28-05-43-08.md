# Materials and shader binding

## Scene materials

Use `PhysicallyBasedMaterial` for lit surfaces. Its base color, metallic-roughness, normal, occlusion, and emissive slots take `TextureSource`. Match glTF channel semantics: roughness is green and metallic is blue in a metallic-roughness texture. Use `UnlitMaterial` for surfaces that should ignore lighting. `AlphaMode.opaque`, `mask`, and `blend` control opacity, cutouts, and sorted translucency. Imported `KHR_materials_variants` can be selected through `MaterialsVariantsComponent` or `SceneModel.variant` without reloading geometry.

For custom Scene shading, author an `assets/name.fmat` file with `material {}` metadata and a `fragment { void Surface(inout MaterialInputs material) { ... } }` block. Run the Scene build hook and load it with `loadFmatMaterial('assets/name.fmat')`. Assign the resulting `PreprocessedMaterial` to a mesh primitive. Declare typed parameters in `material { parameters: [...] }`; read scalar and vector values as `material_params.name` in GLSL and samplers by their declared names. Bind from Dart through `material.parameters.setFloat`, `setVec4`, `setColor`, or `setTexture` using the exact parameter name and type. `setColor` linearizes colors marked `source_color`. Use sampler defaults when a texture may be absent. Call `PrepareMaterial(material)` before `Surface()` returns.

Set `shading_model: lit` for engine lighting or `unlit` for final custom color. Optional `vertex { void Vertex(inout VertexInputs vertex) { ... } }` runs after skinning. Use declared `varyings` for vertex-to-fragment data and declared `attributes` for custom mesh data. Material `culling` and `blending` define render state. Drive a changing parameter from a `Component.update` or `SceneView.onTick`; retain the material instead of rebuilding it each frame.

Scene's material output is **linear HDR, premultiplied by alpha**. Do not tone-map or display-encode in the material. Convert sRGB texture samples to linear with `SRGBToLinear` when needed. The Scene resolve pass handles exposure and display encoding. `ShaderMaterial` is the lower-level Scene escape hatch: it uses a complete raw fragment shader and manual std140 uniform packing, and gives up `.fmat` type checking and automatic hot reload.

## Raw shader bundle in a Scene material

The current example app compiles named vertex and fragment shaders from `shaders/example.shaderbundle.json` with `buildTargetShaderBundleJson` in the shared `hook/build.dart`. In Scene code, import `package:flutter_scene/gpu.dart` as `gpu`, resolve the target bundle with `await gpu.resolveShaderBundleKey('example')`, and load it with `await gpu.loadShaderLibraryAsync(key)`. Select shaders by their manifest names and pass them to `ShaderMaterial(vertexShader: ..., fragmentShader: ...)`. Bind fragment blocks with `setUniformBlockFromFloats(name, values)` and vertex blocks with `setUniformBlock(name, bytes, stage: ShaderStage.vertex)`. Match the shader's std140 layout and stage exactly. This path keeps the mesh in Scene while the material owns raw shader stages.

## Direct Flutter GPU shaders

For an independent GPU pass, define named vertex and fragment shaders in a `.shaderbundle.json` manifest. Call `buildShaderBundleJson` from the project's shared `hook/build.dart`. Include the generated `.shaderbundle` in `flutter.assets`, or use `ShaderBundleAssetMode.dataAssetsIfAvailable` and its `flutterAssetKey`. Import `package:flutter_gpu/gpu.dart` as `gpu`; load with `await gpu.ShaderLibrary.fromAsset(assetKey)`, select shaders by manifest name, and create a pipeline with `gpu.gpuContext.createRenderPipeline(vertexShader, fragmentShader, vertexLayout: layout)`.

Get binding slots from `shader.getUniformSlot(name)`. Bind uniform `BufferView`s with `RenderPass.bindUniform` and textures with `RenderPass.bindTexture`, including a `SamplerOptions` when needed. The shader declaration, stage, slot name, buffer layout, texture format, and Dart binding must agree. Reuse shader libraries, pipelines, buffers, and textures. Keep per-frame work to updated data and pass encoding.

## References

- [Scene materials](https://fscene.dev/guides/materials/)
- [Scene custom materials](https://fscene.dev/guides/custom-materials/)
- [Scene ShaderMaterial API](https://fscene.dev/api/flutter_scene/latest/scene/ShaderMaterial-class.html)
- [Flutter GPU shader bundle builder](https://github.com/bdero/flutter_gpu_shaders)
- [Flutter GPU shader and render pass API](https://api.flutter.dev/flutter/flutter_gpu/)
- [Example bundle manifest](https://github.com/bdero/flutter_scene/blob/master/examples/flutter_app/shaders/example.shaderbundle.json)
- [Example raw Scene material and stage bindings](https://github.com/bdero/flutter_scene/blob/master/examples/flutter_app/lib/example_raw_shader.dart)
- [Example `.fmat` file and Dart binding](https://github.com/bdero/flutter_scene/blob/master/examples/flutter_app/assets/toon.fmat)
- [Example `.fmat` material assignment](https://github.com/bdero/flutter_scene/blob/master/examples/flutter_app/lib/example_toon_fmat.dart)
