---
name: flutter-gpu-scene-rendering
description: Build efficient Flutter GPU or flutter_scene render loops, including draw state, instancing, attachment formats, and off-screen render-to-texture output. Use for rendering pipelines and performance work.
---

# Rendering pipeline

Choose the owner of the render loop. `SceneView` owns Scene's scene graph, views, culling, post-processing, and texture targets. Direct Flutter GPU code owns resources, passes, bindings, and submission. Keep these workflows distinct.

- For direct GPU attachments, passes, presentation, and draw calls, read [flutter-gpu-pipeline.md](references/flutter-gpu-pipeline.md).
- For Scene batching, view management, profiling, and render textures, read [scene-pipeline.md](references/scene-pipeline.md).

Retain GPU resources across frames. Resize targets when output dimensions change. Measure GPU and CPU work before changing quality settings or draw organization.
