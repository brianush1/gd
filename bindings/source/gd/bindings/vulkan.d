module gd.bindings.vulkan;

public import gd.bindings.vulkan_generated;

private import generated = gd.bindings.vulkan_generated.functions;
import std.string : toStringz;
import std.traits : isSomeFunction;

static assert(VkBool32.sizeof == 4);
static assert(VkDeviceSize.sizeof == 8);
static assert(VkAccessFlags2.sizeof == 8);
static assert(VkPipelineStageFlags2.sizeof == 8);
static assert(VkFormatFeatureFlags2.sizeof == 8);
static assert(VkExtent2D.sizeof == 8);
version (D_LP64) {
	static assert(VkInstance.sizeof == 8);
	static assert(VkSurfaceKHR.sizeof == 8);
	static assert(VkApplicationInfo.sizeof == 48);
	static assert(VkInstanceCreateInfo.sizeof == 64);
	static assert(VkAllocationCallbacks.sizeof == 48);
	static assert(VkMemoryBarrier2.sizeof == 48);
	static assert(VkMemoryBarrier2.dstAccessMask.offsetof == 40);
	static assert(VkBufferMemoryBarrier2.sizeof == 80);
	static assert(VkImageMemoryBarrier2.sizeof == 96);
	static assert(VkImageMemoryBarrier2.image.offsetof == 64);
	static assert(VkFormatProperties3.sizeof == 40);
}
version (gd_X11Impl) static assert(VkXlibSurfaceCreateInfoKHR.sizeof == 40);
version (gd_Win32) static assert(VkWin32SurfaceCreateInfoKHR.sizeof == 40);

final class VulkanLoaderException : Exception {
	this(string message, string file = __FILE__, size_t line = __LINE__) {
		super(message, file, line);
	}
}

struct VulkanGlobalDispatch {
	PFN_vkGetInstanceProcAddr vkGetInstanceProcAddr;
	PFN_vkCreateInstance vkCreateInstance;
	PFN_vkEnumerateInstanceExtensionProperties vkEnumerateInstanceExtensionProperties;
	PFN_vkEnumerateInstanceLayerProperties vkEnumerateInstanceLayerProperties;
	PFN_vkEnumerateInstanceVersion vkEnumerateInstanceVersion;

	VulkanInstanceDispatch loadInstance(VkInstance instance) const {
		return loadVulkanInstanceDispatch(instance, vkGetInstanceProcAddr);
	}
}

struct VulkanInstanceDispatch {
	VkInstance instance;

	PFN_vkGetInstanceProcAddr vkGetInstanceProcAddr;
	PFN_vkDestroyInstance vkDestroyInstance;
	PFN_vkEnumeratePhysicalDevices vkEnumeratePhysicalDevices;
	PFN_vkGetPhysicalDeviceFeatures vkGetPhysicalDeviceFeatures;
	PFN_vkGetPhysicalDeviceFormatProperties vkGetPhysicalDeviceFormatProperties;
	PFN_vkGetPhysicalDeviceImageFormatProperties vkGetPhysicalDeviceImageFormatProperties;
	PFN_vkGetPhysicalDeviceProperties vkGetPhysicalDeviceProperties;
	PFN_vkGetPhysicalDeviceQueueFamilyProperties vkGetPhysicalDeviceQueueFamilyProperties;
	PFN_vkGetPhysicalDeviceMemoryProperties vkGetPhysicalDeviceMemoryProperties;
	PFN_vkGetDeviceProcAddr vkGetDeviceProcAddr;
	PFN_vkCreateDevice vkCreateDevice;
	PFN_vkEnumerateDeviceExtensionProperties vkEnumerateDeviceExtensionProperties;
	PFN_vkEnumerateDeviceLayerProperties vkEnumerateDeviceLayerProperties;
	PFN_vkGetPhysicalDeviceSparseImageFormatProperties vkGetPhysicalDeviceSparseImageFormatProperties;

