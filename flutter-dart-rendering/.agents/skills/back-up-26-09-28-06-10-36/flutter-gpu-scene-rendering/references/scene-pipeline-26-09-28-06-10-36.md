# Scene pipeline and render textures

## Efficient scene frames

Retain `Scene`, nodes, geometries, materials, and components across frames. Use `SceneView.declarative` for state-driven structure and moderate animation. `setState`, `AnimatedBuilder`, or `TweenAnimationBuilder` can change declared transforms, visibility, or materials; reconciliation writes changed properties to retained nodes. Keep geometry and material instances stable, use keys for reordered children, and keep component instances stable because the `components` list is diffed by identity. Use `Component.update` for self-running motion and `fixedUpdate` for fixed-step behavior. Use an app-owned `Scene` and imperative `Node` mutation for procedural content, streaming, or bulk per-frame updates.

The view owns the scene created by `SceneView.declarative`; app state owns a `Scene` passed to `SceneView(scene)`. Compose styles per subtree: `SceneNodeHost` mounts an app-owned node in a declarative tree, `SceneSubtree` mounts declarative children under an app-owned node, and `SceneNodeController` exposes a widget-managed node for queries. A widget owns the properties it declares; an imperative write to one of those properties is replaced on the next rebuild. Put independent motion in a component or an app-owned subtree.

Reuse geometry and material instances for repeated content. Scene provides instanced rendering, model LOD, import-time mesh chunking, and view culling. Keep transparency and material variants only where needed because they affect draw grouping. Use `SceneView.warmUp` and a `ResourceGroup` before first reveal when pipeline compilation or uploads would interrupt a visible frame. For a GPU-bound scene, change `scene.renderScale` or a `RenderView.renderScale` override after measuring; select `scene.antiAliasingMode` based on quality and backend support. `effectiveAntiAliasingMode` reports the actual mode.

Run with `--dart-define=FLUTTER_SCENE_PROFILE=true` to inspect 120-frame summaries of render graph, culling, encoding, instance packing, bindings, bytes, draws, and instances. Use the counters to decide whether to reduce objects, material changes, resolution, or effects. For CPU analysis, the example stress benchmark separates mutation, update, BVH, and render time; compare profile-mode runs after warm-up.

## Scene off-screen output

Create `RenderTexture(width: ..., height: ...)` in physical pixels. Add `RenderView(camera: camera, target: renderTexture)` to `scene.views`; the scene renders it when the scene renders. Display the result with `RenderTextureView(renderTexture)`, or bind the `RenderTexture` itself to a Scene material texture slot. It implements `TextureSource`; keep the handle rather than caching its backing `gpu.Texture`. Use `RenderTextureView(followLayout: true)` when the target should track the widget's physical size; otherwise call `renderTexture.resize(width, height)` when needed.

The result is the display-referred premultiplied image after Scene's tone mapping and anti-aliasing. Set the target's `update` policy to match its content. The example minimap uses `RenderTextureUpdate.interval(Duration(milliseconds: 500))`; with manual updates, call `requestUpdate()` for the next scene frame. `RenderView.order` controls composition. Texture-target views render before screen views. A consumer drawn after the producing view sees the latest completed frame; a feedback view samples the previous completed frame. The engine owns a small ring of GPU textures so new renders do not overwrite frames still in use.

For multiple views, set `RenderView.camera`, `target`, normalized `viewport`, `layerMask`, and `order` deliberately. Use a small target for a minimap or monitor, and a full-size target only when the output needs it. Off-screen work adds render cost; profile it alongside the screen view.

## References

- [Scene core concepts](https://fscene.dev/getting-started/core-concepts/)
- [Scene declarative ownership and updates](https://fscene.dev/guides/declarative-scenes/)
- [Scene RenderTexture API](https://fscene.dev/api/flutter_scene/latest/scene/RenderTexture-class.html)
- [Scene RenderView API](https://fscene.dev/api/flutter_scene/latest/scene/RenderView-class.html)
- [Scene RenderTextureView API](https://fscene.dev/api/flutter_scene/latest/scene/RenderTextureView-class.html)
- [Scene post-processing and render scale](https://fscene.dev/guides/post-processing/)
- [Example render target and minimap](https://github.com/bdero/flutter_scene/blob/master/examples/flutter_app/lib/example_render_target.dart)
- [Example declarative scene state](https://github.com/bdero/flutter_scene/blob/master/examples/flutter_app/lib/example_configurator.dart)
- [Example CPU stress benchmark](https://github.com/bdero/flutter_scene/blob/master/examples/stress_bench/README.md)
