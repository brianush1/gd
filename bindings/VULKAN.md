# Vulkan bindings

`gd.bindings.vulkan_generated` is generated from Khronos `vk.xml`. It contains Vulkan
1.0 through 1.3 plus `VK_KHR_surface`, `VK_KHR_swapchain`, Xlib/Win32 surfaces, and
`VK_EXT_debug_utils`. Runtime builds use the checked-in D files and do not require a
Vulkan SDK.

The checked-in declarations use Vulkan-Headers 1.3.280 (`VK_HEADER_VERSION = 280`).
The corresponding `vk.xml` SHA-256 is
`3b894e0b5ec1ba23ae4ad2b1eca261461c8fef3a826c78f5f2af0a890f01ac24`.

From the GD root, regenerate with a Vulkan-Headers registry checkout (or the distro
registry directory):

```sh
python3 scripts/genvulkan.py /usr/share/vulkan/registry \
  bindings/source/gd/bindings/vulkan_generated \
  --packagePrefix gd.bindings.vulkan_generated
```

Do not hand-edit generated files. Loader and dispatch behavior belongs in
`gd.bindings.vulkan`.

## Window integration

`WindowInitOptions.graphicsBackend` defaults to `GraphicsBackend.OpenGL`.
Desktop callers that select `GraphicsBackend.Vulkan` get a normal X11 or Win32
window without GLX/WGL context setup or implicit buffer swaps. Query required
instance extensions through `Display.vulkanInstanceExtensions()`, then create a
caller-owned surface with `Window.createVulkanSurface(instance, allocator)`.
Context-current, context-sharing, swap-interval, and swap-buffer operations
reject Vulkan windows. Android remains on its existing GLES path.