	PFN_vkEnumeratePhysicalDeviceGroups vkEnumeratePhysicalDeviceGroups;
	PFN_vkGetPhysicalDeviceFeatures2 vkGetPhysicalDeviceFeatures2;
	PFN_vkGetPhysicalDeviceProperties2 vkGetPhysicalDeviceProperties2;
	PFN_vkGetPhysicalDeviceFormatProperties2 vkGetPhysicalDeviceFormatProperties2;
	PFN_vkGetPhysicalDeviceImageFormatProperties2 vkGetPhysicalDeviceImageFormatProperties2;
	PFN_vkGetPhysicalDeviceQueueFamilyProperties2 vkGetPhysicalDeviceQueueFamilyProperties2;
	PFN_vkGetPhysicalDeviceMemoryProperties2 vkGetPhysicalDeviceMemoryProperties2;
	PFN_vkGetPhysicalDeviceSparseImageFormatProperties2 vkGetPhysicalDeviceSparseImageFormatProperties2;
	PFN_vkGetPhysicalDeviceExternalBufferProperties vkGetPhysicalDeviceExternalBufferProperties;
	PFN_vkGetPhysicalDeviceExternalFenceProperties vkGetPhysicalDeviceExternalFenceProperties;
	PFN_vkGetPhysicalDeviceExternalSemaphoreProperties vkGetPhysicalDeviceExternalSemaphoreProperties;
	PFN_vkGetPhysicalDeviceToolProperties vkGetPhysicalDeviceToolProperties;

	PFN_vkDestroySurfaceKHR vkDestroySurfaceKHR;
	PFN_vkGetPhysicalDeviceSurfaceSupportKHR vkGetPhysicalDeviceSurfaceSupportKHR;
	PFN_vkGetPhysicalDeviceSurfaceCapabilitiesKHR vkGetPhysicalDeviceSurfaceCapabilitiesKHR;
	PFN_vkGetPhysicalDeviceSurfaceFormatsKHR vkGetPhysicalDeviceSurfaceFormatsKHR;
	PFN_vkGetPhysicalDeviceSurfacePresentModesKHR vkGetPhysicalDeviceSurfacePresentModesKHR;
	PFN_vkGetPhysicalDevicePresentRectanglesKHR vkGetPhysicalDevicePresentRectanglesKHR;

	version (gd_X11Impl) {
		PFN_vkCreateXlibSurfaceKHR vkCreateXlibSurfaceKHR;
		PFN_vkGetPhysicalDeviceXlibPresentationSupportKHR vkGetPhysicalDeviceXlibPresentationSupportKHR;
	}

	version (gd_Win32) {
		PFN_vkCreateWin32SurfaceKHR vkCreateWin32SurfaceKHR;
		PFN_vkGetPhysicalDeviceWin32PresentationSupportKHR vkGetPhysicalDeviceWin32PresentationSupportKHR;
	}

	PFN_vkCreateDebugUtilsMessengerEXT vkCreateDebugUtilsMessengerEXT;
	PFN_vkDestroyDebugUtilsMessengerEXT vkDestroyDebugUtilsMessengerEXT;
	PFN_vkSubmitDebugUtilsMessageEXT vkSubmitDebugUtilsMessageEXT;

	VulkanDeviceDispatch loadDevice(VkDevice device) const {
		if (device is null)
			throw new VulkanLoaderException("cannot load Vulkan device dispatch for a null device");
		if (vkGetDeviceProcAddr is null)
			throw new VulkanLoaderException("cannot load Vulkan device dispatch without vkGetDeviceProcAddr");
		synchronized (VulkanLoaderLock.classinfo) {
			generated.vkGetDeviceProcAddr = vkGetDeviceProcAddr;
			return VulkanDeviceDispatch(device);
		}
	}
}

alias VulkanDeviceDispatch = generated.DispatchDevice;

