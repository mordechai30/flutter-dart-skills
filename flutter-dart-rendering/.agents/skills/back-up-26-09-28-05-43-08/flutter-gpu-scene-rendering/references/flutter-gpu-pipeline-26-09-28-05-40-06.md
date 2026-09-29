# Direct Flutter GPU pipeline

## Frame and draw state

Use `gpu.gpuContext` to create textures, device buffers, shader pipelines, and command buffers. Create stable geometry buffers, `ShaderLibrary`, `RenderPipeline`, and textures once. For each frame, update only changing buffer ranges, create a command buffer, create a render pass from a `RenderTarget`, bind pipeline, buffers, uniforms, and textures, issue draws, then submit. Group draws with the same pipeline and material state. Avoid redundant state changes and allocations inside the draw loop.

Use `VertexLayout` with `VertexBuffer` descriptions. Put mesh attributes in buffers with `VertexStepMode.vertex`. Put per-object transform or tint data in a buffer with `VertexStepMode.instance`, bind it at its layout slot, and call `draw` or `drawIndexed` with `instanceCount` for repeated geometry. An instance draw shares one pipeline and vertex/index geometry while the instance-rate buffer advances once per instance. Use one draw only when the objects share compatible render state and resources; split batches when material bindings differ.

## Off-screen render target

1. Choose physical dimensions and a `PixelFormat`. Check `gpuContext.supportsTextureFormat(format, renderTarget: true, shaderRead: true)` before relying on an optional format. RGBA8 is suitable for a display-referred color target; `r16g16b16a16Float` is suitable for a supported linear HDR intermediate. Use a supported depth/stencil format from `gpuContext.defaultDepthStencilFormat` or `defaultStencilFormat` when depth or stencil is needed.
2. Allocate a color texture with `createTexture(..., enableRenderTargetUsage: true, enableShaderReadUsage: true)`. Match depth/stencil texture dimensions and sample count. Attach with `ColorAttachment(texture: color, loadAction: LoadAction.clear, storeAction: StoreAction.store)` and optional `DepthStencilAttachment(texture: depth)`. Use `RenderTarget.singleColor` or a list of color attachments, then `commandBuffer.createRenderPass(target)`.
3. Encode pipeline state, viewport/scissor, bindings, and draws. Submit the command buffer. A later pass can sample the completed color attachment. Never sample a texture while the same pass writes it. Use separate intermediate textures for multi-pass effects or feedback.
4. For MSAA, render to a multisample color texture and set a single-sample `resolveTexture` on the color attachment. Check `gpuContext.doesSupportOffscreenMSAA`; keep all attachments compatible in dimensions, sample count, and mip level. Sample the resolved texture after the pass. Use `StoreAction` and `LoadAction` according to whether later work must read earlier contents.

For a Flutter `ui.Image` updated repeatedly, use `gpuContext.createImageSurface(width, height, format: ...)`. Acquire a frame, render into its `colorTexture`, call `frame.present(commandBuffer)` with the final writes, submit that buffer, then draw `surface.currentImage`. The image surface manages backing textures so presentation does not race a later frame. Keep ordinary depth, MSAA, and post-process targets separate. A `Texture.asImage()` is available for a texture, but a `GpuImageSurface` is the dedicated repeated-presentation path.

## References

- [GPU context and texture capabilities](https://api.flutter.dev/flutter/flutter_gpu/GpuContext-class.html)
- [Render target and attachments](https://api.flutter.dev/flutter/flutter_gpu/RenderTarget-class.html)
- [Color attachment](https://api.flutter.dev/flutter/flutter_gpu/ColorAttachment-class.html)
- [Depth/stencil attachment](https://api.flutter.dev/flutter/flutter_gpu/DepthStencilAttachment-class.html)
- [Command buffer and render pass](https://api.flutter.dev/flutter/flutter_gpu/CommandBuffer-class.html)
- [Image surface](https://api.flutter.dev/flutter/flutter_gpu/GpuImageSurface-class.html)
- [Instance step mode](https://api.flutter.dev/flutter/flutter_gpu/VertexStepMode.html)
