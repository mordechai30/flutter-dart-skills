# Materials and shader binding

## Scene materials

Use `PhysicallyBasedMaterial` for lit surfaces. Its base color, metallic-roughness, normal, occlusion, and emissive slots take `TextureSource`. Match glTF channel semantics: roughness is green and metallic is blue in a metallic-roughness texture. Use `UnlitMaterial` for surfaces that should ignore lighting. `AlphaMode.opaque`, `mask`, and `blend` control opacity, cutouts, and sorted translucency. Imported `KHR_materials_variants` can be selected through `MaterialsVariantsComponent` or `SceneModel.variant` without reloading geometry.

For custom Scene shading, author an `assets/name.fmat` file with `material {}` metadata and a `fragment { void Surface(inout MaterialInputs material) { ... } }` block. Run the Scene build hook and load it with `loadFmatMaterial('assets/name.fmat')`. Assign the resulting `PreprocessedMaterial` to a mesh primitive. Declare typed parameters in `material { parameters: [...] }`; read scalar and vector values as `material_params.name` in GLSL and samplers by their declared names. Bind from Dart through `material.parameters.setFloat`, `setVec4`, `setColor`, or `setTexture` using the exact parameter name and type. `setColor` linearizes colors marked `source_color`. Use sampler defaults when a texture may be absent. Call `PrepareMaterial(material)` before `Surface()` returns.

Set `shading_model: lit` for engine lighting or `unlit` for final custom color. Optional `vertex { void Vertex(inout VertexInputs vertex) { ... } }` runs after skinning. Use declared `varyings` for vertex-to-fragment data and declared `attributes` for custom mesh data. Material `culling` and `blending` define render state. Drive a changing parameter from a `Component.update` or `SceneView.onTick`; retain the material instead of rebuilding it each frame.

Scene's material output is **linear HDR, premultiplied by alpha**. Do not tone-map or display-encode in the material. Convert sRGB texture samples to linear with `SRGBToLinear` when needed. The Scene resolve pass handles exposure and display encoding. `ShaderMaterial` is the lower-level Scene escape hatch: it uses a complete raw fragment shader and manual std140 uniform packing, and gives up `.fmat` type checking and automatic hot reload.

## Direct Flutter GPU shaders

For raw GPU passes, define named vertex and fragment shaders in a `.shaderbundle.json` manifest. Call `buildShaderBundleJson` from the project's `hook/build.dart`, coordinating it with Scene's hook if both are present. Include the generated `.shaderbundle` in `flutter.assets`, or use `ShaderBundleAssetMode.dataAssetsIfAvailable` and the returned `flutterAssetKey` when DataAssets are supported. Load with `await gpu.ShaderLibrary.fromAsset(assetKey)`, select shaders by manifest name, and create a pipeline with `gpu.gpuContext.createRenderPipeline(vertexShader, fragmentShader, vertexLayout: layout)`.

Get binding slots from `shader.getUniformSlot(name)`. Bind uniform `BufferView`s with `RenderPass.bindUniform` and textures with `RenderPass.bindTexture`, including a `SamplerOptions` when needed. The shader declaration, stage, slot name, buffer layout, texture format, and Dart binding must agree. Reuse shader libraries, pipelines, buffers, and textures. Keep per-frame work to updated data and pass encoding.

## References

- [Scene materials](https://fscene.dev/guides/materials/)
- [Scene custom materials](https://fscene.dev/guides/custom-materials/)
- [Scene 0.22.1 ShaderMaterial API](https://fscene.dev/api/flutter_scene/0.22.1/scene/ShaderMaterial-class.html)
- [Flutter GPU shader bundle builder](https://github.com/bdero/flutter_gpu_shaders)
- [Flutter GPU shader and render pass API](https://api.flutter.dev/flutter/flutter_gpu/)