private {
	final class VulkanLoaderLock {}

	// Dispatch tables outlive individual windows, so keep the loader open until process exit.
	__gshared void* vulkanLibrary;
	__gshared VulkanGlobalDispatch globalDispatch;
	__gshared bool globalDispatchLoaded;

	void* loadVulkanLibrary() {
		version (Posix) {
			import core.sys.posix.dlfcn : dlopen, RTLD_LOCAL, RTLD_NOW;

			foreach (name; ["libvulkan.so.1", "libvulkan.so"]) {
				if (void* library = dlopen(name.toStringz, RTLD_NOW | RTLD_LOCAL)) {
					return library;
				}
			}
		}
		else version (Windows) {
			import core.sys.windows.windows : LoadLibraryW;

			return cast(void*) LoadLibraryW("vulkan-1.dll"w.ptr);
		}
		else {
			static assert(0, "Vulkan loader is unsupported on this platform");
		}

		return null;
	}

	void* loadVulkanSymbol(void* library, const(char)* name) {
		version (Posix) {
			import core.sys.posix.dlfcn : dlsym;
			return dlsym(library, name);
		}
		else version (Windows) {
			import core.sys.windows.windows : GetProcAddress, HMODULE;
			return cast(void*) GetProcAddress(cast(HMODULE) library, name);
		}
		else {
			static assert(0, "Vulkan loader is unsupported on this platform");
		}
	}

}

VulkanGlobalDispatch loadVulkanGlobalDispatch() {
	synchronized (VulkanLoaderLock.classinfo) {
		if (globalDispatchLoaded) {
			return globalDispatch;
		}

		vulkanLibrary = loadVulkanLibrary();
		if (vulkanLibrary is null) {
			throw new VulkanLoaderException(
				"could not load the Vulkan loader (tried libvulkan.so.1/libvulkan.so or vulkan-1.dll)");
		}

		auto getProcAddr = cast(PFN_vkGetInstanceProcAddr)
			loadVulkanSymbol(vulkanLibrary, "vkGetInstanceProcAddr");
		if (getProcAddr is null) {
			throw new VulkanLoaderException("Vulkan loader does not export vkGetInstanceProcAddr");
		}

		generated.loadGlobalLevelFunctions(getProcAddr);
		globalDispatch.vkGetInstanceProcAddr = getProcAddr;
		globalDispatch.vkCreateInstance = generated.vkCreateInstance;
		globalDispatch.vkEnumerateInstanceExtensionProperties =
			generated.vkEnumerateInstanceExtensionProperties;
		globalDispatch.vkEnumerateInstanceLayerProperties = generated.vkEnumerateInstanceLayerProperties;
		globalDispatch.vkEnumerateInstanceVersion = cast(PFN_vkEnumerateInstanceVersion)
			getProcAddr(null, "vkEnumerateInstanceVersion");

		if (globalDispatch.vkCreateInstance is null
			|| globalDispatch.vkEnumerateInstanceExtensionProperties is null
			|| globalDispatch.vkEnumerateInstanceLayerProperties is null) {
			throw new VulkanLoaderException("Vulkan loader is missing required global entry points");
		}

		globalDispatchLoaded = true;
		return globalDispatch;
	}
}

private VulkanInstanceDispatch loadVulkanInstanceDispatch(
	VkInstance instance, PFN_vkGetInstanceProcAddr getProcAddr
) {
	if (instance is null) {
		throw new VulkanLoaderException("cannot load Vulkan instance dispatch for a null instance");
	}
	if (getProcAddr is null) {
		throw new VulkanLoaderException("cannot load Vulkan instance dispatch without vkGetInstanceProcAddr");
	}

	VulkanInstanceDispatch result;
	result.instance = instance;
	result.vkGetInstanceProcAddr = getProcAddr;

	static foreach (member; __traits(allMembers, VulkanInstanceDispatch)) {
		static if (member != "instance" && member != "vkGetInstanceProcAddr"
			&& member != "loadDevice" && member != "opAssign" && member != "__ctor") {
			static if (isSomeFunction!(__traits(getMember, result, member))) {
				*cast(void**) &__traits(getMember, result, member) =
					cast(void*) getProcAddr(instance, member.toStringz);
			}
		}
	}

	if (result.vkDestroyInstance is null || result.vkEnumeratePhysicalDevices is null
		|| result.vkCreateDevice is null || result.vkGetDeviceProcAddr is null) {
		throw new VulkanLoaderException("Vulkan instance is missing required core entry points");
	}

	return result;
}
