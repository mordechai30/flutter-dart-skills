---
name: flutter-scene-assets-shaders
description: Import and animate Scene geometry and textures; author current .fmat materials or Flutter GPU shader bundles; bind shader resources from Dart. Use for 3D assets, materials, and shaders.
---

# Scene assets and shaders

Choose the shader owner first. Use Scene's `.fmat` and `PreprocessedMaterial` for a managed Scene mesh. Use a compiled raw shader bundle with Scene's `ShaderMaterial` when a Scene mesh needs direct stage control. Use `package:flutter_gpu/gpu.dart` bindings when writing a direct GPU render pass. Each path has its own resource and uniform binding API.

- For glTF, textures, geometry, and animation, read [assets-and-animation.md](references/assets-and-animation.md).
- For `.fmat`, raw shaders, material binding, and color output, read [materials-and-shaders.md](references/materials-and-shaders.md).

Keep asset names, shader parameter names, vertex attribute names, and Dart bindings consistent. Load and create GPU resources outside per-frame code. Use the source path when loading Scene assets converted by its build hook.

After a build-hook, asset, material, or shader binding change, run `flutter analyze` and build the affected target. Open a small scene with the asset or material on each supported target and inspect the rendered result. Analysis alone cannot verify shader compilation, GPU bindings, or output pixels.
