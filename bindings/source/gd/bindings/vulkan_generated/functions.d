// Generated from the Khronos Vulkan API registry. Do not edit.
// Copyright 2015-2024 The Khronos Group Inc.
// SPDX-License-Identifier: Apache-2.0 OR MIT

module gd.bindings.vulkan_generated.functions;

public import gd.bindings.vulkan_generated.types;

extern( System ) @nogc nothrow {

	// VK_VERSION_1_0
	alias PFN_vkCreateInstance = VkResult function( const( VkInstanceCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkInstance* pInstance );
	alias PFN_vkDestroyInstance = void function( VkInstance instance, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkEnumeratePhysicalDevices = VkResult function( VkInstance instance, uint32_t* pPhysicalDeviceCount, VkPhysicalDevice* pPhysicalDevices );
	alias PFN_vkGetPhysicalDeviceFeatures = void function( VkPhysicalDevice physicalDevice, VkPhysicalDeviceFeatures* pFeatures );
	alias PFN_vkGetPhysicalDeviceFormatProperties = void function( VkPhysicalDevice physicalDevice, VkFormat format, VkFormatProperties* pFormatProperties );
	alias PFN_vkGetPhysicalDeviceImageFormatProperties = VkResult function( VkPhysicalDevice physicalDevice, VkFormat format, VkImageType type, VkImageTiling tiling, VkImageUsageFlags usage, VkImageCreateFlags flags, VkImageFormatProperties* pImageFormatProperties );
	alias PFN_vkGetPhysicalDeviceProperties = void function( VkPhysicalDevice physicalDevice, VkPhysicalDeviceProperties* pProperties );
	alias PFN_vkGetPhysicalDeviceQueueFamilyProperties = void function( VkPhysicalDevice physicalDevice, uint32_t* pQueueFamilyPropertyCount, VkQueueFamilyProperties* pQueueFamilyProperties );
	alias PFN_vkGetPhysicalDeviceMemoryProperties = void function( VkPhysicalDevice physicalDevice, VkPhysicalDeviceMemoryProperties* pMemoryProperties );
	alias PFN_vkGetInstanceProcAddr = PFN_vkVoidFunction function( VkInstance instance, const( char )* pName );
	alias PFN_vkGetDeviceProcAddr = PFN_vkVoidFunction function( VkDevice device, const( char )* pName );
	alias PFN_vkCreateDevice = VkResult function( VkPhysicalDevice physicalDevice, const( VkDeviceCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkDevice* pDevice );
	alias PFN_vkDestroyDevice = void function( VkDevice device, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkEnumerateInstanceExtensionProperties = VkResult function( const( char )* pLayerName, uint32_t* pPropertyCount, VkExtensionProperties* pProperties );
	alias PFN_vkEnumerateDeviceExtensionProperties = VkResult function( VkPhysicalDevice physicalDevice, const( char )* pLayerName, uint32_t* pPropertyCount, VkExtensionProperties* pProperties );
	alias PFN_vkEnumerateInstanceLayerProperties = VkResult function( uint32_t* pPropertyCount, VkLayerProperties* pProperties );
	alias PFN_vkEnumerateDeviceLayerProperties = VkResult function( VkPhysicalDevice physicalDevice, uint32_t* pPropertyCount, VkLayerProperties* pProperties );
	alias PFN_vkGetDeviceQueue = void function( VkDevice device, uint32_t queueFamilyIndex, uint32_t queueIndex, VkQueue* pQueue );
	alias PFN_vkQueueSubmit = VkResult function( VkQueue queue, uint32_t submitCount, const( VkSubmitInfo )* pSubmits, VkFence fence );
	alias PFN_vkQueueWaitIdle = VkResult function( VkQueue queue );
	alias PFN_vkDeviceWaitIdle = VkResult function( VkDevice device );
	alias PFN_vkAllocateMemory = VkResult function( VkDevice device, const( VkMemoryAllocateInfo )* pAllocateInfo, const( VkAllocationCallbacks )* pAllocator, VkDeviceMemory* pMemory );
	alias PFN_vkFreeMemory = void function( VkDevice device, VkDeviceMemory memory, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkMapMemory = VkResult function( VkDevice device, VkDeviceMemory memory, VkDeviceSize offset, VkDeviceSize size, VkMemoryMapFlags flags, void** ppData );
	alias PFN_vkUnmapMemory = void function( VkDevice device, VkDeviceMemory memory );
	alias PFN_vkFlushMappedMemoryRanges = VkResult function( VkDevice device, uint32_t memoryRangeCount, const( VkMappedMemoryRange )* pMemoryRanges );
	alias PFN_vkInvalidateMappedMemoryRanges = VkResult function( VkDevice device, uint32_t memoryRangeCount, const( VkMappedMemoryRange )* pMemoryRanges );
	alias PFN_vkGetDeviceMemoryCommitment = void function( VkDevice device, VkDeviceMemory memory, VkDeviceSize* pCommittedMemoryInBytes );
	alias PFN_vkBindBufferMemory = VkResult function( VkDevice device, VkBuffer buffer, VkDeviceMemory memory, VkDeviceSize memoryOffset );
	alias PFN_vkBindImageMemory = VkResult function( VkDevice device, VkImage image, VkDeviceMemory memory, VkDeviceSize memoryOffset );
	alias PFN_vkGetBufferMemoryRequirements = void function( VkDevice device, VkBuffer buffer, VkMemoryRequirements* pMemoryRequirements );
	alias PFN_vkGetImageMemoryRequirements = void function( VkDevice device, VkImage image, VkMemoryRequirements* pMemoryRequirements );
	alias PFN_vkGetImageSparseMemoryRequirements = void function( VkDevice device, VkImage image, uint32_t* pSparseMemoryRequirementCount, VkSparseImageMemoryRequirements* pSparseMemoryRequirements );
	alias PFN_vkGetPhysicalDeviceSparseImageFormatProperties = void function( VkPhysicalDevice physicalDevice, VkFormat format, VkImageType type, VkSampleCountFlagBits samples, VkImageUsageFlags usage, VkImageTiling tiling, uint32_t* pPropertyCount, VkSparseImageFormatProperties* pProperties );
	alias PFN_vkQueueBindSparse = VkResult function( VkQueue queue, uint32_t bindInfoCount, const( VkBindSparseInfo )* pBindInfo, VkFence fence );
	alias PFN_vkCreateFence = VkResult function( VkDevice device, const( VkFenceCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkFence* pFence );
	alias PFN_vkDestroyFence = void function( VkDevice device, VkFence fence, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkResetFences = VkResult function( VkDevice device, uint32_t fenceCount, const( VkFence )* pFences );
	alias PFN_vkGetFenceStatus = VkResult function( VkDevice device, VkFence fence );
	alias PFN_vkWaitForFences = VkResult function( VkDevice device, uint32_t fenceCount, const( VkFence )* pFences, VkBool32 waitAll, uint64_t timeout );
	alias PFN_vkCreateSemaphore = VkResult function( VkDevice device, const( VkSemaphoreCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSemaphore* pSemaphore );
	alias PFN_vkDestroySemaphore = void function( VkDevice device, VkSemaphore semaphore, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkCreateEvent = VkResult function( VkDevice device, const( VkEventCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkEvent* pEvent );
	alias PFN_vkDestroyEvent = void function( VkDevice device, VkEvent event, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkGetEventStatus = VkResult function( VkDevice device, VkEvent event );
	alias PFN_vkSetEvent = VkResult function( VkDevice device, VkEvent event );
	alias PFN_vkResetEvent = VkResult function( VkDevice device, VkEvent event );
	alias PFN_vkCreateQueryPool = VkResult function( VkDevice device, const( VkQueryPoolCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkQueryPool* pQueryPool );
	alias PFN_vkDestroyQueryPool = void function( VkDevice device, VkQueryPool queryPool, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkGetQueryPoolResults = VkResult function( VkDevice device, VkQueryPool queryPool, uint32_t firstQuery, uint32_t queryCount, size_t dataSize, void* pData, VkDeviceSize stride, VkQueryResultFlags flags );
	alias PFN_vkCreateBuffer = VkResult function( VkDevice device, const( VkBufferCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkBuffer* pBuffer );
	alias PFN_vkDestroyBuffer = void function( VkDevice device, VkBuffer buffer, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkCreateBufferView = VkResult function( VkDevice device, const( VkBufferViewCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkBufferView* pView );
	alias PFN_vkDestroyBufferView = void function( VkDevice device, VkBufferView bufferView, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkCreateImage = VkResult function( VkDevice device, const( VkImageCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkImage* pImage );
	alias PFN_vkDestroyImage = void function( VkDevice device, VkImage image, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkGetImageSubresourceLayout = void function( VkDevice device, VkImage image, const( VkImageSubresource )* pSubresource, VkSubresourceLayout* pLayout );
	alias PFN_vkCreateImageView = VkResult function( VkDevice device, const( VkImageViewCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkImageView* pView );
	alias PFN_vkDestroyImageView = void function( VkDevice device, VkImageView imageView, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkCreateShaderModule = VkResult function( VkDevice device, const( VkShaderModuleCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkShaderModule* pShaderModule );
	alias PFN_vkDestroyShaderModule = void function( VkDevice device, VkShaderModule shaderModule, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkCreatePipelineCache = VkResult function( VkDevice device, const( VkPipelineCacheCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkPipelineCache* pPipelineCache );
	alias PFN_vkDestroyPipelineCache = void function( VkDevice device, VkPipelineCache pipelineCache, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkGetPipelineCacheData = VkResult function( VkDevice device, VkPipelineCache pipelineCache, size_t* pDataSize, void* pData );
	alias PFN_vkMergePipelineCaches = VkResult function( VkDevice device, VkPipelineCache dstCache, uint32_t srcCacheCount, const( VkPipelineCache )* pSrcCaches );
	alias PFN_vkCreateGraphicsPipelines = VkResult function( VkDevice device, VkPipelineCache pipelineCache, uint32_t createInfoCount, const( VkGraphicsPipelineCreateInfo )* pCreateInfos, const( VkAllocationCallbacks )* pAllocator, VkPipeline* pPipelines );
	alias PFN_vkCreateComputePipelines = VkResult function( VkDevice device, VkPipelineCache pipelineCache, uint32_t createInfoCount, const( VkComputePipelineCreateInfo )* pCreateInfos, const( VkAllocationCallbacks )* pAllocator, VkPipeline* pPipelines );
	alias PFN_vkDestroyPipeline = void function( VkDevice device, VkPipeline pipeline, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkCreatePipelineLayout = VkResult function( VkDevice device, const( VkPipelineLayoutCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkPipelineLayout* pPipelineLayout );
	alias PFN_vkDestroyPipelineLayout = void function( VkDevice device, VkPipelineLayout pipelineLayout, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkCreateSampler = VkResult function( VkDevice device, const( VkSamplerCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSampler* pSampler );
	alias PFN_vkDestroySampler = void function( VkDevice device, VkSampler sampler, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkCreateDescriptorSetLayout = VkResult function( VkDevice device, const( VkDescriptorSetLayoutCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkDescriptorSetLayout* pSetLayout );
	alias PFN_vkDestroyDescriptorSetLayout = void function( VkDevice device, VkDescriptorSetLayout descriptorSetLayout, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkCreateDescriptorPool = VkResult function( VkDevice device, const( VkDescriptorPoolCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkDescriptorPool* pDescriptorPool );
	alias PFN_vkDestroyDescriptorPool = void function( VkDevice device, VkDescriptorPool descriptorPool, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkResetDescriptorPool = VkResult function( VkDevice device, VkDescriptorPool descriptorPool, VkDescriptorPoolResetFlags flags );
	alias PFN_vkAllocateDescriptorSets = VkResult function( VkDevice device, const( VkDescriptorSetAllocateInfo )* pAllocateInfo, VkDescriptorSet* pDescriptorSets );
	alias PFN_vkFreeDescriptorSets = VkResult function( VkDevice device, VkDescriptorPool descriptorPool, uint32_t descriptorSetCount, const( VkDescriptorSet )* pDescriptorSets );
	alias PFN_vkUpdateDescriptorSets = void function( VkDevice device, uint32_t descriptorWriteCount, const( VkWriteDescriptorSet )* pDescriptorWrites, uint32_t descriptorCopyCount, const( VkCopyDescriptorSet )* pDescriptorCopies );
	alias PFN_vkCreateFramebuffer = VkResult function( VkDevice device, const( VkFramebufferCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkFramebuffer* pFramebuffer );
	alias PFN_vkDestroyFramebuffer = void function( VkDevice device, VkFramebuffer framebuffer, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkCreateRenderPass = VkResult function( VkDevice device, const( VkRenderPassCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkRenderPass* pRenderPass );
	alias PFN_vkDestroyRenderPass = void function( VkDevice device, VkRenderPass renderPass, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkGetRenderAreaGranularity = void function( VkDevice device, VkRenderPass renderPass, VkExtent2D* pGranularity );
	alias PFN_vkCreateCommandPool = VkResult function( VkDevice device, const( VkCommandPoolCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkCommandPool* pCommandPool );
	alias PFN_vkDestroyCommandPool = void function( VkDevice device, VkCommandPool commandPool, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkResetCommandPool = VkResult function( VkDevice device, VkCommandPool commandPool, VkCommandPoolResetFlags flags );
	alias PFN_vkAllocateCommandBuffers = VkResult function( VkDevice device, const( VkCommandBufferAllocateInfo )* pAllocateInfo, VkCommandBuffer* pCommandBuffers );
	alias PFN_vkFreeCommandBuffers = void function( VkDevice device, VkCommandPool commandPool, uint32_t commandBufferCount, const( VkCommandBuffer )* pCommandBuffers );
	alias PFN_vkBeginCommandBuffer = VkResult function( VkCommandBuffer commandBuffer, const( VkCommandBufferBeginInfo )* pBeginInfo );
	alias PFN_vkEndCommandBuffer = VkResult function( VkCommandBuffer commandBuffer );
	alias PFN_vkResetCommandBuffer = VkResult function( VkCommandBuffer commandBuffer, VkCommandBufferResetFlags flags );
	alias PFN_vkCmdBindPipeline = void function( VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipeline pipeline );
	alias PFN_vkCmdSetViewport = void function( VkCommandBuffer commandBuffer, uint32_t firstViewport, uint32_t viewportCount, const( VkViewport )* pViewports );
	alias PFN_vkCmdSetScissor = void function( VkCommandBuffer commandBuffer, uint32_t firstScissor, uint32_t scissorCount, const( VkRect2D )* pScissors );
	alias PFN_vkCmdSetLineWidth = void function( VkCommandBuffer commandBuffer, float lineWidth );
	alias PFN_vkCmdSetDepthBias = void function( VkCommandBuffer commandBuffer, float depthBiasConstantFactor, float depthBiasClamp, float depthBiasSlopeFactor );
	alias PFN_vkCmdSetBlendConstants = void function( VkCommandBuffer commandBuffer, const float[4] blendConstants );
	alias PFN_vkCmdSetDepthBounds = void function( VkCommandBuffer commandBuffer, float minDepthBounds, float maxDepthBounds );
	alias PFN_vkCmdSetStencilCompareMask = void function( VkCommandBuffer commandBuffer, VkStencilFaceFlags faceMask, uint32_t compareMask );
	alias PFN_vkCmdSetStencilWriteMask = void function( VkCommandBuffer commandBuffer, VkStencilFaceFlags faceMask, uint32_t writeMask );
	alias PFN_vkCmdSetStencilReference = void function( VkCommandBuffer commandBuffer, VkStencilFaceFlags faceMask, uint32_t reference );
	alias PFN_vkCmdBindDescriptorSets = void function( VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipelineLayout layout, uint32_t firstSet, uint32_t descriptorSetCount, const( VkDescriptorSet )* pDescriptorSets, uint32_t dynamicOffsetCount, const( uint32_t )* pDynamicOffsets );
	alias PFN_vkCmdBindIndexBuffer = void function( VkCommandBuffer commandBuffer, VkBuffer buffer, VkDeviceSize offset, VkIndexType indexType );
	alias PFN_vkCmdBindVertexBuffers = void function( VkCommandBuffer commandBuffer, uint32_t firstBinding, uint32_t bindingCount, const( VkBuffer )* pBuffers, const( VkDeviceSize )* pOffsets );
	alias PFN_vkCmdDraw = void function( VkCommandBuffer commandBuffer, uint32_t vertexCount, uint32_t instanceCount, uint32_t firstVertex, uint32_t firstInstance );
	alias PFN_vkCmdDrawIndexed = void function( VkCommandBuffer commandBuffer, uint32_t indexCount, uint32_t instanceCount, uint32_t firstIndex, int32_t vertexOffset, uint32_t firstInstance );
	alias PFN_vkCmdDrawIndirect = void function( VkCommandBuffer commandBuffer, VkBuffer buffer, VkDeviceSize offset, uint32_t drawCount, uint32_t stride );
	alias PFN_vkCmdDrawIndexedIndirect = void function( VkCommandBuffer commandBuffer, VkBuffer buffer, VkDeviceSize offset, uint32_t drawCount, uint32_t stride );
	alias PFN_vkCmdDispatch = void function( VkCommandBuffer commandBuffer, uint32_t groupCountX, uint32_t groupCountY, uint32_t groupCountZ );
	alias PFN_vkCmdDispatchIndirect = void function( VkCommandBuffer commandBuffer, VkBuffer buffer, VkDeviceSize offset );
	alias PFN_vkCmdCopyBuffer = void function( VkCommandBuffer commandBuffer, VkBuffer srcBuffer, VkBuffer dstBuffer, uint32_t regionCount, const( VkBufferCopy )* pRegions );
	alias PFN_vkCmdCopyImage = void function( VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkImage dstImage, VkImageLayout dstImageLayout, uint32_t regionCount, const( VkImageCopy )* pRegions );
	alias PFN_vkCmdBlitImage = void function( VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkImage dstImage, VkImageLayout dstImageLayout, uint32_t regionCount, const( VkImageBlit )* pRegions, VkFilter filter );
	alias PFN_vkCmdCopyBufferToImage = void function( VkCommandBuffer commandBuffer, VkBuffer srcBuffer, VkImage dstImage, VkImageLayout dstImageLayout, uint32_t regionCount, const( VkBufferImageCopy )* pRegions );
	alias PFN_vkCmdCopyImageToBuffer = void function( VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkBuffer dstBuffer, uint32_t regionCount, const( VkBufferImageCopy )* pRegions );
	alias PFN_vkCmdUpdateBuffer = void function( VkCommandBuffer commandBuffer, VkBuffer dstBuffer, VkDeviceSize dstOffset, VkDeviceSize dataSize, const( void )* pData );
	alias PFN_vkCmdFillBuffer = void function( VkCommandBuffer commandBuffer, VkBuffer dstBuffer, VkDeviceSize dstOffset, VkDeviceSize size, uint32_t data );
	alias PFN_vkCmdClearColorImage = void function( VkCommandBuffer commandBuffer, VkImage image, VkImageLayout imageLayout, const( VkClearColorValue )* pColor, uint32_t rangeCount, const( VkImageSubresourceRange )* pRanges );
	alias PFN_vkCmdClearDepthStencilImage = void function( VkCommandBuffer commandBuffer, VkImage image, VkImageLayout imageLayout, const( VkClearDepthStencilValue )* pDepthStencil, uint32_t rangeCount, const( VkImageSubresourceRange )* pRanges );
	alias PFN_vkCmdClearAttachments = void function( VkCommandBuffer commandBuffer, uint32_t attachmentCount, const( VkClearAttachment )* pAttachments, uint32_t rectCount, const( VkClearRect )* pRects );
	alias PFN_vkCmdResolveImage = void function( VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkImage dstImage, VkImageLayout dstImageLayout, uint32_t regionCount, const( VkImageResolve )* pRegions );
	alias PFN_vkCmdSetEvent = void function( VkCommandBuffer commandBuffer, VkEvent event, VkPipelineStageFlags stageMask );
	alias PFN_vkCmdResetEvent = void function( VkCommandBuffer commandBuffer, VkEvent event, VkPipelineStageFlags stageMask );
	alias PFN_vkCmdWaitEvents = void function( VkCommandBuffer commandBuffer, uint32_t eventCount, const( VkEvent )* pEvents, VkPipelineStageFlags srcStageMask, VkPipelineStageFlags dstStageMask, uint32_t memoryBarrierCount, const( VkMemoryBarrier )* pMemoryBarriers, uint32_t bufferMemoryBarrierCount, const( VkBufferMemoryBarrier )* pBufferMemoryBarriers, uint32_t imageMemoryBarrierCount, const( VkImageMemoryBarrier )* pImageMemoryBarriers );
	alias PFN_vkCmdPipelineBarrier = void function( VkCommandBuffer commandBuffer, VkPipelineStageFlags srcStageMask, VkPipelineStageFlags dstStageMask, VkDependencyFlags dependencyFlags, uint32_t memoryBarrierCount, const( VkMemoryBarrier )* pMemoryBarriers, uint32_t bufferMemoryBarrierCount, const( VkBufferMemoryBarrier )* pBufferMemoryBarriers, uint32_t imageMemoryBarrierCount, const( VkImageMemoryBarrier )* pImageMemoryBarriers );
	alias PFN_vkCmdBeginQuery = void function( VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32_t query, VkQueryControlFlags flags );
	alias PFN_vkCmdEndQuery = void function( VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32_t query );
	alias PFN_vkCmdResetQueryPool = void function( VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32_t firstQuery, uint32_t queryCount );
	alias PFN_vkCmdWriteTimestamp = void function( VkCommandBuffer commandBuffer, VkPipelineStageFlagBits pipelineStage, VkQueryPool queryPool, uint32_t query );
	alias PFN_vkCmdCopyQueryPoolResults = void function( VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32_t firstQuery, uint32_t queryCount, VkBuffer dstBuffer, VkDeviceSize dstOffset, VkDeviceSize stride, VkQueryResultFlags flags );
	alias PFN_vkCmdPushConstants = void function( VkCommandBuffer commandBuffer, VkPipelineLayout layout, VkShaderStageFlags stageFlags, uint32_t offset, uint32_t size, const( void )* pValues );
	alias PFN_vkCmdBeginRenderPass = void function( VkCommandBuffer commandBuffer, const( VkRenderPassBeginInfo )* pRenderPassBegin, VkSubpassContents contents );
	alias PFN_vkCmdNextSubpass = void function( VkCommandBuffer commandBuffer, VkSubpassContents contents );
	alias PFN_vkCmdEndRenderPass = void function( VkCommandBuffer commandBuffer );
	alias PFN_vkCmdExecuteCommands = void function( VkCommandBuffer commandBuffer, uint32_t commandBufferCount, const( VkCommandBuffer )* pCommandBuffers );

	// VK_VERSION_1_1
	alias PFN_vkEnumerateInstanceVersion = VkResult function( uint32_t* pApiVersion );
	alias PFN_vkBindBufferMemory2 = VkResult function( VkDevice device, uint32_t bindInfoCount, const( VkBindBufferMemoryInfo )* pBindInfos );
	alias PFN_vkBindImageMemory2 = VkResult function( VkDevice device, uint32_t bindInfoCount, const( VkBindImageMemoryInfo )* pBindInfos );
	alias PFN_vkGetDeviceGroupPeerMemoryFeatures = void function( VkDevice device, uint32_t heapIndex, uint32_t localDeviceIndex, uint32_t remoteDeviceIndex, VkPeerMemoryFeatureFlags* pPeerMemoryFeatures );
	alias PFN_vkCmdSetDeviceMask = void function( VkCommandBuffer commandBuffer, uint32_t deviceMask );
	alias PFN_vkCmdDispatchBase = void function( VkCommandBuffer commandBuffer, uint32_t baseGroupX, uint32_t baseGroupY, uint32_t baseGroupZ, uint32_t groupCountX, uint32_t groupCountY, uint32_t groupCountZ );
	alias PFN_vkEnumeratePhysicalDeviceGroups = VkResult function( VkInstance instance, uint32_t* pPhysicalDeviceGroupCount, VkPhysicalDeviceGroupProperties* pPhysicalDeviceGroupProperties );
	alias PFN_vkGetImageMemoryRequirements2 = void function( VkDevice device, const( VkImageMemoryRequirementsInfo2 )* pInfo, VkMemoryRequirements2* pMemoryRequirements );
	alias PFN_vkGetBufferMemoryRequirements2 = void function( VkDevice device, const( VkBufferMemoryRequirementsInfo2 )* pInfo, VkMemoryRequirements2* pMemoryRequirements );
	alias PFN_vkGetImageSparseMemoryRequirements2 = void function( VkDevice device, const( VkImageSparseMemoryRequirementsInfo2 )* pInfo, uint32_t* pSparseMemoryRequirementCount, VkSparseImageMemoryRequirements2* pSparseMemoryRequirements );
	alias PFN_vkGetPhysicalDeviceFeatures2 = void function( VkPhysicalDevice physicalDevice, VkPhysicalDeviceFeatures2* pFeatures );
	alias PFN_vkGetPhysicalDeviceProperties2 = void function( VkPhysicalDevice physicalDevice, VkPhysicalDeviceProperties2* pProperties );
	alias PFN_vkGetPhysicalDeviceFormatProperties2 = void function( VkPhysicalDevice physicalDevice, VkFormat format, VkFormatProperties2* pFormatProperties );
	alias PFN_vkGetPhysicalDeviceImageFormatProperties2 = VkResult function( VkPhysicalDevice physicalDevice, const( VkPhysicalDeviceImageFormatInfo2 )* pImageFormatInfo, VkImageFormatProperties2* pImageFormatProperties );
	alias PFN_vkGetPhysicalDeviceQueueFamilyProperties2 = void function( VkPhysicalDevice physicalDevice, uint32_t* pQueueFamilyPropertyCount, VkQueueFamilyProperties2* pQueueFamilyProperties );
	alias PFN_vkGetPhysicalDeviceMemoryProperties2 = void function( VkPhysicalDevice physicalDevice, VkPhysicalDeviceMemoryProperties2* pMemoryProperties );
	alias PFN_vkGetPhysicalDeviceSparseImageFormatProperties2 = void function( VkPhysicalDevice physicalDevice, const( VkPhysicalDeviceSparseImageFormatInfo2 )* pFormatInfo, uint32_t* pPropertyCount, VkSparseImageFormatProperties2* pProperties );
	alias PFN_vkTrimCommandPool = void function( VkDevice device, VkCommandPool commandPool, VkCommandPoolTrimFlags flags );
	alias PFN_vkGetDeviceQueue2 = void function( VkDevice device, const( VkDeviceQueueInfo2 )* pQueueInfo, VkQueue* pQueue );
	alias PFN_vkCreateSamplerYcbcrConversion = VkResult function( VkDevice device, const( VkSamplerYcbcrConversionCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSamplerYcbcrConversion* pYcbcrConversion );
	alias PFN_vkDestroySamplerYcbcrConversion = void function( VkDevice device, VkSamplerYcbcrConversion ycbcrConversion, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkCreateDescriptorUpdateTemplate = VkResult function( VkDevice device, const( VkDescriptorUpdateTemplateCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkDescriptorUpdateTemplate* pDescriptorUpdateTemplate );
	alias PFN_vkDestroyDescriptorUpdateTemplate = void function( VkDevice device, VkDescriptorUpdateTemplate descriptorUpdateTemplate, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkUpdateDescriptorSetWithTemplate = void function( VkDevice device, VkDescriptorSet descriptorSet, VkDescriptorUpdateTemplate descriptorUpdateTemplate, const( void )* pData );
	alias PFN_vkGetPhysicalDeviceExternalBufferProperties = void function( VkPhysicalDevice physicalDevice, const( VkPhysicalDeviceExternalBufferInfo )* pExternalBufferInfo, VkExternalBufferProperties* pExternalBufferProperties );
	alias PFN_vkGetPhysicalDeviceExternalFenceProperties = void function( VkPhysicalDevice physicalDevice, const( VkPhysicalDeviceExternalFenceInfo )* pExternalFenceInfo, VkExternalFenceProperties* pExternalFenceProperties );
	alias PFN_vkGetPhysicalDeviceExternalSemaphoreProperties = void function( VkPhysicalDevice physicalDevice, const( VkPhysicalDeviceExternalSemaphoreInfo )* pExternalSemaphoreInfo, VkExternalSemaphoreProperties* pExternalSemaphoreProperties );
	alias PFN_vkGetDescriptorSetLayoutSupport = void function( VkDevice device, const( VkDescriptorSetLayoutCreateInfo )* pCreateInfo, VkDescriptorSetLayoutSupport* pSupport );

	// VK_VERSION_1_2
	alias PFN_vkCmdDrawIndirectCount = void function( VkCommandBuffer commandBuffer, VkBuffer buffer, VkDeviceSize offset, VkBuffer countBuffer, VkDeviceSize countBufferOffset, uint32_t maxDrawCount, uint32_t stride );
	alias PFN_vkCmdDrawIndexedIndirectCount = void function( VkCommandBuffer commandBuffer, VkBuffer buffer, VkDeviceSize offset, VkBuffer countBuffer, VkDeviceSize countBufferOffset, uint32_t maxDrawCount, uint32_t stride );
	alias PFN_vkCreateRenderPass2 = VkResult function( VkDevice device, const( VkRenderPassCreateInfo2 )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkRenderPass* pRenderPass );
	alias PFN_vkCmdBeginRenderPass2 = void function( VkCommandBuffer commandBuffer, const( VkRenderPassBeginInfo )* pRenderPassBegin, const( VkSubpassBeginInfo )* pSubpassBeginInfo );
	alias PFN_vkCmdNextSubpass2 = void function( VkCommandBuffer commandBuffer, const( VkSubpassBeginInfo )* pSubpassBeginInfo, const( VkSubpassEndInfo )* pSubpassEndInfo );
	alias PFN_vkCmdEndRenderPass2 = void function( VkCommandBuffer commandBuffer, const( VkSubpassEndInfo )* pSubpassEndInfo );
	alias PFN_vkResetQueryPool = void function( VkDevice device, VkQueryPool queryPool, uint32_t firstQuery, uint32_t queryCount );
	alias PFN_vkGetSemaphoreCounterValue = VkResult function( VkDevice device, VkSemaphore semaphore, uint64_t* pValue );
	alias PFN_vkWaitSemaphores = VkResult function( VkDevice device, const( VkSemaphoreWaitInfo )* pWaitInfo, uint64_t timeout );
	alias PFN_vkSignalSemaphore = VkResult function( VkDevice device, const( VkSemaphoreSignalInfo )* pSignalInfo );
	alias PFN_vkGetBufferDeviceAddress = VkDeviceAddress function( VkDevice device, const( VkBufferDeviceAddressInfo )* pInfo );
	alias PFN_vkGetBufferOpaqueCaptureAddress = uint64_t function( VkDevice device, const( VkBufferDeviceAddressInfo )* pInfo );
	alias PFN_vkGetDeviceMemoryOpaqueCaptureAddress = uint64_t function( VkDevice device, const( VkDeviceMemoryOpaqueCaptureAddressInfo )* pInfo );

	// VK_VERSION_1_3
	alias PFN_vkGetPhysicalDeviceToolProperties = VkResult function( VkPhysicalDevice physicalDevice, uint32_t* pToolCount, VkPhysicalDeviceToolProperties* pToolProperties );
	alias PFN_vkCreatePrivateDataSlot = VkResult function( VkDevice device, const( VkPrivateDataSlotCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkPrivateDataSlot* pPrivateDataSlot );
	alias PFN_vkDestroyPrivateDataSlot = void function( VkDevice device, VkPrivateDataSlot privateDataSlot, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkSetPrivateData = VkResult function( VkDevice device, VkObjectType objectType, uint64_t objectHandle, VkPrivateDataSlot privateDataSlot, uint64_t data );
	alias PFN_vkGetPrivateData = void function( VkDevice device, VkObjectType objectType, uint64_t objectHandle, VkPrivateDataSlot privateDataSlot, uint64_t* pData );
	alias PFN_vkCmdSetEvent2 = void function( VkCommandBuffer commandBuffer, VkEvent event, const( VkDependencyInfo )* pDependencyInfo );
	alias PFN_vkCmdResetEvent2 = void function( VkCommandBuffer commandBuffer, VkEvent event, VkPipelineStageFlags2 stageMask );
	alias PFN_vkCmdWaitEvents2 = void function( VkCommandBuffer commandBuffer, uint32_t eventCount, const( VkEvent )* pEvents, const( VkDependencyInfo )* pDependencyInfos );
	alias PFN_vkCmdPipelineBarrier2 = void function( VkCommandBuffer commandBuffer, const( VkDependencyInfo )* pDependencyInfo );
	alias PFN_vkCmdWriteTimestamp2 = void function( VkCommandBuffer commandBuffer, VkPipelineStageFlags2 stage, VkQueryPool queryPool, uint32_t query );
	alias PFN_vkQueueSubmit2 = VkResult function( VkQueue queue, uint32_t submitCount, const( VkSubmitInfo2 )* pSubmits, VkFence fence );
	alias PFN_vkCmdCopyBuffer2 = void function( VkCommandBuffer commandBuffer, const( VkCopyBufferInfo2 )* pCopyBufferInfo );
	alias PFN_vkCmdCopyImage2 = void function( VkCommandBuffer commandBuffer, const( VkCopyImageInfo2 )* pCopyImageInfo );
	alias PFN_vkCmdCopyBufferToImage2 = void function( VkCommandBuffer commandBuffer, const( VkCopyBufferToImageInfo2 )* pCopyBufferToImageInfo );
	alias PFN_vkCmdCopyImageToBuffer2 = void function( VkCommandBuffer commandBuffer, const( VkCopyImageToBufferInfo2 )* pCopyImageToBufferInfo );
	alias PFN_vkCmdBlitImage2 = void function( VkCommandBuffer commandBuffer, const( VkBlitImageInfo2 )* pBlitImageInfo );
	alias PFN_vkCmdResolveImage2 = void function( VkCommandBuffer commandBuffer, const( VkResolveImageInfo2 )* pResolveImageInfo );
	alias PFN_vkCmdBeginRendering = void function( VkCommandBuffer commandBuffer, const( VkRenderingInfo )* pRenderingInfo );
	alias PFN_vkCmdEndRendering = void function( VkCommandBuffer commandBuffer );
	alias PFN_vkCmdSetCullMode = void function( VkCommandBuffer commandBuffer, VkCullModeFlags cullMode );
	alias PFN_vkCmdSetFrontFace = void function( VkCommandBuffer commandBuffer, VkFrontFace frontFace );
	alias PFN_vkCmdSetPrimitiveTopology = void function( VkCommandBuffer commandBuffer, VkPrimitiveTopology primitiveTopology );
	alias PFN_vkCmdSetViewportWithCount = void function( VkCommandBuffer commandBuffer, uint32_t viewportCount, const( VkViewport )* pViewports );
	alias PFN_vkCmdSetScissorWithCount = void function( VkCommandBuffer commandBuffer, uint32_t scissorCount, const( VkRect2D )* pScissors );
	alias PFN_vkCmdBindVertexBuffers2 = void function( VkCommandBuffer commandBuffer, uint32_t firstBinding, uint32_t bindingCount, const( VkBuffer )* pBuffers, const( VkDeviceSize )* pOffsets, const( VkDeviceSize )* pSizes, const( VkDeviceSize )* pStrides );
	alias PFN_vkCmdSetDepthTestEnable = void function( VkCommandBuffer commandBuffer, VkBool32 depthTestEnable );
	alias PFN_vkCmdSetDepthWriteEnable = void function( VkCommandBuffer commandBuffer, VkBool32 depthWriteEnable );
	alias PFN_vkCmdSetDepthCompareOp = void function( VkCommandBuffer commandBuffer, VkCompareOp depthCompareOp );
	alias PFN_vkCmdSetDepthBoundsTestEnable = void function( VkCommandBuffer commandBuffer, VkBool32 depthBoundsTestEnable );
	alias PFN_vkCmdSetStencilTestEnable = void function( VkCommandBuffer commandBuffer, VkBool32 stencilTestEnable );
	alias PFN_vkCmdSetStencilOp = void function( VkCommandBuffer commandBuffer, VkStencilFaceFlags faceMask, VkStencilOp failOp, VkStencilOp passOp, VkStencilOp depthFailOp, VkCompareOp compareOp );
	alias PFN_vkCmdSetRasterizerDiscardEnable = void function( VkCommandBuffer commandBuffer, VkBool32 rasterizerDiscardEnable );
	alias PFN_vkCmdSetDepthBiasEnable = void function( VkCommandBuffer commandBuffer, VkBool32 depthBiasEnable );
	alias PFN_vkCmdSetPrimitiveRestartEnable = void function( VkCommandBuffer commandBuffer, VkBool32 primitiveRestartEnable );
	alias PFN_vkGetDeviceBufferMemoryRequirements = void function( VkDevice device, const( VkDeviceBufferMemoryRequirements )* pInfo, VkMemoryRequirements2* pMemoryRequirements );
	alias PFN_vkGetDeviceImageMemoryRequirements = void function( VkDevice device, const( VkDeviceImageMemoryRequirements )* pInfo, VkMemoryRequirements2* pMemoryRequirements );
	alias PFN_vkGetDeviceImageSparseMemoryRequirements = void function( VkDevice device, const( VkDeviceImageMemoryRequirements )* pInfo, uint32_t* pSparseMemoryRequirementCount, VkSparseImageMemoryRequirements2* pSparseMemoryRequirements );

	// VK_KHR_surface
	alias PFN_vkDestroySurfaceKHR = void function( VkInstance instance, VkSurfaceKHR surface, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkGetPhysicalDeviceSurfaceSupportKHR = VkResult function( VkPhysicalDevice physicalDevice, uint32_t queueFamilyIndex, VkSurfaceKHR surface, VkBool32* pSupported );
	alias PFN_vkGetPhysicalDeviceSurfaceCapabilitiesKHR = VkResult function( VkPhysicalDevice physicalDevice, VkSurfaceKHR surface, VkSurfaceCapabilitiesKHR* pSurfaceCapabilities );
	alias PFN_vkGetPhysicalDeviceSurfaceFormatsKHR = VkResult function( VkPhysicalDevice physicalDevice, VkSurfaceKHR surface, uint32_t* pSurfaceFormatCount, VkSurfaceFormatKHR* pSurfaceFormats );
	alias PFN_vkGetPhysicalDeviceSurfacePresentModesKHR = VkResult function( VkPhysicalDevice physicalDevice, VkSurfaceKHR surface, uint32_t* pPresentModeCount, VkPresentModeKHR* pPresentModes );

	// VK_KHR_swapchain
	alias PFN_vkCreateSwapchainKHR = VkResult function( VkDevice device, const( VkSwapchainCreateInfoKHR )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSwapchainKHR* pSwapchain );
	alias PFN_vkDestroySwapchainKHR = void function( VkDevice device, VkSwapchainKHR swapchain, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkGetSwapchainImagesKHR = VkResult function( VkDevice device, VkSwapchainKHR swapchain, uint32_t* pSwapchainImageCount, VkImage* pSwapchainImages );
	alias PFN_vkAcquireNextImageKHR = VkResult function( VkDevice device, VkSwapchainKHR swapchain, uint64_t timeout, VkSemaphore semaphore, VkFence fence, uint32_t* pImageIndex );
	alias PFN_vkQueuePresentKHR = VkResult function( VkQueue queue, const( VkPresentInfoKHR )* pPresentInfo );
	alias PFN_vkGetDeviceGroupPresentCapabilitiesKHR = VkResult function( VkDevice device, VkDeviceGroupPresentCapabilitiesKHR* pDeviceGroupPresentCapabilities );
	alias PFN_vkGetDeviceGroupSurfacePresentModesKHR = VkResult function( VkDevice device, VkSurfaceKHR surface, VkDeviceGroupPresentModeFlagsKHR* pModes );
	alias PFN_vkGetPhysicalDevicePresentRectanglesKHR = VkResult function( VkPhysicalDevice physicalDevice, VkSurfaceKHR surface, uint32_t* pRectCount, VkRect2D* pRects );
	alias PFN_vkAcquireNextImage2KHR = VkResult function( VkDevice device, const( VkAcquireNextImageInfoKHR )* pAcquireInfo, uint32_t* pImageIndex );

	// VK_KHR_xlib_surface
	version( gd_X11Impl ) {
		alias PFN_vkCreateXlibSurfaceKHR = VkResult function( VkInstance instance, const( VkXlibSurfaceCreateInfoKHR )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSurfaceKHR* pSurface );
		alias PFN_vkGetPhysicalDeviceXlibPresentationSupportKHR = VkBool32 function( VkPhysicalDevice physicalDevice, uint32_t queueFamilyIndex, X11Library.Display* dpy, X11Library.VisualID visualID );
	}

	// VK_KHR_win32_surface
	version( gd_Win32 ) {
		alias PFN_vkCreateWin32SurfaceKHR = VkResult function( VkInstance instance, const( VkWin32SurfaceCreateInfoKHR )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSurfaceKHR* pSurface );
		alias PFN_vkGetPhysicalDeviceWin32PresentationSupportKHR = VkBool32 function( VkPhysicalDevice physicalDevice, uint32_t queueFamilyIndex );
	}

	// VK_EXT_debug_utils
	alias PFN_vkSetDebugUtilsObjectNameEXT = VkResult function( VkDevice device, const( VkDebugUtilsObjectNameInfoEXT )* pNameInfo );
	alias PFN_vkSetDebugUtilsObjectTagEXT = VkResult function( VkDevice device, const( VkDebugUtilsObjectTagInfoEXT )* pTagInfo );
	alias PFN_vkQueueBeginDebugUtilsLabelEXT = void function( VkQueue queue, const( VkDebugUtilsLabelEXT )* pLabelInfo );
	alias PFN_vkQueueEndDebugUtilsLabelEXT = void function( VkQueue queue );
	alias PFN_vkQueueInsertDebugUtilsLabelEXT = void function( VkQueue queue, const( VkDebugUtilsLabelEXT )* pLabelInfo );
	alias PFN_vkCmdBeginDebugUtilsLabelEXT = void function( VkCommandBuffer commandBuffer, const( VkDebugUtilsLabelEXT )* pLabelInfo );
	alias PFN_vkCmdEndDebugUtilsLabelEXT = void function( VkCommandBuffer commandBuffer );
	alias PFN_vkCmdInsertDebugUtilsLabelEXT = void function( VkCommandBuffer commandBuffer, const( VkDebugUtilsLabelEXT )* pLabelInfo );
	alias PFN_vkCreateDebugUtilsMessengerEXT = VkResult function( VkInstance instance, const( VkDebugUtilsMessengerCreateInfoEXT )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkDebugUtilsMessengerEXT* pMessenger );
	alias PFN_vkDestroyDebugUtilsMessengerEXT = void function( VkInstance instance, VkDebugUtilsMessengerEXT messenger, const( VkAllocationCallbacks )* pAllocator );
	alias PFN_vkSubmitDebugUtilsMessageEXT = void function( VkInstance instance, VkDebugUtilsMessageSeverityFlagBitsEXT messageSeverity, VkDebugUtilsMessageTypeFlagsEXT messageTypes, const( VkDebugUtilsMessengerCallbackDataEXT )* pCallbackData );
}

__gshared {

	// VK_VERSION_1_0
	PFN_vkCreateInstance vkCreateInstance;
	PFN_vkDestroyInstance vkDestroyInstance;
	PFN_vkEnumeratePhysicalDevices vkEnumeratePhysicalDevices;
	PFN_vkGetPhysicalDeviceFeatures vkGetPhysicalDeviceFeatures;
	PFN_vkGetPhysicalDeviceFormatProperties vkGetPhysicalDeviceFormatProperties;
	PFN_vkGetPhysicalDeviceImageFormatProperties vkGetPhysicalDeviceImageFormatProperties;
	PFN_vkGetPhysicalDeviceProperties vkGetPhysicalDeviceProperties;
	PFN_vkGetPhysicalDeviceQueueFamilyProperties vkGetPhysicalDeviceQueueFamilyProperties;
	PFN_vkGetPhysicalDeviceMemoryProperties vkGetPhysicalDeviceMemoryProperties;
	PFN_vkGetInstanceProcAddr vkGetInstanceProcAddr;
	PFN_vkGetDeviceProcAddr vkGetDeviceProcAddr;
	PFN_vkCreateDevice vkCreateDevice;
	PFN_vkDestroyDevice vkDestroyDevice;
	PFN_vkEnumerateInstanceExtensionProperties vkEnumerateInstanceExtensionProperties;
	PFN_vkEnumerateDeviceExtensionProperties vkEnumerateDeviceExtensionProperties;
	PFN_vkEnumerateInstanceLayerProperties vkEnumerateInstanceLayerProperties;
	PFN_vkEnumerateDeviceLayerProperties vkEnumerateDeviceLayerProperties;
	PFN_vkGetDeviceQueue vkGetDeviceQueue;
	PFN_vkQueueSubmit vkQueueSubmit;
	PFN_vkQueueWaitIdle vkQueueWaitIdle;
	PFN_vkDeviceWaitIdle vkDeviceWaitIdle;
	PFN_vkAllocateMemory vkAllocateMemory;
	PFN_vkFreeMemory vkFreeMemory;
	PFN_vkMapMemory vkMapMemory;
	PFN_vkUnmapMemory vkUnmapMemory;
	PFN_vkFlushMappedMemoryRanges vkFlushMappedMemoryRanges;
	PFN_vkInvalidateMappedMemoryRanges vkInvalidateMappedMemoryRanges;
	PFN_vkGetDeviceMemoryCommitment vkGetDeviceMemoryCommitment;
	PFN_vkBindBufferMemory vkBindBufferMemory;
	PFN_vkBindImageMemory vkBindImageMemory;
	PFN_vkGetBufferMemoryRequirements vkGetBufferMemoryRequirements;
	PFN_vkGetImageMemoryRequirements vkGetImageMemoryRequirements;
	PFN_vkGetImageSparseMemoryRequirements vkGetImageSparseMemoryRequirements;
	PFN_vkGetPhysicalDeviceSparseImageFormatProperties vkGetPhysicalDeviceSparseImageFormatProperties;
	PFN_vkQueueBindSparse vkQueueBindSparse;
	PFN_vkCreateFence vkCreateFence;
	PFN_vkDestroyFence vkDestroyFence;
	PFN_vkResetFences vkResetFences;
	PFN_vkGetFenceStatus vkGetFenceStatus;
	PFN_vkWaitForFences vkWaitForFences;
	PFN_vkCreateSemaphore vkCreateSemaphore;
	PFN_vkDestroySemaphore vkDestroySemaphore;
	PFN_vkCreateEvent vkCreateEvent;
	PFN_vkDestroyEvent vkDestroyEvent;
	PFN_vkGetEventStatus vkGetEventStatus;
	PFN_vkSetEvent vkSetEvent;
	PFN_vkResetEvent vkResetEvent;
	PFN_vkCreateQueryPool vkCreateQueryPool;
	PFN_vkDestroyQueryPool vkDestroyQueryPool;
	PFN_vkGetQueryPoolResults vkGetQueryPoolResults;
	PFN_vkCreateBuffer vkCreateBuffer;
	PFN_vkDestroyBuffer vkDestroyBuffer;
	PFN_vkCreateBufferView vkCreateBufferView;
	PFN_vkDestroyBufferView vkDestroyBufferView;
	PFN_vkCreateImage vkCreateImage;
	PFN_vkDestroyImage vkDestroyImage;
	PFN_vkGetImageSubresourceLayout vkGetImageSubresourceLayout;
	PFN_vkCreateImageView vkCreateImageView;
	PFN_vkDestroyImageView vkDestroyImageView;
	PFN_vkCreateShaderModule vkCreateShaderModule;
	PFN_vkDestroyShaderModule vkDestroyShaderModule;
	PFN_vkCreatePipelineCache vkCreatePipelineCache;
	PFN_vkDestroyPipelineCache vkDestroyPipelineCache;
	PFN_vkGetPipelineCacheData vkGetPipelineCacheData;
	PFN_vkMergePipelineCaches vkMergePipelineCaches;
	PFN_vkCreateGraphicsPipelines vkCreateGraphicsPipelines;
	PFN_vkCreateComputePipelines vkCreateComputePipelines;
	PFN_vkDestroyPipeline vkDestroyPipeline;
	PFN_vkCreatePipelineLayout vkCreatePipelineLayout;
	PFN_vkDestroyPipelineLayout vkDestroyPipelineLayout;
	PFN_vkCreateSampler vkCreateSampler;
	PFN_vkDestroySampler vkDestroySampler;
	PFN_vkCreateDescriptorSetLayout vkCreateDescriptorSetLayout;
	PFN_vkDestroyDescriptorSetLayout vkDestroyDescriptorSetLayout;
	PFN_vkCreateDescriptorPool vkCreateDescriptorPool;
	PFN_vkDestroyDescriptorPool vkDestroyDescriptorPool;
	PFN_vkResetDescriptorPool vkResetDescriptorPool;
	PFN_vkAllocateDescriptorSets vkAllocateDescriptorSets;
	PFN_vkFreeDescriptorSets vkFreeDescriptorSets;
	PFN_vkUpdateDescriptorSets vkUpdateDescriptorSets;
	PFN_vkCreateFramebuffer vkCreateFramebuffer;
	PFN_vkDestroyFramebuffer vkDestroyFramebuffer;
	PFN_vkCreateRenderPass vkCreateRenderPass;
	PFN_vkDestroyRenderPass vkDestroyRenderPass;
	PFN_vkGetRenderAreaGranularity vkGetRenderAreaGranularity;
	PFN_vkCreateCommandPool vkCreateCommandPool;
	PFN_vkDestroyCommandPool vkDestroyCommandPool;
	PFN_vkResetCommandPool vkResetCommandPool;
	PFN_vkAllocateCommandBuffers vkAllocateCommandBuffers;
	PFN_vkFreeCommandBuffers vkFreeCommandBuffers;
	PFN_vkBeginCommandBuffer vkBeginCommandBuffer;
	PFN_vkEndCommandBuffer vkEndCommandBuffer;
	PFN_vkResetCommandBuffer vkResetCommandBuffer;
	PFN_vkCmdBindPipeline vkCmdBindPipeline;
	PFN_vkCmdSetViewport vkCmdSetViewport;
	PFN_vkCmdSetScissor vkCmdSetScissor;
	PFN_vkCmdSetLineWidth vkCmdSetLineWidth;
	PFN_vkCmdSetDepthBias vkCmdSetDepthBias;
	PFN_vkCmdSetBlendConstants vkCmdSetBlendConstants;
	PFN_vkCmdSetDepthBounds vkCmdSetDepthBounds;
	PFN_vkCmdSetStencilCompareMask vkCmdSetStencilCompareMask;
	PFN_vkCmdSetStencilWriteMask vkCmdSetStencilWriteMask;
	PFN_vkCmdSetStencilReference vkCmdSetStencilReference;
	PFN_vkCmdBindDescriptorSets vkCmdBindDescriptorSets;
	PFN_vkCmdBindIndexBuffer vkCmdBindIndexBuffer;
	PFN_vkCmdBindVertexBuffers vkCmdBindVertexBuffers;
	PFN_vkCmdDraw vkCmdDraw;
	PFN_vkCmdDrawIndexed vkCmdDrawIndexed;
	PFN_vkCmdDrawIndirect vkCmdDrawIndirect;
	PFN_vkCmdDrawIndexedIndirect vkCmdDrawIndexedIndirect;
	PFN_vkCmdDispatch vkCmdDispatch;
	PFN_vkCmdDispatchIndirect vkCmdDispatchIndirect;
	PFN_vkCmdCopyBuffer vkCmdCopyBuffer;
	PFN_vkCmdCopyImage vkCmdCopyImage;
	PFN_vkCmdBlitImage vkCmdBlitImage;
	PFN_vkCmdCopyBufferToImage vkCmdCopyBufferToImage;
	PFN_vkCmdCopyImageToBuffer vkCmdCopyImageToBuffer;
	PFN_vkCmdUpdateBuffer vkCmdUpdateBuffer;
	PFN_vkCmdFillBuffer vkCmdFillBuffer;
	PFN_vkCmdClearColorImage vkCmdClearColorImage;
	PFN_vkCmdClearDepthStencilImage vkCmdClearDepthStencilImage;
	PFN_vkCmdClearAttachments vkCmdClearAttachments;
	PFN_vkCmdResolveImage vkCmdResolveImage;
	PFN_vkCmdSetEvent vkCmdSetEvent;
	PFN_vkCmdResetEvent vkCmdResetEvent;
	PFN_vkCmdWaitEvents vkCmdWaitEvents;
	PFN_vkCmdPipelineBarrier vkCmdPipelineBarrier;
	PFN_vkCmdBeginQuery vkCmdBeginQuery;
	PFN_vkCmdEndQuery vkCmdEndQuery;
	PFN_vkCmdResetQueryPool vkCmdResetQueryPool;
	PFN_vkCmdWriteTimestamp vkCmdWriteTimestamp;
	PFN_vkCmdCopyQueryPoolResults vkCmdCopyQueryPoolResults;
	PFN_vkCmdPushConstants vkCmdPushConstants;
	PFN_vkCmdBeginRenderPass vkCmdBeginRenderPass;
	PFN_vkCmdNextSubpass vkCmdNextSubpass;
	PFN_vkCmdEndRenderPass vkCmdEndRenderPass;
	PFN_vkCmdExecuteCommands vkCmdExecuteCommands;

	// VK_VERSION_1_1
	PFN_vkEnumerateInstanceVersion vkEnumerateInstanceVersion;
	PFN_vkBindBufferMemory2 vkBindBufferMemory2;
	PFN_vkBindImageMemory2 vkBindImageMemory2;
	PFN_vkGetDeviceGroupPeerMemoryFeatures vkGetDeviceGroupPeerMemoryFeatures;
	PFN_vkCmdSetDeviceMask vkCmdSetDeviceMask;
	PFN_vkCmdDispatchBase vkCmdDispatchBase;
	PFN_vkEnumeratePhysicalDeviceGroups vkEnumeratePhysicalDeviceGroups;
	PFN_vkGetImageMemoryRequirements2 vkGetImageMemoryRequirements2;
	PFN_vkGetBufferMemoryRequirements2 vkGetBufferMemoryRequirements2;
	PFN_vkGetImageSparseMemoryRequirements2 vkGetImageSparseMemoryRequirements2;
	PFN_vkGetPhysicalDeviceFeatures2 vkGetPhysicalDeviceFeatures2;
	PFN_vkGetPhysicalDeviceProperties2 vkGetPhysicalDeviceProperties2;
	PFN_vkGetPhysicalDeviceFormatProperties2 vkGetPhysicalDeviceFormatProperties2;
	PFN_vkGetPhysicalDeviceImageFormatProperties2 vkGetPhysicalDeviceImageFormatProperties2;
	PFN_vkGetPhysicalDeviceQueueFamilyProperties2 vkGetPhysicalDeviceQueueFamilyProperties2;
	PFN_vkGetPhysicalDeviceMemoryProperties2 vkGetPhysicalDeviceMemoryProperties2;
	PFN_vkGetPhysicalDeviceSparseImageFormatProperties2 vkGetPhysicalDeviceSparseImageFormatProperties2;
	PFN_vkTrimCommandPool vkTrimCommandPool;
	PFN_vkGetDeviceQueue2 vkGetDeviceQueue2;
	PFN_vkCreateSamplerYcbcrConversion vkCreateSamplerYcbcrConversion;
	PFN_vkDestroySamplerYcbcrConversion vkDestroySamplerYcbcrConversion;
	PFN_vkCreateDescriptorUpdateTemplate vkCreateDescriptorUpdateTemplate;
	PFN_vkDestroyDescriptorUpdateTemplate vkDestroyDescriptorUpdateTemplate;
	PFN_vkUpdateDescriptorSetWithTemplate vkUpdateDescriptorSetWithTemplate;
	PFN_vkGetPhysicalDeviceExternalBufferProperties vkGetPhysicalDeviceExternalBufferProperties;
	PFN_vkGetPhysicalDeviceExternalFenceProperties vkGetPhysicalDeviceExternalFenceProperties;
	PFN_vkGetPhysicalDeviceExternalSemaphoreProperties vkGetPhysicalDeviceExternalSemaphoreProperties;
	PFN_vkGetDescriptorSetLayoutSupport vkGetDescriptorSetLayoutSupport;

	// VK_VERSION_1_2
	PFN_vkCmdDrawIndirectCount vkCmdDrawIndirectCount;
	PFN_vkCmdDrawIndexedIndirectCount vkCmdDrawIndexedIndirectCount;
	PFN_vkCreateRenderPass2 vkCreateRenderPass2;
	PFN_vkCmdBeginRenderPass2 vkCmdBeginRenderPass2;
	PFN_vkCmdNextSubpass2 vkCmdNextSubpass2;
	PFN_vkCmdEndRenderPass2 vkCmdEndRenderPass2;
	PFN_vkResetQueryPool vkResetQueryPool;
	PFN_vkGetSemaphoreCounterValue vkGetSemaphoreCounterValue;
	PFN_vkWaitSemaphores vkWaitSemaphores;
	PFN_vkSignalSemaphore vkSignalSemaphore;
	PFN_vkGetBufferDeviceAddress vkGetBufferDeviceAddress;
	PFN_vkGetBufferOpaqueCaptureAddress vkGetBufferOpaqueCaptureAddress;
	PFN_vkGetDeviceMemoryOpaqueCaptureAddress vkGetDeviceMemoryOpaqueCaptureAddress;

	// VK_VERSION_1_3
	PFN_vkGetPhysicalDeviceToolProperties vkGetPhysicalDeviceToolProperties;
	PFN_vkCreatePrivateDataSlot vkCreatePrivateDataSlot;
	PFN_vkDestroyPrivateDataSlot vkDestroyPrivateDataSlot;
	PFN_vkSetPrivateData vkSetPrivateData;
	PFN_vkGetPrivateData vkGetPrivateData;
	PFN_vkCmdSetEvent2 vkCmdSetEvent2;
	PFN_vkCmdResetEvent2 vkCmdResetEvent2;
	PFN_vkCmdWaitEvents2 vkCmdWaitEvents2;
	PFN_vkCmdPipelineBarrier2 vkCmdPipelineBarrier2;
	PFN_vkCmdWriteTimestamp2 vkCmdWriteTimestamp2;
	PFN_vkQueueSubmit2 vkQueueSubmit2;
	PFN_vkCmdCopyBuffer2 vkCmdCopyBuffer2;
	PFN_vkCmdCopyImage2 vkCmdCopyImage2;
	PFN_vkCmdCopyBufferToImage2 vkCmdCopyBufferToImage2;
	PFN_vkCmdCopyImageToBuffer2 vkCmdCopyImageToBuffer2;
	PFN_vkCmdBlitImage2 vkCmdBlitImage2;
	PFN_vkCmdResolveImage2 vkCmdResolveImage2;
	PFN_vkCmdBeginRendering vkCmdBeginRendering;
	PFN_vkCmdEndRendering vkCmdEndRendering;
	PFN_vkCmdSetCullMode vkCmdSetCullMode;
	PFN_vkCmdSetFrontFace vkCmdSetFrontFace;
	PFN_vkCmdSetPrimitiveTopology vkCmdSetPrimitiveTopology;
	PFN_vkCmdSetViewportWithCount vkCmdSetViewportWithCount;
	PFN_vkCmdSetScissorWithCount vkCmdSetScissorWithCount;
	PFN_vkCmdBindVertexBuffers2 vkCmdBindVertexBuffers2;
	PFN_vkCmdSetDepthTestEnable vkCmdSetDepthTestEnable;
	PFN_vkCmdSetDepthWriteEnable vkCmdSetDepthWriteEnable;
	PFN_vkCmdSetDepthCompareOp vkCmdSetDepthCompareOp;
	PFN_vkCmdSetDepthBoundsTestEnable vkCmdSetDepthBoundsTestEnable;
	PFN_vkCmdSetStencilTestEnable vkCmdSetStencilTestEnable;
	PFN_vkCmdSetStencilOp vkCmdSetStencilOp;
	PFN_vkCmdSetRasterizerDiscardEnable vkCmdSetRasterizerDiscardEnable;
	PFN_vkCmdSetDepthBiasEnable vkCmdSetDepthBiasEnable;
	PFN_vkCmdSetPrimitiveRestartEnable vkCmdSetPrimitiveRestartEnable;
	PFN_vkGetDeviceBufferMemoryRequirements vkGetDeviceBufferMemoryRequirements;
	PFN_vkGetDeviceImageMemoryRequirements vkGetDeviceImageMemoryRequirements;
	PFN_vkGetDeviceImageSparseMemoryRequirements vkGetDeviceImageSparseMemoryRequirements;

	// VK_KHR_surface
	PFN_vkDestroySurfaceKHR vkDestroySurfaceKHR;
	PFN_vkGetPhysicalDeviceSurfaceSupportKHR vkGetPhysicalDeviceSurfaceSupportKHR;
	PFN_vkGetPhysicalDeviceSurfaceCapabilitiesKHR vkGetPhysicalDeviceSurfaceCapabilitiesKHR;
	PFN_vkGetPhysicalDeviceSurfaceFormatsKHR vkGetPhysicalDeviceSurfaceFormatsKHR;
	PFN_vkGetPhysicalDeviceSurfacePresentModesKHR vkGetPhysicalDeviceSurfacePresentModesKHR;

	// VK_KHR_swapchain
	PFN_vkCreateSwapchainKHR vkCreateSwapchainKHR;
	PFN_vkDestroySwapchainKHR vkDestroySwapchainKHR;
	PFN_vkGetSwapchainImagesKHR vkGetSwapchainImagesKHR;
	PFN_vkAcquireNextImageKHR vkAcquireNextImageKHR;
	PFN_vkQueuePresentKHR vkQueuePresentKHR;
	PFN_vkGetDeviceGroupPresentCapabilitiesKHR vkGetDeviceGroupPresentCapabilitiesKHR;
	PFN_vkGetDeviceGroupSurfacePresentModesKHR vkGetDeviceGroupSurfacePresentModesKHR;
	PFN_vkGetPhysicalDevicePresentRectanglesKHR vkGetPhysicalDevicePresentRectanglesKHR;
	PFN_vkAcquireNextImage2KHR vkAcquireNextImage2KHR;

	// VK_KHR_xlib_surface
	version( gd_X11Impl ) {
		PFN_vkCreateXlibSurfaceKHR vkCreateXlibSurfaceKHR;
		PFN_vkGetPhysicalDeviceXlibPresentationSupportKHR vkGetPhysicalDeviceXlibPresentationSupportKHR;
	}

	// VK_KHR_win32_surface
	version( gd_Win32 ) {
		PFN_vkCreateWin32SurfaceKHR vkCreateWin32SurfaceKHR;
		PFN_vkGetPhysicalDeviceWin32PresentationSupportKHR vkGetPhysicalDeviceWin32PresentationSupportKHR;
	}

	// VK_EXT_debug_utils
	PFN_vkSetDebugUtilsObjectNameEXT vkSetDebugUtilsObjectNameEXT;
	PFN_vkSetDebugUtilsObjectTagEXT vkSetDebugUtilsObjectTagEXT;
	PFN_vkQueueBeginDebugUtilsLabelEXT vkQueueBeginDebugUtilsLabelEXT;
	PFN_vkQueueEndDebugUtilsLabelEXT vkQueueEndDebugUtilsLabelEXT;
	PFN_vkQueueInsertDebugUtilsLabelEXT vkQueueInsertDebugUtilsLabelEXT;
	PFN_vkCmdBeginDebugUtilsLabelEXT vkCmdBeginDebugUtilsLabelEXT;
	PFN_vkCmdEndDebugUtilsLabelEXT vkCmdEndDebugUtilsLabelEXT;
	PFN_vkCmdInsertDebugUtilsLabelEXT vkCmdInsertDebugUtilsLabelEXT;
	PFN_vkCreateDebugUtilsMessengerEXT vkCreateDebugUtilsMessengerEXT;
	PFN_vkDestroyDebugUtilsMessengerEXT vkDestroyDebugUtilsMessengerEXT;
	PFN_vkSubmitDebugUtilsMessageEXT vkSubmitDebugUtilsMessageEXT;
}

/// if not using version "with-derelict-loader" this function must be called first
/// sets vkCreateInstance function pointer and acquires basic functions to retrieve information about the implementation
void loadGlobalLevelFunctions( typeof( vkGetInstanceProcAddr ) getProcAddr ) {
	vkGetInstanceProcAddr = getProcAddr;
	vkEnumerateInstanceExtensionProperties = cast( typeof( vkEnumerateInstanceExtensionProperties )) vkGetInstanceProcAddr( null, "vkEnumerateInstanceExtensionProperties" );
	vkEnumerateInstanceLayerProperties = cast( typeof( vkEnumerateInstanceLayerProperties )) vkGetInstanceProcAddr( null, "vkEnumerateInstanceLayerProperties" );
	vkCreateInstance = cast( typeof( vkCreateInstance )) vkGetInstanceProcAddr( null, "vkCreateInstance" );
}

/// with a valid VkInstance call this function to retrieve additional VkInstance, VkPhysicalDevice, ... related functions
void loadInstanceLevelFunctions( VkInstance instance ) {
	assert( vkGetInstanceProcAddr !is null, "Must call loadGlobalLevelFunctions before loadInstanceLevelFunctions" );

	// VK_VERSION_1_0
	vkDestroyInstance = cast( typeof( vkDestroyInstance )) vkGetInstanceProcAddr( instance, "vkDestroyInstance" );
	vkEnumeratePhysicalDevices = cast( typeof( vkEnumeratePhysicalDevices )) vkGetInstanceProcAddr( instance, "vkEnumeratePhysicalDevices" );
	vkGetPhysicalDeviceFeatures = cast( typeof( vkGetPhysicalDeviceFeatures )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceFeatures" );
	vkGetPhysicalDeviceFormatProperties = cast( typeof( vkGetPhysicalDeviceFormatProperties )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceFormatProperties" );
	vkGetPhysicalDeviceImageFormatProperties = cast( typeof( vkGetPhysicalDeviceImageFormatProperties )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceImageFormatProperties" );
	vkGetPhysicalDeviceProperties = cast( typeof( vkGetPhysicalDeviceProperties )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceProperties" );
	vkGetPhysicalDeviceQueueFamilyProperties = cast( typeof( vkGetPhysicalDeviceQueueFamilyProperties )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceQueueFamilyProperties" );
	vkGetPhysicalDeviceMemoryProperties = cast( typeof( vkGetPhysicalDeviceMemoryProperties )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceMemoryProperties" );
	vkGetDeviceProcAddr = cast( typeof( vkGetDeviceProcAddr )) vkGetInstanceProcAddr( instance, "vkGetDeviceProcAddr" );
	vkCreateDevice = cast( typeof( vkCreateDevice )) vkGetInstanceProcAddr( instance, "vkCreateDevice" );
	vkEnumerateDeviceExtensionProperties = cast( typeof( vkEnumerateDeviceExtensionProperties )) vkGetInstanceProcAddr( instance, "vkEnumerateDeviceExtensionProperties" );
	vkEnumerateDeviceLayerProperties = cast( typeof( vkEnumerateDeviceLayerProperties )) vkGetInstanceProcAddr( instance, "vkEnumerateDeviceLayerProperties" );
	vkGetPhysicalDeviceSparseImageFormatProperties = cast( typeof( vkGetPhysicalDeviceSparseImageFormatProperties )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceSparseImageFormatProperties" );

	// VK_VERSION_1_1
	vkEnumerateInstanceVersion = cast( typeof( vkEnumerateInstanceVersion )) vkGetInstanceProcAddr( instance, "vkEnumerateInstanceVersion" );
	vkEnumeratePhysicalDeviceGroups = cast( typeof( vkEnumeratePhysicalDeviceGroups )) vkGetInstanceProcAddr( instance, "vkEnumeratePhysicalDeviceGroups" );
	vkGetPhysicalDeviceFeatures2 = cast( typeof( vkGetPhysicalDeviceFeatures2 )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceFeatures2" );
	vkGetPhysicalDeviceProperties2 = cast( typeof( vkGetPhysicalDeviceProperties2 )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceProperties2" );
	vkGetPhysicalDeviceFormatProperties2 = cast( typeof( vkGetPhysicalDeviceFormatProperties2 )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceFormatProperties2" );
	vkGetPhysicalDeviceImageFormatProperties2 = cast( typeof( vkGetPhysicalDeviceImageFormatProperties2 )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceImageFormatProperties2" );
	vkGetPhysicalDeviceQueueFamilyProperties2 = cast( typeof( vkGetPhysicalDeviceQueueFamilyProperties2 )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceQueueFamilyProperties2" );
	vkGetPhysicalDeviceMemoryProperties2 = cast( typeof( vkGetPhysicalDeviceMemoryProperties2 )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceMemoryProperties2" );
	vkGetPhysicalDeviceSparseImageFormatProperties2 = cast( typeof( vkGetPhysicalDeviceSparseImageFormatProperties2 )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceSparseImageFormatProperties2" );
	vkGetPhysicalDeviceExternalBufferProperties = cast( typeof( vkGetPhysicalDeviceExternalBufferProperties )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceExternalBufferProperties" );
	vkGetPhysicalDeviceExternalFenceProperties = cast( typeof( vkGetPhysicalDeviceExternalFenceProperties )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceExternalFenceProperties" );
	vkGetPhysicalDeviceExternalSemaphoreProperties = cast( typeof( vkGetPhysicalDeviceExternalSemaphoreProperties )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceExternalSemaphoreProperties" );

	// VK_VERSION_1_3
	vkGetPhysicalDeviceToolProperties = cast( typeof( vkGetPhysicalDeviceToolProperties )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceToolProperties" );

	// VK_KHR_surface
	vkDestroySurfaceKHR = cast( typeof( vkDestroySurfaceKHR )) vkGetInstanceProcAddr( instance, "vkDestroySurfaceKHR" );
	vkGetPhysicalDeviceSurfaceSupportKHR = cast( typeof( vkGetPhysicalDeviceSurfaceSupportKHR )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceSurfaceSupportKHR" );
	vkGetPhysicalDeviceSurfaceCapabilitiesKHR = cast( typeof( vkGetPhysicalDeviceSurfaceCapabilitiesKHR )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceSurfaceCapabilitiesKHR" );
	vkGetPhysicalDeviceSurfaceFormatsKHR = cast( typeof( vkGetPhysicalDeviceSurfaceFormatsKHR )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceSurfaceFormatsKHR" );
	vkGetPhysicalDeviceSurfacePresentModesKHR = cast( typeof( vkGetPhysicalDeviceSurfacePresentModesKHR )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceSurfacePresentModesKHR" );

	// VK_KHR_swapchain
	vkGetPhysicalDevicePresentRectanglesKHR = cast( typeof( vkGetPhysicalDevicePresentRectanglesKHR )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDevicePresentRectanglesKHR" );

	// VK_KHR_xlib_surface
	version( gd_X11Impl ) {
		vkCreateXlibSurfaceKHR = cast( typeof( vkCreateXlibSurfaceKHR )) vkGetInstanceProcAddr( instance, "vkCreateXlibSurfaceKHR" );
		vkGetPhysicalDeviceXlibPresentationSupportKHR = cast( typeof( vkGetPhysicalDeviceXlibPresentationSupportKHR )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceXlibPresentationSupportKHR" );
	}

	// VK_KHR_win32_surface
	version( gd_Win32 ) {
		vkCreateWin32SurfaceKHR = cast( typeof( vkCreateWin32SurfaceKHR )) vkGetInstanceProcAddr( instance, "vkCreateWin32SurfaceKHR" );
		vkGetPhysicalDeviceWin32PresentationSupportKHR = cast( typeof( vkGetPhysicalDeviceWin32PresentationSupportKHR )) vkGetInstanceProcAddr( instance, "vkGetPhysicalDeviceWin32PresentationSupportKHR" );
	}

	// VK_EXT_debug_utils
	vkCreateDebugUtilsMessengerEXT = cast( typeof( vkCreateDebugUtilsMessengerEXT )) vkGetInstanceProcAddr( instance, "vkCreateDebugUtilsMessengerEXT" );
	vkDestroyDebugUtilsMessengerEXT = cast( typeof( vkDestroyDebugUtilsMessengerEXT )) vkGetInstanceProcAddr( instance, "vkDestroyDebugUtilsMessengerEXT" );
	vkSubmitDebugUtilsMessageEXT = cast( typeof( vkSubmitDebugUtilsMessageEXT )) vkGetInstanceProcAddr( instance, "vkSubmitDebugUtilsMessageEXT" );
}

/// with a valid VkInstance call this function to retrieve VkDevice, VkQueue and VkCommandBuffer related functions
/// the functions call indirectly through the VkInstance and will be internally dispatched by the implementation
/// use loadDeviceLevelFunctions( VkDevice device ) bellow to avoid this indirection and get the pointers directly form a VkDevice
void loadDeviceLevelFunctions( VkInstance instance ) {
	assert( vkGetInstanceProcAddr !is null, "Must call loadInstanceLevelFunctions before loadDeviceLevelFunctions" );

	// VK_VERSION_1_0
	vkDestroyDevice = cast( typeof( vkDestroyDevice )) vkGetInstanceProcAddr( instance, "vkDestroyDevice" );
	vkGetDeviceQueue = cast( typeof( vkGetDeviceQueue )) vkGetInstanceProcAddr( instance, "vkGetDeviceQueue" );
	vkQueueSubmit = cast( typeof( vkQueueSubmit )) vkGetInstanceProcAddr( instance, "vkQueueSubmit" );
	vkQueueWaitIdle = cast( typeof( vkQueueWaitIdle )) vkGetInstanceProcAddr( instance, "vkQueueWaitIdle" );
	vkDeviceWaitIdle = cast( typeof( vkDeviceWaitIdle )) vkGetInstanceProcAddr( instance, "vkDeviceWaitIdle" );
	vkAllocateMemory = cast( typeof( vkAllocateMemory )) vkGetInstanceProcAddr( instance, "vkAllocateMemory" );
	vkFreeMemory = cast( typeof( vkFreeMemory )) vkGetInstanceProcAddr( instance, "vkFreeMemory" );
	vkMapMemory = cast( typeof( vkMapMemory )) vkGetInstanceProcAddr( instance, "vkMapMemory" );
	vkUnmapMemory = cast( typeof( vkUnmapMemory )) vkGetInstanceProcAddr( instance, "vkUnmapMemory" );
	vkFlushMappedMemoryRanges = cast( typeof( vkFlushMappedMemoryRanges )) vkGetInstanceProcAddr( instance, "vkFlushMappedMemoryRanges" );
	vkInvalidateMappedMemoryRanges = cast( typeof( vkInvalidateMappedMemoryRanges )) vkGetInstanceProcAddr( instance, "vkInvalidateMappedMemoryRanges" );
	vkGetDeviceMemoryCommitment = cast( typeof( vkGetDeviceMemoryCommitment )) vkGetInstanceProcAddr( instance, "vkGetDeviceMemoryCommitment" );
	vkBindBufferMemory = cast( typeof( vkBindBufferMemory )) vkGetInstanceProcAddr( instance, "vkBindBufferMemory" );
	vkBindImageMemory = cast( typeof( vkBindImageMemory )) vkGetInstanceProcAddr( instance, "vkBindImageMemory" );
	vkGetBufferMemoryRequirements = cast( typeof( vkGetBufferMemoryRequirements )) vkGetInstanceProcAddr( instance, "vkGetBufferMemoryRequirements" );
	vkGetImageMemoryRequirements = cast( typeof( vkGetImageMemoryRequirements )) vkGetInstanceProcAddr( instance, "vkGetImageMemoryRequirements" );
	vkGetImageSparseMemoryRequirements = cast( typeof( vkGetImageSparseMemoryRequirements )) vkGetInstanceProcAddr( instance, "vkGetImageSparseMemoryRequirements" );
	vkQueueBindSparse = cast( typeof( vkQueueBindSparse )) vkGetInstanceProcAddr( instance, "vkQueueBindSparse" );
	vkCreateFence = cast( typeof( vkCreateFence )) vkGetInstanceProcAddr( instance, "vkCreateFence" );
	vkDestroyFence = cast( typeof( vkDestroyFence )) vkGetInstanceProcAddr( instance, "vkDestroyFence" );
	vkResetFences = cast( typeof( vkResetFences )) vkGetInstanceProcAddr( instance, "vkResetFences" );
	vkGetFenceStatus = cast( typeof( vkGetFenceStatus )) vkGetInstanceProcAddr( instance, "vkGetFenceStatus" );
	vkWaitForFences = cast( typeof( vkWaitForFences )) vkGetInstanceProcAddr( instance, "vkWaitForFences" );
	vkCreateSemaphore = cast( typeof( vkCreateSemaphore )) vkGetInstanceProcAddr( instance, "vkCreateSemaphore" );
	vkDestroySemaphore = cast( typeof( vkDestroySemaphore )) vkGetInstanceProcAddr( instance, "vkDestroySemaphore" );
	vkCreateEvent = cast( typeof( vkCreateEvent )) vkGetInstanceProcAddr( instance, "vkCreateEvent" );
	vkDestroyEvent = cast( typeof( vkDestroyEvent )) vkGetInstanceProcAddr( instance, "vkDestroyEvent" );
	vkGetEventStatus = cast( typeof( vkGetEventStatus )) vkGetInstanceProcAddr( instance, "vkGetEventStatus" );
	vkSetEvent = cast( typeof( vkSetEvent )) vkGetInstanceProcAddr( instance, "vkSetEvent" );
	vkResetEvent = cast( typeof( vkResetEvent )) vkGetInstanceProcAddr( instance, "vkResetEvent" );
	vkCreateQueryPool = cast( typeof( vkCreateQueryPool )) vkGetInstanceProcAddr( instance, "vkCreateQueryPool" );
	vkDestroyQueryPool = cast( typeof( vkDestroyQueryPool )) vkGetInstanceProcAddr( instance, "vkDestroyQueryPool" );
	vkGetQueryPoolResults = cast( typeof( vkGetQueryPoolResults )) vkGetInstanceProcAddr( instance, "vkGetQueryPoolResults" );
	vkCreateBuffer = cast( typeof( vkCreateBuffer )) vkGetInstanceProcAddr( instance, "vkCreateBuffer" );
	vkDestroyBuffer = cast( typeof( vkDestroyBuffer )) vkGetInstanceProcAddr( instance, "vkDestroyBuffer" );
	vkCreateBufferView = cast( typeof( vkCreateBufferView )) vkGetInstanceProcAddr( instance, "vkCreateBufferView" );
	vkDestroyBufferView = cast( typeof( vkDestroyBufferView )) vkGetInstanceProcAddr( instance, "vkDestroyBufferView" );
	vkCreateImage = cast( typeof( vkCreateImage )) vkGetInstanceProcAddr( instance, "vkCreateImage" );
	vkDestroyImage = cast( typeof( vkDestroyImage )) vkGetInstanceProcAddr( instance, "vkDestroyImage" );
	vkGetImageSubresourceLayout = cast( typeof( vkGetImageSubresourceLayout )) vkGetInstanceProcAddr( instance, "vkGetImageSubresourceLayout" );
	vkCreateImageView = cast( typeof( vkCreateImageView )) vkGetInstanceProcAddr( instance, "vkCreateImageView" );
	vkDestroyImageView = cast( typeof( vkDestroyImageView )) vkGetInstanceProcAddr( instance, "vkDestroyImageView" );
	vkCreateShaderModule = cast( typeof( vkCreateShaderModule )) vkGetInstanceProcAddr( instance, "vkCreateShaderModule" );
	vkDestroyShaderModule = cast( typeof( vkDestroyShaderModule )) vkGetInstanceProcAddr( instance, "vkDestroyShaderModule" );
	vkCreatePipelineCache = cast( typeof( vkCreatePipelineCache )) vkGetInstanceProcAddr( instance, "vkCreatePipelineCache" );
	vkDestroyPipelineCache = cast( typeof( vkDestroyPipelineCache )) vkGetInstanceProcAddr( instance, "vkDestroyPipelineCache" );
	vkGetPipelineCacheData = cast( typeof( vkGetPipelineCacheData )) vkGetInstanceProcAddr( instance, "vkGetPipelineCacheData" );
	vkMergePipelineCaches = cast( typeof( vkMergePipelineCaches )) vkGetInstanceProcAddr( instance, "vkMergePipelineCaches" );
	vkCreateGraphicsPipelines = cast( typeof( vkCreateGraphicsPipelines )) vkGetInstanceProcAddr( instance, "vkCreateGraphicsPipelines" );
	vkCreateComputePipelines = cast( typeof( vkCreateComputePipelines )) vkGetInstanceProcAddr( instance, "vkCreateComputePipelines" );
	vkDestroyPipeline = cast( typeof( vkDestroyPipeline )) vkGetInstanceProcAddr( instance, "vkDestroyPipeline" );
	vkCreatePipelineLayout = cast( typeof( vkCreatePipelineLayout )) vkGetInstanceProcAddr( instance, "vkCreatePipelineLayout" );
	vkDestroyPipelineLayout = cast( typeof( vkDestroyPipelineLayout )) vkGetInstanceProcAddr( instance, "vkDestroyPipelineLayout" );
	vkCreateSampler = cast( typeof( vkCreateSampler )) vkGetInstanceProcAddr( instance, "vkCreateSampler" );
	vkDestroySampler = cast( typeof( vkDestroySampler )) vkGetInstanceProcAddr( instance, "vkDestroySampler" );
	vkCreateDescriptorSetLayout = cast( typeof( vkCreateDescriptorSetLayout )) vkGetInstanceProcAddr( instance, "vkCreateDescriptorSetLayout" );
	vkDestroyDescriptorSetLayout = cast( typeof( vkDestroyDescriptorSetLayout )) vkGetInstanceProcAddr( instance, "vkDestroyDescriptorSetLayout" );
	vkCreateDescriptorPool = cast( typeof( vkCreateDescriptorPool )) vkGetInstanceProcAddr( instance, "vkCreateDescriptorPool" );
	vkDestroyDescriptorPool = cast( typeof( vkDestroyDescriptorPool )) vkGetInstanceProcAddr( instance, "vkDestroyDescriptorPool" );
	vkResetDescriptorPool = cast( typeof( vkResetDescriptorPool )) vkGetInstanceProcAddr( instance, "vkResetDescriptorPool" );
	vkAllocateDescriptorSets = cast( typeof( vkAllocateDescriptorSets )) vkGetInstanceProcAddr( instance, "vkAllocateDescriptorSets" );
	vkFreeDescriptorSets = cast( typeof( vkFreeDescriptorSets )) vkGetInstanceProcAddr( instance, "vkFreeDescriptorSets" );
	vkUpdateDescriptorSets = cast( typeof( vkUpdateDescriptorSets )) vkGetInstanceProcAddr( instance, "vkUpdateDescriptorSets" );
	vkCreateFramebuffer = cast( typeof( vkCreateFramebuffer )) vkGetInstanceProcAddr( instance, "vkCreateFramebuffer" );
	vkDestroyFramebuffer = cast( typeof( vkDestroyFramebuffer )) vkGetInstanceProcAddr( instance, "vkDestroyFramebuffer" );
	vkCreateRenderPass = cast( typeof( vkCreateRenderPass )) vkGetInstanceProcAddr( instance, "vkCreateRenderPass" );
	vkDestroyRenderPass = cast( typeof( vkDestroyRenderPass )) vkGetInstanceProcAddr( instance, "vkDestroyRenderPass" );
	vkGetRenderAreaGranularity = cast( typeof( vkGetRenderAreaGranularity )) vkGetInstanceProcAddr( instance, "vkGetRenderAreaGranularity" );
	vkCreateCommandPool = cast( typeof( vkCreateCommandPool )) vkGetInstanceProcAddr( instance, "vkCreateCommandPool" );
	vkDestroyCommandPool = cast( typeof( vkDestroyCommandPool )) vkGetInstanceProcAddr( instance, "vkDestroyCommandPool" );
	vkResetCommandPool = cast( typeof( vkResetCommandPool )) vkGetInstanceProcAddr( instance, "vkResetCommandPool" );
	vkAllocateCommandBuffers = cast( typeof( vkAllocateCommandBuffers )) vkGetInstanceProcAddr( instance, "vkAllocateCommandBuffers" );
	vkFreeCommandBuffers = cast( typeof( vkFreeCommandBuffers )) vkGetInstanceProcAddr( instance, "vkFreeCommandBuffers" );
	vkBeginCommandBuffer = cast( typeof( vkBeginCommandBuffer )) vkGetInstanceProcAddr( instance, "vkBeginCommandBuffer" );
	vkEndCommandBuffer = cast( typeof( vkEndCommandBuffer )) vkGetInstanceProcAddr( instance, "vkEndCommandBuffer" );
	vkResetCommandBuffer = cast( typeof( vkResetCommandBuffer )) vkGetInstanceProcAddr( instance, "vkResetCommandBuffer" );
	vkCmdBindPipeline = cast( typeof( vkCmdBindPipeline )) vkGetInstanceProcAddr( instance, "vkCmdBindPipeline" );
	vkCmdSetViewport = cast( typeof( vkCmdSetViewport )) vkGetInstanceProcAddr( instance, "vkCmdSetViewport" );
	vkCmdSetScissor = cast( typeof( vkCmdSetScissor )) vkGetInstanceProcAddr( instance, "vkCmdSetScissor" );
	vkCmdSetLineWidth = cast( typeof( vkCmdSetLineWidth )) vkGetInstanceProcAddr( instance, "vkCmdSetLineWidth" );
	vkCmdSetDepthBias = cast( typeof( vkCmdSetDepthBias )) vkGetInstanceProcAddr( instance, "vkCmdSetDepthBias" );
	vkCmdSetBlendConstants = cast( typeof( vkCmdSetBlendConstants )) vkGetInstanceProcAddr( instance, "vkCmdSetBlendConstants" );
	vkCmdSetDepthBounds = cast( typeof( vkCmdSetDepthBounds )) vkGetInstanceProcAddr( instance, "vkCmdSetDepthBounds" );
	vkCmdSetStencilCompareMask = cast( typeof( vkCmdSetStencilCompareMask )) vkGetInstanceProcAddr( instance, "vkCmdSetStencilCompareMask" );
	vkCmdSetStencilWriteMask = cast( typeof( vkCmdSetStencilWriteMask )) vkGetInstanceProcAddr( instance, "vkCmdSetStencilWriteMask" );
	vkCmdSetStencilReference = cast( typeof( vkCmdSetStencilReference )) vkGetInstanceProcAddr( instance, "vkCmdSetStencilReference" );
	vkCmdBindDescriptorSets = cast( typeof( vkCmdBindDescriptorSets )) vkGetInstanceProcAddr( instance, "vkCmdBindDescriptorSets" );
	vkCmdBindIndexBuffer = cast( typeof( vkCmdBindIndexBuffer )) vkGetInstanceProcAddr( instance, "vkCmdBindIndexBuffer" );
	vkCmdBindVertexBuffers = cast( typeof( vkCmdBindVertexBuffers )) vkGetInstanceProcAddr( instance, "vkCmdBindVertexBuffers" );
	vkCmdDraw = cast( typeof( vkCmdDraw )) vkGetInstanceProcAddr( instance, "vkCmdDraw" );
	vkCmdDrawIndexed = cast( typeof( vkCmdDrawIndexed )) vkGetInstanceProcAddr( instance, "vkCmdDrawIndexed" );
	vkCmdDrawIndirect = cast( typeof( vkCmdDrawIndirect )) vkGetInstanceProcAddr( instance, "vkCmdDrawIndirect" );
	vkCmdDrawIndexedIndirect = cast( typeof( vkCmdDrawIndexedIndirect )) vkGetInstanceProcAddr( instance, "vkCmdDrawIndexedIndirect" );
	vkCmdDispatch = cast( typeof( vkCmdDispatch )) vkGetInstanceProcAddr( instance, "vkCmdDispatch" );
	vkCmdDispatchIndirect = cast( typeof( vkCmdDispatchIndirect )) vkGetInstanceProcAddr( instance, "vkCmdDispatchIndirect" );
	vkCmdCopyBuffer = cast( typeof( vkCmdCopyBuffer )) vkGetInstanceProcAddr( instance, "vkCmdCopyBuffer" );
	vkCmdCopyImage = cast( typeof( vkCmdCopyImage )) vkGetInstanceProcAddr( instance, "vkCmdCopyImage" );
	vkCmdBlitImage = cast( typeof( vkCmdBlitImage )) vkGetInstanceProcAddr( instance, "vkCmdBlitImage" );
	vkCmdCopyBufferToImage = cast( typeof( vkCmdCopyBufferToImage )) vkGetInstanceProcAddr( instance, "vkCmdCopyBufferToImage" );
	vkCmdCopyImageToBuffer = cast( typeof( vkCmdCopyImageToBuffer )) vkGetInstanceProcAddr( instance, "vkCmdCopyImageToBuffer" );
	vkCmdUpdateBuffer = cast( typeof( vkCmdUpdateBuffer )) vkGetInstanceProcAddr( instance, "vkCmdUpdateBuffer" );
	vkCmdFillBuffer = cast( typeof( vkCmdFillBuffer )) vkGetInstanceProcAddr( instance, "vkCmdFillBuffer" );
	vkCmdClearColorImage = cast( typeof( vkCmdClearColorImage )) vkGetInstanceProcAddr( instance, "vkCmdClearColorImage" );
	vkCmdClearDepthStencilImage = cast( typeof( vkCmdClearDepthStencilImage )) vkGetInstanceProcAddr( instance, "vkCmdClearDepthStencilImage" );
	vkCmdClearAttachments = cast( typeof( vkCmdClearAttachments )) vkGetInstanceProcAddr( instance, "vkCmdClearAttachments" );
	vkCmdResolveImage = cast( typeof( vkCmdResolveImage )) vkGetInstanceProcAddr( instance, "vkCmdResolveImage" );
	vkCmdSetEvent = cast( typeof( vkCmdSetEvent )) vkGetInstanceProcAddr( instance, "vkCmdSetEvent" );
	vkCmdResetEvent = cast( typeof( vkCmdResetEvent )) vkGetInstanceProcAddr( instance, "vkCmdResetEvent" );
	vkCmdWaitEvents = cast( typeof( vkCmdWaitEvents )) vkGetInstanceProcAddr( instance, "vkCmdWaitEvents" );
	vkCmdPipelineBarrier = cast( typeof( vkCmdPipelineBarrier )) vkGetInstanceProcAddr( instance, "vkCmdPipelineBarrier" );
	vkCmdBeginQuery = cast( typeof( vkCmdBeginQuery )) vkGetInstanceProcAddr( instance, "vkCmdBeginQuery" );
	vkCmdEndQuery = cast( typeof( vkCmdEndQuery )) vkGetInstanceProcAddr( instance, "vkCmdEndQuery" );
	vkCmdResetQueryPool = cast( typeof( vkCmdResetQueryPool )) vkGetInstanceProcAddr( instance, "vkCmdResetQueryPool" );
	vkCmdWriteTimestamp = cast( typeof( vkCmdWriteTimestamp )) vkGetInstanceProcAddr( instance, "vkCmdWriteTimestamp" );
	vkCmdCopyQueryPoolResults = cast( typeof( vkCmdCopyQueryPoolResults )) vkGetInstanceProcAddr( instance, "vkCmdCopyQueryPoolResults" );
	vkCmdPushConstants = cast( typeof( vkCmdPushConstants )) vkGetInstanceProcAddr( instance, "vkCmdPushConstants" );
	vkCmdBeginRenderPass = cast( typeof( vkCmdBeginRenderPass )) vkGetInstanceProcAddr( instance, "vkCmdBeginRenderPass" );
	vkCmdNextSubpass = cast( typeof( vkCmdNextSubpass )) vkGetInstanceProcAddr( instance, "vkCmdNextSubpass" );
	vkCmdEndRenderPass = cast( typeof( vkCmdEndRenderPass )) vkGetInstanceProcAddr( instance, "vkCmdEndRenderPass" );
	vkCmdExecuteCommands = cast( typeof( vkCmdExecuteCommands )) vkGetInstanceProcAddr( instance, "vkCmdExecuteCommands" );

	// VK_VERSION_1_1
	vkBindBufferMemory2 = cast( typeof( vkBindBufferMemory2 )) vkGetInstanceProcAddr( instance, "vkBindBufferMemory2" );
	vkBindImageMemory2 = cast( typeof( vkBindImageMemory2 )) vkGetInstanceProcAddr( instance, "vkBindImageMemory2" );
	vkGetDeviceGroupPeerMemoryFeatures = cast( typeof( vkGetDeviceGroupPeerMemoryFeatures )) vkGetInstanceProcAddr( instance, "vkGetDeviceGroupPeerMemoryFeatures" );
	vkCmdSetDeviceMask = cast( typeof( vkCmdSetDeviceMask )) vkGetInstanceProcAddr( instance, "vkCmdSetDeviceMask" );
	vkCmdDispatchBase = cast( typeof( vkCmdDispatchBase )) vkGetInstanceProcAddr( instance, "vkCmdDispatchBase" );
	vkGetImageMemoryRequirements2 = cast( typeof( vkGetImageMemoryRequirements2 )) vkGetInstanceProcAddr( instance, "vkGetImageMemoryRequirements2" );
	vkGetBufferMemoryRequirements2 = cast( typeof( vkGetBufferMemoryRequirements2 )) vkGetInstanceProcAddr( instance, "vkGetBufferMemoryRequirements2" );
	vkGetImageSparseMemoryRequirements2 = cast( typeof( vkGetImageSparseMemoryRequirements2 )) vkGetInstanceProcAddr( instance, "vkGetImageSparseMemoryRequirements2" );
	vkTrimCommandPool = cast( typeof( vkTrimCommandPool )) vkGetInstanceProcAddr( instance, "vkTrimCommandPool" );
	vkGetDeviceQueue2 = cast( typeof( vkGetDeviceQueue2 )) vkGetInstanceProcAddr( instance, "vkGetDeviceQueue2" );
	vkCreateSamplerYcbcrConversion = cast( typeof( vkCreateSamplerYcbcrConversion )) vkGetInstanceProcAddr( instance, "vkCreateSamplerYcbcrConversion" );
	vkDestroySamplerYcbcrConversion = cast( typeof( vkDestroySamplerYcbcrConversion )) vkGetInstanceProcAddr( instance, "vkDestroySamplerYcbcrConversion" );
	vkCreateDescriptorUpdateTemplate = cast( typeof( vkCreateDescriptorUpdateTemplate )) vkGetInstanceProcAddr( instance, "vkCreateDescriptorUpdateTemplate" );
	vkDestroyDescriptorUpdateTemplate = cast( typeof( vkDestroyDescriptorUpdateTemplate )) vkGetInstanceProcAddr( instance, "vkDestroyDescriptorUpdateTemplate" );
	vkUpdateDescriptorSetWithTemplate = cast( typeof( vkUpdateDescriptorSetWithTemplate )) vkGetInstanceProcAddr( instance, "vkUpdateDescriptorSetWithTemplate" );
	vkGetDescriptorSetLayoutSupport = cast( typeof( vkGetDescriptorSetLayoutSupport )) vkGetInstanceProcAddr( instance, "vkGetDescriptorSetLayoutSupport" );

	// VK_VERSION_1_2
	vkCmdDrawIndirectCount = cast( typeof( vkCmdDrawIndirectCount )) vkGetInstanceProcAddr( instance, "vkCmdDrawIndirectCount" );
	vkCmdDrawIndexedIndirectCount = cast( typeof( vkCmdDrawIndexedIndirectCount )) vkGetInstanceProcAddr( instance, "vkCmdDrawIndexedIndirectCount" );
	vkCreateRenderPass2 = cast( typeof( vkCreateRenderPass2 )) vkGetInstanceProcAddr( instance, "vkCreateRenderPass2" );
	vkCmdBeginRenderPass2 = cast( typeof( vkCmdBeginRenderPass2 )) vkGetInstanceProcAddr( instance, "vkCmdBeginRenderPass2" );
	vkCmdNextSubpass2 = cast( typeof( vkCmdNextSubpass2 )) vkGetInstanceProcAddr( instance, "vkCmdNextSubpass2" );
	vkCmdEndRenderPass2 = cast( typeof( vkCmdEndRenderPass2 )) vkGetInstanceProcAddr( instance, "vkCmdEndRenderPass2" );
	vkResetQueryPool = cast( typeof( vkResetQueryPool )) vkGetInstanceProcAddr( instance, "vkResetQueryPool" );
	vkGetSemaphoreCounterValue = cast( typeof( vkGetSemaphoreCounterValue )) vkGetInstanceProcAddr( instance, "vkGetSemaphoreCounterValue" );
	vkWaitSemaphores = cast( typeof( vkWaitSemaphores )) vkGetInstanceProcAddr( instance, "vkWaitSemaphores" );
	vkSignalSemaphore = cast( typeof( vkSignalSemaphore )) vkGetInstanceProcAddr( instance, "vkSignalSemaphore" );
	vkGetBufferDeviceAddress = cast( typeof( vkGetBufferDeviceAddress )) vkGetInstanceProcAddr( instance, "vkGetBufferDeviceAddress" );
	vkGetBufferOpaqueCaptureAddress = cast( typeof( vkGetBufferOpaqueCaptureAddress )) vkGetInstanceProcAddr( instance, "vkGetBufferOpaqueCaptureAddress" );
	vkGetDeviceMemoryOpaqueCaptureAddress = cast( typeof( vkGetDeviceMemoryOpaqueCaptureAddress )) vkGetInstanceProcAddr( instance, "vkGetDeviceMemoryOpaqueCaptureAddress" );

	// VK_VERSION_1_3
	vkCreatePrivateDataSlot = cast( typeof( vkCreatePrivateDataSlot )) vkGetInstanceProcAddr( instance, "vkCreatePrivateDataSlot" );
	vkDestroyPrivateDataSlot = cast( typeof( vkDestroyPrivateDataSlot )) vkGetInstanceProcAddr( instance, "vkDestroyPrivateDataSlot" );
	vkSetPrivateData = cast( typeof( vkSetPrivateData )) vkGetInstanceProcAddr( instance, "vkSetPrivateData" );
	vkGetPrivateData = cast( typeof( vkGetPrivateData )) vkGetInstanceProcAddr( instance, "vkGetPrivateData" );
	vkCmdSetEvent2 = cast( typeof( vkCmdSetEvent2 )) vkGetInstanceProcAddr( instance, "vkCmdSetEvent2" );
	vkCmdResetEvent2 = cast( typeof( vkCmdResetEvent2 )) vkGetInstanceProcAddr( instance, "vkCmdResetEvent2" );
	vkCmdWaitEvents2 = cast( typeof( vkCmdWaitEvents2 )) vkGetInstanceProcAddr( instance, "vkCmdWaitEvents2" );
	vkCmdPipelineBarrier2 = cast( typeof( vkCmdPipelineBarrier2 )) vkGetInstanceProcAddr( instance, "vkCmdPipelineBarrier2" );
	vkCmdWriteTimestamp2 = cast( typeof( vkCmdWriteTimestamp2 )) vkGetInstanceProcAddr( instance, "vkCmdWriteTimestamp2" );
	vkQueueSubmit2 = cast( typeof( vkQueueSubmit2 )) vkGetInstanceProcAddr( instance, "vkQueueSubmit2" );
	vkCmdCopyBuffer2 = cast( typeof( vkCmdCopyBuffer2 )) vkGetInstanceProcAddr( instance, "vkCmdCopyBuffer2" );
	vkCmdCopyImage2 = cast( typeof( vkCmdCopyImage2 )) vkGetInstanceProcAddr( instance, "vkCmdCopyImage2" );
	vkCmdCopyBufferToImage2 = cast( typeof( vkCmdCopyBufferToImage2 )) vkGetInstanceProcAddr( instance, "vkCmdCopyBufferToImage2" );
	vkCmdCopyImageToBuffer2 = cast( typeof( vkCmdCopyImageToBuffer2 )) vkGetInstanceProcAddr( instance, "vkCmdCopyImageToBuffer2" );
	vkCmdBlitImage2 = cast( typeof( vkCmdBlitImage2 )) vkGetInstanceProcAddr( instance, "vkCmdBlitImage2" );
	vkCmdResolveImage2 = cast( typeof( vkCmdResolveImage2 )) vkGetInstanceProcAddr( instance, "vkCmdResolveImage2" );
	vkCmdBeginRendering = cast( typeof( vkCmdBeginRendering )) vkGetInstanceProcAddr( instance, "vkCmdBeginRendering" );
	vkCmdEndRendering = cast( typeof( vkCmdEndRendering )) vkGetInstanceProcAddr( instance, "vkCmdEndRendering" );
	vkCmdSetCullMode = cast( typeof( vkCmdSetCullMode )) vkGetInstanceProcAddr( instance, "vkCmdSetCullMode" );
	vkCmdSetFrontFace = cast( typeof( vkCmdSetFrontFace )) vkGetInstanceProcAddr( instance, "vkCmdSetFrontFace" );
	vkCmdSetPrimitiveTopology = cast( typeof( vkCmdSetPrimitiveTopology )) vkGetInstanceProcAddr( instance, "vkCmdSetPrimitiveTopology" );
	vkCmdSetViewportWithCount = cast( typeof( vkCmdSetViewportWithCount )) vkGetInstanceProcAddr( instance, "vkCmdSetViewportWithCount" );
	vkCmdSetScissorWithCount = cast( typeof( vkCmdSetScissorWithCount )) vkGetInstanceProcAddr( instance, "vkCmdSetScissorWithCount" );
	vkCmdBindVertexBuffers2 = cast( typeof( vkCmdBindVertexBuffers2 )) vkGetInstanceProcAddr( instance, "vkCmdBindVertexBuffers2" );
	vkCmdSetDepthTestEnable = cast( typeof( vkCmdSetDepthTestEnable )) vkGetInstanceProcAddr( instance, "vkCmdSetDepthTestEnable" );
	vkCmdSetDepthWriteEnable = cast( typeof( vkCmdSetDepthWriteEnable )) vkGetInstanceProcAddr( instance, "vkCmdSetDepthWriteEnable" );
	vkCmdSetDepthCompareOp = cast( typeof( vkCmdSetDepthCompareOp )) vkGetInstanceProcAddr( instance, "vkCmdSetDepthCompareOp" );
	vkCmdSetDepthBoundsTestEnable = cast( typeof( vkCmdSetDepthBoundsTestEnable )) vkGetInstanceProcAddr( instance, "vkCmdSetDepthBoundsTestEnable" );
	vkCmdSetStencilTestEnable = cast( typeof( vkCmdSetStencilTestEnable )) vkGetInstanceProcAddr( instance, "vkCmdSetStencilTestEnable" );
	vkCmdSetStencilOp = cast( typeof( vkCmdSetStencilOp )) vkGetInstanceProcAddr( instance, "vkCmdSetStencilOp" );
	vkCmdSetRasterizerDiscardEnable = cast( typeof( vkCmdSetRasterizerDiscardEnable )) vkGetInstanceProcAddr( instance, "vkCmdSetRasterizerDiscardEnable" );
	vkCmdSetDepthBiasEnable = cast( typeof( vkCmdSetDepthBiasEnable )) vkGetInstanceProcAddr( instance, "vkCmdSetDepthBiasEnable" );
	vkCmdSetPrimitiveRestartEnable = cast( typeof( vkCmdSetPrimitiveRestartEnable )) vkGetInstanceProcAddr( instance, "vkCmdSetPrimitiveRestartEnable" );
	vkGetDeviceBufferMemoryRequirements = cast( typeof( vkGetDeviceBufferMemoryRequirements )) vkGetInstanceProcAddr( instance, "vkGetDeviceBufferMemoryRequirements" );
	vkGetDeviceImageMemoryRequirements = cast( typeof( vkGetDeviceImageMemoryRequirements )) vkGetInstanceProcAddr( instance, "vkGetDeviceImageMemoryRequirements" );
	vkGetDeviceImageSparseMemoryRequirements = cast( typeof( vkGetDeviceImageSparseMemoryRequirements )) vkGetInstanceProcAddr( instance, "vkGetDeviceImageSparseMemoryRequirements" );

	// VK_KHR_swapchain
	vkCreateSwapchainKHR = cast( typeof( vkCreateSwapchainKHR )) vkGetInstanceProcAddr( instance, "vkCreateSwapchainKHR" );
	vkDestroySwapchainKHR = cast( typeof( vkDestroySwapchainKHR )) vkGetInstanceProcAddr( instance, "vkDestroySwapchainKHR" );
	vkGetSwapchainImagesKHR = cast( typeof( vkGetSwapchainImagesKHR )) vkGetInstanceProcAddr( instance, "vkGetSwapchainImagesKHR" );
	vkAcquireNextImageKHR = cast( typeof( vkAcquireNextImageKHR )) vkGetInstanceProcAddr( instance, "vkAcquireNextImageKHR" );
	vkQueuePresentKHR = cast( typeof( vkQueuePresentKHR )) vkGetInstanceProcAddr( instance, "vkQueuePresentKHR" );
	vkGetDeviceGroupPresentCapabilitiesKHR = cast( typeof( vkGetDeviceGroupPresentCapabilitiesKHR )) vkGetInstanceProcAddr( instance, "vkGetDeviceGroupPresentCapabilitiesKHR" );
	vkGetDeviceGroupSurfacePresentModesKHR = cast( typeof( vkGetDeviceGroupSurfacePresentModesKHR )) vkGetInstanceProcAddr( instance, "vkGetDeviceGroupSurfacePresentModesKHR" );
	vkAcquireNextImage2KHR = cast( typeof( vkAcquireNextImage2KHR )) vkGetInstanceProcAddr( instance, "vkAcquireNextImage2KHR" );

	// VK_EXT_debug_utils
	vkSetDebugUtilsObjectNameEXT = cast( typeof( vkSetDebugUtilsObjectNameEXT )) vkGetInstanceProcAddr( instance, "vkSetDebugUtilsObjectNameEXT" );
	vkSetDebugUtilsObjectTagEXT = cast( typeof( vkSetDebugUtilsObjectTagEXT )) vkGetInstanceProcAddr( instance, "vkSetDebugUtilsObjectTagEXT" );
	vkQueueBeginDebugUtilsLabelEXT = cast( typeof( vkQueueBeginDebugUtilsLabelEXT )) vkGetInstanceProcAddr( instance, "vkQueueBeginDebugUtilsLabelEXT" );
	vkQueueEndDebugUtilsLabelEXT = cast( typeof( vkQueueEndDebugUtilsLabelEXT )) vkGetInstanceProcAddr( instance, "vkQueueEndDebugUtilsLabelEXT" );
	vkQueueInsertDebugUtilsLabelEXT = cast( typeof( vkQueueInsertDebugUtilsLabelEXT )) vkGetInstanceProcAddr( instance, "vkQueueInsertDebugUtilsLabelEXT" );
	vkCmdBeginDebugUtilsLabelEXT = cast( typeof( vkCmdBeginDebugUtilsLabelEXT )) vkGetInstanceProcAddr( instance, "vkCmdBeginDebugUtilsLabelEXT" );
	vkCmdEndDebugUtilsLabelEXT = cast( typeof( vkCmdEndDebugUtilsLabelEXT )) vkGetInstanceProcAddr( instance, "vkCmdEndDebugUtilsLabelEXT" );
	vkCmdInsertDebugUtilsLabelEXT = cast( typeof( vkCmdInsertDebugUtilsLabelEXT )) vkGetInstanceProcAddr( instance, "vkCmdInsertDebugUtilsLabelEXT" );
}

/// with a valid VkDevice call this function to retrieve VkDevice, VkQueue and VkCommandBuffer related functions
/// the functions call directly VkDevice and related resources and can be retrieved for one and only one VkDevice
/// calling this function again with another VkDevices will overwrite the __gshared functions retrieved previously
/// use createGroupedDeviceLevelFunctions bellow if usage of multiple VkDevices is required
void loadDeviceLevelFunctions( VkDevice device ) {
	assert( vkGetDeviceProcAddr !is null, "Must call loadInstanceLevelFunctions before loadDeviceLevelFunctions" );

	// VK_VERSION_1_0
	vkDestroyDevice = cast( typeof( vkDestroyDevice )) vkGetDeviceProcAddr( device, "vkDestroyDevice" );
	vkGetDeviceQueue = cast( typeof( vkGetDeviceQueue )) vkGetDeviceProcAddr( device, "vkGetDeviceQueue" );
	vkQueueSubmit = cast( typeof( vkQueueSubmit )) vkGetDeviceProcAddr( device, "vkQueueSubmit" );
	vkQueueWaitIdle = cast( typeof( vkQueueWaitIdle )) vkGetDeviceProcAddr( device, "vkQueueWaitIdle" );
	vkDeviceWaitIdle = cast( typeof( vkDeviceWaitIdle )) vkGetDeviceProcAddr( device, "vkDeviceWaitIdle" );
	vkAllocateMemory = cast( typeof( vkAllocateMemory )) vkGetDeviceProcAddr( device, "vkAllocateMemory" );
	vkFreeMemory = cast( typeof( vkFreeMemory )) vkGetDeviceProcAddr( device, "vkFreeMemory" );
	vkMapMemory = cast( typeof( vkMapMemory )) vkGetDeviceProcAddr( device, "vkMapMemory" );
	vkUnmapMemory = cast( typeof( vkUnmapMemory )) vkGetDeviceProcAddr( device, "vkUnmapMemory" );
	vkFlushMappedMemoryRanges = cast( typeof( vkFlushMappedMemoryRanges )) vkGetDeviceProcAddr( device, "vkFlushMappedMemoryRanges" );
	vkInvalidateMappedMemoryRanges = cast( typeof( vkInvalidateMappedMemoryRanges )) vkGetDeviceProcAddr( device, "vkInvalidateMappedMemoryRanges" );
	vkGetDeviceMemoryCommitment = cast( typeof( vkGetDeviceMemoryCommitment )) vkGetDeviceProcAddr( device, "vkGetDeviceMemoryCommitment" );
	vkBindBufferMemory = cast( typeof( vkBindBufferMemory )) vkGetDeviceProcAddr( device, "vkBindBufferMemory" );
	vkBindImageMemory = cast( typeof( vkBindImageMemory )) vkGetDeviceProcAddr( device, "vkBindImageMemory" );
	vkGetBufferMemoryRequirements = cast( typeof( vkGetBufferMemoryRequirements )) vkGetDeviceProcAddr( device, "vkGetBufferMemoryRequirements" );
	vkGetImageMemoryRequirements = cast( typeof( vkGetImageMemoryRequirements )) vkGetDeviceProcAddr( device, "vkGetImageMemoryRequirements" );
	vkGetImageSparseMemoryRequirements = cast( typeof( vkGetImageSparseMemoryRequirements )) vkGetDeviceProcAddr( device, "vkGetImageSparseMemoryRequirements" );
	vkQueueBindSparse = cast( typeof( vkQueueBindSparse )) vkGetDeviceProcAddr( device, "vkQueueBindSparse" );
	vkCreateFence = cast( typeof( vkCreateFence )) vkGetDeviceProcAddr( device, "vkCreateFence" );
	vkDestroyFence = cast( typeof( vkDestroyFence )) vkGetDeviceProcAddr( device, "vkDestroyFence" );
	vkResetFences = cast( typeof( vkResetFences )) vkGetDeviceProcAddr( device, "vkResetFences" );
	vkGetFenceStatus = cast( typeof( vkGetFenceStatus )) vkGetDeviceProcAddr( device, "vkGetFenceStatus" );
	vkWaitForFences = cast( typeof( vkWaitForFences )) vkGetDeviceProcAddr( device, "vkWaitForFences" );
	vkCreateSemaphore = cast( typeof( vkCreateSemaphore )) vkGetDeviceProcAddr( device, "vkCreateSemaphore" );
	vkDestroySemaphore = cast( typeof( vkDestroySemaphore )) vkGetDeviceProcAddr( device, "vkDestroySemaphore" );
	vkCreateEvent = cast( typeof( vkCreateEvent )) vkGetDeviceProcAddr( device, "vkCreateEvent" );
	vkDestroyEvent = cast( typeof( vkDestroyEvent )) vkGetDeviceProcAddr( device, "vkDestroyEvent" );
	vkGetEventStatus = cast( typeof( vkGetEventStatus )) vkGetDeviceProcAddr( device, "vkGetEventStatus" );
	vkSetEvent = cast( typeof( vkSetEvent )) vkGetDeviceProcAddr( device, "vkSetEvent" );
	vkResetEvent = cast( typeof( vkResetEvent )) vkGetDeviceProcAddr( device, "vkResetEvent" );
	vkCreateQueryPool = cast( typeof( vkCreateQueryPool )) vkGetDeviceProcAddr( device, "vkCreateQueryPool" );
	vkDestroyQueryPool = cast( typeof( vkDestroyQueryPool )) vkGetDeviceProcAddr( device, "vkDestroyQueryPool" );
	vkGetQueryPoolResults = cast( typeof( vkGetQueryPoolResults )) vkGetDeviceProcAddr( device, "vkGetQueryPoolResults" );
	vkCreateBuffer = cast( typeof( vkCreateBuffer )) vkGetDeviceProcAddr( device, "vkCreateBuffer" );
	vkDestroyBuffer = cast( typeof( vkDestroyBuffer )) vkGetDeviceProcAddr( device, "vkDestroyBuffer" );
	vkCreateBufferView = cast( typeof( vkCreateBufferView )) vkGetDeviceProcAddr( device, "vkCreateBufferView" );
	vkDestroyBufferView = cast( typeof( vkDestroyBufferView )) vkGetDeviceProcAddr( device, "vkDestroyBufferView" );
	vkCreateImage = cast( typeof( vkCreateImage )) vkGetDeviceProcAddr( device, "vkCreateImage" );
	vkDestroyImage = cast( typeof( vkDestroyImage )) vkGetDeviceProcAddr( device, "vkDestroyImage" );
	vkGetImageSubresourceLayout = cast( typeof( vkGetImageSubresourceLayout )) vkGetDeviceProcAddr( device, "vkGetImageSubresourceLayout" );
	vkCreateImageView = cast( typeof( vkCreateImageView )) vkGetDeviceProcAddr( device, "vkCreateImageView" );
	vkDestroyImageView = cast( typeof( vkDestroyImageView )) vkGetDeviceProcAddr( device, "vkDestroyImageView" );
	vkCreateShaderModule = cast( typeof( vkCreateShaderModule )) vkGetDeviceProcAddr( device, "vkCreateShaderModule" );
	vkDestroyShaderModule = cast( typeof( vkDestroyShaderModule )) vkGetDeviceProcAddr( device, "vkDestroyShaderModule" );
	vkCreatePipelineCache = cast( typeof( vkCreatePipelineCache )) vkGetDeviceProcAddr( device, "vkCreatePipelineCache" );
	vkDestroyPipelineCache = cast( typeof( vkDestroyPipelineCache )) vkGetDeviceProcAddr( device, "vkDestroyPipelineCache" );
	vkGetPipelineCacheData = cast( typeof( vkGetPipelineCacheData )) vkGetDeviceProcAddr( device, "vkGetPipelineCacheData" );
	vkMergePipelineCaches = cast( typeof( vkMergePipelineCaches )) vkGetDeviceProcAddr( device, "vkMergePipelineCaches" );
	vkCreateGraphicsPipelines = cast( typeof( vkCreateGraphicsPipelines )) vkGetDeviceProcAddr( device, "vkCreateGraphicsPipelines" );
	vkCreateComputePipelines = cast( typeof( vkCreateComputePipelines )) vkGetDeviceProcAddr( device, "vkCreateComputePipelines" );
	vkDestroyPipeline = cast( typeof( vkDestroyPipeline )) vkGetDeviceProcAddr( device, "vkDestroyPipeline" );
	vkCreatePipelineLayout = cast( typeof( vkCreatePipelineLayout )) vkGetDeviceProcAddr( device, "vkCreatePipelineLayout" );
	vkDestroyPipelineLayout = cast( typeof( vkDestroyPipelineLayout )) vkGetDeviceProcAddr( device, "vkDestroyPipelineLayout" );
	vkCreateSampler = cast( typeof( vkCreateSampler )) vkGetDeviceProcAddr( device, "vkCreateSampler" );
	vkDestroySampler = cast( typeof( vkDestroySampler )) vkGetDeviceProcAddr( device, "vkDestroySampler" );
	vkCreateDescriptorSetLayout = cast( typeof( vkCreateDescriptorSetLayout )) vkGetDeviceProcAddr( device, "vkCreateDescriptorSetLayout" );
	vkDestroyDescriptorSetLayout = cast( typeof( vkDestroyDescriptorSetLayout )) vkGetDeviceProcAddr( device, "vkDestroyDescriptorSetLayout" );
	vkCreateDescriptorPool = cast( typeof( vkCreateDescriptorPool )) vkGetDeviceProcAddr( device, "vkCreateDescriptorPool" );
	vkDestroyDescriptorPool = cast( typeof( vkDestroyDescriptorPool )) vkGetDeviceProcAddr( device, "vkDestroyDescriptorPool" );
	vkResetDescriptorPool = cast( typeof( vkResetDescriptorPool )) vkGetDeviceProcAddr( device, "vkResetDescriptorPool" );
	vkAllocateDescriptorSets = cast( typeof( vkAllocateDescriptorSets )) vkGetDeviceProcAddr( device, "vkAllocateDescriptorSets" );
	vkFreeDescriptorSets = cast( typeof( vkFreeDescriptorSets )) vkGetDeviceProcAddr( device, "vkFreeDescriptorSets" );
	vkUpdateDescriptorSets = cast( typeof( vkUpdateDescriptorSets )) vkGetDeviceProcAddr( device, "vkUpdateDescriptorSets" );
	vkCreateFramebuffer = cast( typeof( vkCreateFramebuffer )) vkGetDeviceProcAddr( device, "vkCreateFramebuffer" );
	vkDestroyFramebuffer = cast( typeof( vkDestroyFramebuffer )) vkGetDeviceProcAddr( device, "vkDestroyFramebuffer" );
	vkCreateRenderPass = cast( typeof( vkCreateRenderPass )) vkGetDeviceProcAddr( device, "vkCreateRenderPass" );
	vkDestroyRenderPass = cast( typeof( vkDestroyRenderPass )) vkGetDeviceProcAddr( device, "vkDestroyRenderPass" );
	vkGetRenderAreaGranularity = cast( typeof( vkGetRenderAreaGranularity )) vkGetDeviceProcAddr( device, "vkGetRenderAreaGranularity" );
	vkCreateCommandPool = cast( typeof( vkCreateCommandPool )) vkGetDeviceProcAddr( device, "vkCreateCommandPool" );
	vkDestroyCommandPool = cast( typeof( vkDestroyCommandPool )) vkGetDeviceProcAddr( device, "vkDestroyCommandPool" );
	vkResetCommandPool = cast( typeof( vkResetCommandPool )) vkGetDeviceProcAddr( device, "vkResetCommandPool" );
	vkAllocateCommandBuffers = cast( typeof( vkAllocateCommandBuffers )) vkGetDeviceProcAddr( device, "vkAllocateCommandBuffers" );
	vkFreeCommandBuffers = cast( typeof( vkFreeCommandBuffers )) vkGetDeviceProcAddr( device, "vkFreeCommandBuffers" );
	vkBeginCommandBuffer = cast( typeof( vkBeginCommandBuffer )) vkGetDeviceProcAddr( device, "vkBeginCommandBuffer" );
	vkEndCommandBuffer = cast( typeof( vkEndCommandBuffer )) vkGetDeviceProcAddr( device, "vkEndCommandBuffer" );
	vkResetCommandBuffer = cast( typeof( vkResetCommandBuffer )) vkGetDeviceProcAddr( device, "vkResetCommandBuffer" );
	vkCmdBindPipeline = cast( typeof( vkCmdBindPipeline )) vkGetDeviceProcAddr( device, "vkCmdBindPipeline" );
	vkCmdSetViewport = cast( typeof( vkCmdSetViewport )) vkGetDeviceProcAddr( device, "vkCmdSetViewport" );
	vkCmdSetScissor = cast( typeof( vkCmdSetScissor )) vkGetDeviceProcAddr( device, "vkCmdSetScissor" );
	vkCmdSetLineWidth = cast( typeof( vkCmdSetLineWidth )) vkGetDeviceProcAddr( device, "vkCmdSetLineWidth" );
	vkCmdSetDepthBias = cast( typeof( vkCmdSetDepthBias )) vkGetDeviceProcAddr( device, "vkCmdSetDepthBias" );
	vkCmdSetBlendConstants = cast( typeof( vkCmdSetBlendConstants )) vkGetDeviceProcAddr( device, "vkCmdSetBlendConstants" );
	vkCmdSetDepthBounds = cast( typeof( vkCmdSetDepthBounds )) vkGetDeviceProcAddr( device, "vkCmdSetDepthBounds" );
	vkCmdSetStencilCompareMask = cast( typeof( vkCmdSetStencilCompareMask )) vkGetDeviceProcAddr( device, "vkCmdSetStencilCompareMask" );
	vkCmdSetStencilWriteMask = cast( typeof( vkCmdSetStencilWriteMask )) vkGetDeviceProcAddr( device, "vkCmdSetStencilWriteMask" );
	vkCmdSetStencilReference = cast( typeof( vkCmdSetStencilReference )) vkGetDeviceProcAddr( device, "vkCmdSetStencilReference" );
	vkCmdBindDescriptorSets = cast( typeof( vkCmdBindDescriptorSets )) vkGetDeviceProcAddr( device, "vkCmdBindDescriptorSets" );
	vkCmdBindIndexBuffer = cast( typeof( vkCmdBindIndexBuffer )) vkGetDeviceProcAddr( device, "vkCmdBindIndexBuffer" );
	vkCmdBindVertexBuffers = cast( typeof( vkCmdBindVertexBuffers )) vkGetDeviceProcAddr( device, "vkCmdBindVertexBuffers" );
	vkCmdDraw = cast( typeof( vkCmdDraw )) vkGetDeviceProcAddr( device, "vkCmdDraw" );
	vkCmdDrawIndexed = cast( typeof( vkCmdDrawIndexed )) vkGetDeviceProcAddr( device, "vkCmdDrawIndexed" );
	vkCmdDrawIndirect = cast( typeof( vkCmdDrawIndirect )) vkGetDeviceProcAddr( device, "vkCmdDrawIndirect" );
	vkCmdDrawIndexedIndirect = cast( typeof( vkCmdDrawIndexedIndirect )) vkGetDeviceProcAddr( device, "vkCmdDrawIndexedIndirect" );
	vkCmdDispatch = cast( typeof( vkCmdDispatch )) vkGetDeviceProcAddr( device, "vkCmdDispatch" );
	vkCmdDispatchIndirect = cast( typeof( vkCmdDispatchIndirect )) vkGetDeviceProcAddr( device, "vkCmdDispatchIndirect" );
	vkCmdCopyBuffer = cast( typeof( vkCmdCopyBuffer )) vkGetDeviceProcAddr( device, "vkCmdCopyBuffer" );
	vkCmdCopyImage = cast( typeof( vkCmdCopyImage )) vkGetDeviceProcAddr( device, "vkCmdCopyImage" );
	vkCmdBlitImage = cast( typeof( vkCmdBlitImage )) vkGetDeviceProcAddr( device, "vkCmdBlitImage" );
	vkCmdCopyBufferToImage = cast( typeof( vkCmdCopyBufferToImage )) vkGetDeviceProcAddr( device, "vkCmdCopyBufferToImage" );
	vkCmdCopyImageToBuffer = cast( typeof( vkCmdCopyImageToBuffer )) vkGetDeviceProcAddr( device, "vkCmdCopyImageToBuffer" );
	vkCmdUpdateBuffer = cast( typeof( vkCmdUpdateBuffer )) vkGetDeviceProcAddr( device, "vkCmdUpdateBuffer" );
	vkCmdFillBuffer = cast( typeof( vkCmdFillBuffer )) vkGetDeviceProcAddr( device, "vkCmdFillBuffer" );
	vkCmdClearColorImage = cast( typeof( vkCmdClearColorImage )) vkGetDeviceProcAddr( device, "vkCmdClearColorImage" );
	vkCmdClearDepthStencilImage = cast( typeof( vkCmdClearDepthStencilImage )) vkGetDeviceProcAddr( device, "vkCmdClearDepthStencilImage" );
	vkCmdClearAttachments = cast( typeof( vkCmdClearAttachments )) vkGetDeviceProcAddr( device, "vkCmdClearAttachments" );
	vkCmdResolveImage = cast( typeof( vkCmdResolveImage )) vkGetDeviceProcAddr( device, "vkCmdResolveImage" );
	vkCmdSetEvent = cast( typeof( vkCmdSetEvent )) vkGetDeviceProcAddr( device, "vkCmdSetEvent" );
	vkCmdResetEvent = cast( typeof( vkCmdResetEvent )) vkGetDeviceProcAddr( device, "vkCmdResetEvent" );
	vkCmdWaitEvents = cast( typeof( vkCmdWaitEvents )) vkGetDeviceProcAddr( device, "vkCmdWaitEvents" );
	vkCmdPipelineBarrier = cast( typeof( vkCmdPipelineBarrier )) vkGetDeviceProcAddr( device, "vkCmdPipelineBarrier" );
	vkCmdBeginQuery = cast( typeof( vkCmdBeginQuery )) vkGetDeviceProcAddr( device, "vkCmdBeginQuery" );
	vkCmdEndQuery = cast( typeof( vkCmdEndQuery )) vkGetDeviceProcAddr( device, "vkCmdEndQuery" );
	vkCmdResetQueryPool = cast( typeof( vkCmdResetQueryPool )) vkGetDeviceProcAddr( device, "vkCmdResetQueryPool" );
	vkCmdWriteTimestamp = cast( typeof( vkCmdWriteTimestamp )) vkGetDeviceProcAddr( device, "vkCmdWriteTimestamp" );
	vkCmdCopyQueryPoolResults = cast( typeof( vkCmdCopyQueryPoolResults )) vkGetDeviceProcAddr( device, "vkCmdCopyQueryPoolResults" );
	vkCmdPushConstants = cast( typeof( vkCmdPushConstants )) vkGetDeviceProcAddr( device, "vkCmdPushConstants" );
	vkCmdBeginRenderPass = cast( typeof( vkCmdBeginRenderPass )) vkGetDeviceProcAddr( device, "vkCmdBeginRenderPass" );
	vkCmdNextSubpass = cast( typeof( vkCmdNextSubpass )) vkGetDeviceProcAddr( device, "vkCmdNextSubpass" );
	vkCmdEndRenderPass = cast( typeof( vkCmdEndRenderPass )) vkGetDeviceProcAddr( device, "vkCmdEndRenderPass" );
	vkCmdExecuteCommands = cast( typeof( vkCmdExecuteCommands )) vkGetDeviceProcAddr( device, "vkCmdExecuteCommands" );

	// VK_VERSION_1_1
	vkBindBufferMemory2 = cast( typeof( vkBindBufferMemory2 )) vkGetDeviceProcAddr( device, "vkBindBufferMemory2" );
	vkBindImageMemory2 = cast( typeof( vkBindImageMemory2 )) vkGetDeviceProcAddr( device, "vkBindImageMemory2" );
	vkGetDeviceGroupPeerMemoryFeatures = cast( typeof( vkGetDeviceGroupPeerMemoryFeatures )) vkGetDeviceProcAddr( device, "vkGetDeviceGroupPeerMemoryFeatures" );
	vkCmdSetDeviceMask = cast( typeof( vkCmdSetDeviceMask )) vkGetDeviceProcAddr( device, "vkCmdSetDeviceMask" );
	vkCmdDispatchBase = cast( typeof( vkCmdDispatchBase )) vkGetDeviceProcAddr( device, "vkCmdDispatchBase" );
	vkGetImageMemoryRequirements2 = cast( typeof( vkGetImageMemoryRequirements2 )) vkGetDeviceProcAddr( device, "vkGetImageMemoryRequirements2" );
	vkGetBufferMemoryRequirements2 = cast( typeof( vkGetBufferMemoryRequirements2 )) vkGetDeviceProcAddr( device, "vkGetBufferMemoryRequirements2" );
	vkGetImageSparseMemoryRequirements2 = cast( typeof( vkGetImageSparseMemoryRequirements2 )) vkGetDeviceProcAddr( device, "vkGetImageSparseMemoryRequirements2" );
	vkTrimCommandPool = cast( typeof( vkTrimCommandPool )) vkGetDeviceProcAddr( device, "vkTrimCommandPool" );
	vkGetDeviceQueue2 = cast( typeof( vkGetDeviceQueue2 )) vkGetDeviceProcAddr( device, "vkGetDeviceQueue2" );
	vkCreateSamplerYcbcrConversion = cast( typeof( vkCreateSamplerYcbcrConversion )) vkGetDeviceProcAddr( device, "vkCreateSamplerYcbcrConversion" );
	vkDestroySamplerYcbcrConversion = cast( typeof( vkDestroySamplerYcbcrConversion )) vkGetDeviceProcAddr( device, "vkDestroySamplerYcbcrConversion" );
	vkCreateDescriptorUpdateTemplate = cast( typeof( vkCreateDescriptorUpdateTemplate )) vkGetDeviceProcAddr( device, "vkCreateDescriptorUpdateTemplate" );
	vkDestroyDescriptorUpdateTemplate = cast( typeof( vkDestroyDescriptorUpdateTemplate )) vkGetDeviceProcAddr( device, "vkDestroyDescriptorUpdateTemplate" );
	vkUpdateDescriptorSetWithTemplate = cast( typeof( vkUpdateDescriptorSetWithTemplate )) vkGetDeviceProcAddr( device, "vkUpdateDescriptorSetWithTemplate" );
	vkGetDescriptorSetLayoutSupport = cast( typeof( vkGetDescriptorSetLayoutSupport )) vkGetDeviceProcAddr( device, "vkGetDescriptorSetLayoutSupport" );

	// VK_VERSION_1_2
	vkCmdDrawIndirectCount = cast( typeof( vkCmdDrawIndirectCount )) vkGetDeviceProcAddr( device, "vkCmdDrawIndirectCount" );
	vkCmdDrawIndexedIndirectCount = cast( typeof( vkCmdDrawIndexedIndirectCount )) vkGetDeviceProcAddr( device, "vkCmdDrawIndexedIndirectCount" );
	vkCreateRenderPass2 = cast( typeof( vkCreateRenderPass2 )) vkGetDeviceProcAddr( device, "vkCreateRenderPass2" );
	vkCmdBeginRenderPass2 = cast( typeof( vkCmdBeginRenderPass2 )) vkGetDeviceProcAddr( device, "vkCmdBeginRenderPass2" );
	vkCmdNextSubpass2 = cast( typeof( vkCmdNextSubpass2 )) vkGetDeviceProcAddr( device, "vkCmdNextSubpass2" );
	vkCmdEndRenderPass2 = cast( typeof( vkCmdEndRenderPass2 )) vkGetDeviceProcAddr( device, "vkCmdEndRenderPass2" );
	vkResetQueryPool = cast( typeof( vkResetQueryPool )) vkGetDeviceProcAddr( device, "vkResetQueryPool" );
	vkGetSemaphoreCounterValue = cast( typeof( vkGetSemaphoreCounterValue )) vkGetDeviceProcAddr( device, "vkGetSemaphoreCounterValue" );
	vkWaitSemaphores = cast( typeof( vkWaitSemaphores )) vkGetDeviceProcAddr( device, "vkWaitSemaphores" );
	vkSignalSemaphore = cast( typeof( vkSignalSemaphore )) vkGetDeviceProcAddr( device, "vkSignalSemaphore" );
	vkGetBufferDeviceAddress = cast( typeof( vkGetBufferDeviceAddress )) vkGetDeviceProcAddr( device, "vkGetBufferDeviceAddress" );
	vkGetBufferOpaqueCaptureAddress = cast( typeof( vkGetBufferOpaqueCaptureAddress )) vkGetDeviceProcAddr( device, "vkGetBufferOpaqueCaptureAddress" );
	vkGetDeviceMemoryOpaqueCaptureAddress = cast( typeof( vkGetDeviceMemoryOpaqueCaptureAddress )) vkGetDeviceProcAddr( device, "vkGetDeviceMemoryOpaqueCaptureAddress" );

	// VK_VERSION_1_3
	vkCreatePrivateDataSlot = cast( typeof( vkCreatePrivateDataSlot )) vkGetDeviceProcAddr( device, "vkCreatePrivateDataSlot" );
	vkDestroyPrivateDataSlot = cast( typeof( vkDestroyPrivateDataSlot )) vkGetDeviceProcAddr( device, "vkDestroyPrivateDataSlot" );
	vkSetPrivateData = cast( typeof( vkSetPrivateData )) vkGetDeviceProcAddr( device, "vkSetPrivateData" );
	vkGetPrivateData = cast( typeof( vkGetPrivateData )) vkGetDeviceProcAddr( device, "vkGetPrivateData" );
	vkCmdSetEvent2 = cast( typeof( vkCmdSetEvent2 )) vkGetDeviceProcAddr( device, "vkCmdSetEvent2" );
	vkCmdResetEvent2 = cast( typeof( vkCmdResetEvent2 )) vkGetDeviceProcAddr( device, "vkCmdResetEvent2" );
	vkCmdWaitEvents2 = cast( typeof( vkCmdWaitEvents2 )) vkGetDeviceProcAddr( device, "vkCmdWaitEvents2" );
	vkCmdPipelineBarrier2 = cast( typeof( vkCmdPipelineBarrier2 )) vkGetDeviceProcAddr( device, "vkCmdPipelineBarrier2" );
	vkCmdWriteTimestamp2 = cast( typeof( vkCmdWriteTimestamp2 )) vkGetDeviceProcAddr( device, "vkCmdWriteTimestamp2" );
	vkQueueSubmit2 = cast( typeof( vkQueueSubmit2 )) vkGetDeviceProcAddr( device, "vkQueueSubmit2" );
	vkCmdCopyBuffer2 = cast( typeof( vkCmdCopyBuffer2 )) vkGetDeviceProcAddr( device, "vkCmdCopyBuffer2" );
	vkCmdCopyImage2 = cast( typeof( vkCmdCopyImage2 )) vkGetDeviceProcAddr( device, "vkCmdCopyImage2" );
	vkCmdCopyBufferToImage2 = cast( typeof( vkCmdCopyBufferToImage2 )) vkGetDeviceProcAddr( device, "vkCmdCopyBufferToImage2" );
	vkCmdCopyImageToBuffer2 = cast( typeof( vkCmdCopyImageToBuffer2 )) vkGetDeviceProcAddr( device, "vkCmdCopyImageToBuffer2" );
	vkCmdBlitImage2 = cast( typeof( vkCmdBlitImage2 )) vkGetDeviceProcAddr( device, "vkCmdBlitImage2" );
	vkCmdResolveImage2 = cast( typeof( vkCmdResolveImage2 )) vkGetDeviceProcAddr( device, "vkCmdResolveImage2" );
	vkCmdBeginRendering = cast( typeof( vkCmdBeginRendering )) vkGetDeviceProcAddr( device, "vkCmdBeginRendering" );
	vkCmdEndRendering = cast( typeof( vkCmdEndRendering )) vkGetDeviceProcAddr( device, "vkCmdEndRendering" );
	vkCmdSetCullMode = cast( typeof( vkCmdSetCullMode )) vkGetDeviceProcAddr( device, "vkCmdSetCullMode" );
	vkCmdSetFrontFace = cast( typeof( vkCmdSetFrontFace )) vkGetDeviceProcAddr( device, "vkCmdSetFrontFace" );
	vkCmdSetPrimitiveTopology = cast( typeof( vkCmdSetPrimitiveTopology )) vkGetDeviceProcAddr( device, "vkCmdSetPrimitiveTopology" );
	vkCmdSetViewportWithCount = cast( typeof( vkCmdSetViewportWithCount )) vkGetDeviceProcAddr( device, "vkCmdSetViewportWithCount" );
	vkCmdSetScissorWithCount = cast( typeof( vkCmdSetScissorWithCount )) vkGetDeviceProcAddr( device, "vkCmdSetScissorWithCount" );
	vkCmdBindVertexBuffers2 = cast( typeof( vkCmdBindVertexBuffers2 )) vkGetDeviceProcAddr( device, "vkCmdBindVertexBuffers2" );
	vkCmdSetDepthTestEnable = cast( typeof( vkCmdSetDepthTestEnable )) vkGetDeviceProcAddr( device, "vkCmdSetDepthTestEnable" );
	vkCmdSetDepthWriteEnable = cast( typeof( vkCmdSetDepthWriteEnable )) vkGetDeviceProcAddr( device, "vkCmdSetDepthWriteEnable" );
	vkCmdSetDepthCompareOp = cast( typeof( vkCmdSetDepthCompareOp )) vkGetDeviceProcAddr( device, "vkCmdSetDepthCompareOp" );
	vkCmdSetDepthBoundsTestEnable = cast( typeof( vkCmdSetDepthBoundsTestEnable )) vkGetDeviceProcAddr( device, "vkCmdSetDepthBoundsTestEnable" );
	vkCmdSetStencilTestEnable = cast( typeof( vkCmdSetStencilTestEnable )) vkGetDeviceProcAddr( device, "vkCmdSetStencilTestEnable" );
	vkCmdSetStencilOp = cast( typeof( vkCmdSetStencilOp )) vkGetDeviceProcAddr( device, "vkCmdSetStencilOp" );
	vkCmdSetRasterizerDiscardEnable = cast( typeof( vkCmdSetRasterizerDiscardEnable )) vkGetDeviceProcAddr( device, "vkCmdSetRasterizerDiscardEnable" );
	vkCmdSetDepthBiasEnable = cast( typeof( vkCmdSetDepthBiasEnable )) vkGetDeviceProcAddr( device, "vkCmdSetDepthBiasEnable" );
	vkCmdSetPrimitiveRestartEnable = cast( typeof( vkCmdSetPrimitiveRestartEnable )) vkGetDeviceProcAddr( device, "vkCmdSetPrimitiveRestartEnable" );
	vkGetDeviceBufferMemoryRequirements = cast( typeof( vkGetDeviceBufferMemoryRequirements )) vkGetDeviceProcAddr( device, "vkGetDeviceBufferMemoryRequirements" );
	vkGetDeviceImageMemoryRequirements = cast( typeof( vkGetDeviceImageMemoryRequirements )) vkGetDeviceProcAddr( device, "vkGetDeviceImageMemoryRequirements" );
	vkGetDeviceImageSparseMemoryRequirements = cast( typeof( vkGetDeviceImageSparseMemoryRequirements )) vkGetDeviceProcAddr( device, "vkGetDeviceImageSparseMemoryRequirements" );

	// VK_KHR_swapchain
	vkCreateSwapchainKHR = cast( typeof( vkCreateSwapchainKHR )) vkGetDeviceProcAddr( device, "vkCreateSwapchainKHR" );
	vkDestroySwapchainKHR = cast( typeof( vkDestroySwapchainKHR )) vkGetDeviceProcAddr( device, "vkDestroySwapchainKHR" );
	vkGetSwapchainImagesKHR = cast( typeof( vkGetSwapchainImagesKHR )) vkGetDeviceProcAddr( device, "vkGetSwapchainImagesKHR" );
	vkAcquireNextImageKHR = cast( typeof( vkAcquireNextImageKHR )) vkGetDeviceProcAddr( device, "vkAcquireNextImageKHR" );
	vkQueuePresentKHR = cast( typeof( vkQueuePresentKHR )) vkGetDeviceProcAddr( device, "vkQueuePresentKHR" );
	vkGetDeviceGroupPresentCapabilitiesKHR = cast( typeof( vkGetDeviceGroupPresentCapabilitiesKHR )) vkGetDeviceProcAddr( device, "vkGetDeviceGroupPresentCapabilitiesKHR" );
	vkGetDeviceGroupSurfacePresentModesKHR = cast( typeof( vkGetDeviceGroupSurfacePresentModesKHR )) vkGetDeviceProcAddr( device, "vkGetDeviceGroupSurfacePresentModesKHR" );
	vkAcquireNextImage2KHR = cast( typeof( vkAcquireNextImage2KHR )) vkGetDeviceProcAddr( device, "vkAcquireNextImage2KHR" );

	// VK_EXT_debug_utils
	vkSetDebugUtilsObjectNameEXT = cast( typeof( vkSetDebugUtilsObjectNameEXT )) vkGetDeviceProcAddr( device, "vkSetDebugUtilsObjectNameEXT" );
	vkSetDebugUtilsObjectTagEXT = cast( typeof( vkSetDebugUtilsObjectTagEXT )) vkGetDeviceProcAddr( device, "vkSetDebugUtilsObjectTagEXT" );
	vkQueueBeginDebugUtilsLabelEXT = cast( typeof( vkQueueBeginDebugUtilsLabelEXT )) vkGetDeviceProcAddr( device, "vkQueueBeginDebugUtilsLabelEXT" );
	vkQueueEndDebugUtilsLabelEXT = cast( typeof( vkQueueEndDebugUtilsLabelEXT )) vkGetDeviceProcAddr( device, "vkQueueEndDebugUtilsLabelEXT" );
	vkQueueInsertDebugUtilsLabelEXT = cast( typeof( vkQueueInsertDebugUtilsLabelEXT )) vkGetDeviceProcAddr( device, "vkQueueInsertDebugUtilsLabelEXT" );
	vkCmdBeginDebugUtilsLabelEXT = cast( typeof( vkCmdBeginDebugUtilsLabelEXT )) vkGetDeviceProcAddr( device, "vkCmdBeginDebugUtilsLabelEXT" );
	vkCmdEndDebugUtilsLabelEXT = cast( typeof( vkCmdEndDebugUtilsLabelEXT )) vkGetDeviceProcAddr( device, "vkCmdEndDebugUtilsLabelEXT" );
	vkCmdInsertDebugUtilsLabelEXT = cast( typeof( vkCmdInsertDebugUtilsLabelEXT )) vkGetDeviceProcAddr( device, "vkCmdInsertDebugUtilsLabelEXT" );
}

/// with a valid VkDevice call this function to retrieve VkDevice, VkQueue and VkCommandBuffer related functions grouped in a DispatchDevice struct
/// the functions call directly VkDevice and related resources and can be retrieved for any VkDevice
deprecated( "Use DispatchDevice( VkDevice ) or DispatchDevice.loadDeviceLevelFunctions( VkDevice ) instead" )
DispatchDevice createDispatchDeviceLevelFunctions( VkDevice device ) {
	return DispatchDevice( device );
}


// struct to group per device deviceLevelFunctions into a custom namespace
// keeps track of the device to which the functions are bound
struct DispatchDevice {
	private VkDevice device = VK_NULL_HANDLE;
	VkCommandBuffer commandBuffer;

	// return copy of the internal VkDevice
	VkDevice vkDevice() {
		return device;
	}

	// Constructor forwards parameter 'device' to 'this.loadDeviceLevelFunctions'
	this( VkDevice device ) {
		this.loadDeviceLevelFunctions( device );
	}

	// load the device level member functions
	// this also sets the private member 'device' to the passed in VkDevice
	// now the DispatchDevice can be used e.g.:
	//		auto dd = DispatchDevice( device );
	//		dd.vkDestroyDevice( dd.vkDevice, pAllocator );
	// convenience functions to omit the first arg do exist, see bellow
	void loadDeviceLevelFunctions( VkDevice device ) {
		assert( vkGetDeviceProcAddr !is null, "Must call loadInstanceLevelFunctions before loadDeviceLevelFunctions" );
		this.device = device;

		// VK_VERSION_1_0
		vkDestroyDevice = cast( typeof( vkDestroyDevice )) vkGetDeviceProcAddr( device, "vkDestroyDevice" );
		vkGetDeviceQueue = cast( typeof( vkGetDeviceQueue )) vkGetDeviceProcAddr( device, "vkGetDeviceQueue" );
		vkQueueSubmit = cast( typeof( vkQueueSubmit )) vkGetDeviceProcAddr( device, "vkQueueSubmit" );
		vkQueueWaitIdle = cast( typeof( vkQueueWaitIdle )) vkGetDeviceProcAddr( device, "vkQueueWaitIdle" );
		vkDeviceWaitIdle = cast( typeof( vkDeviceWaitIdle )) vkGetDeviceProcAddr( device, "vkDeviceWaitIdle" );
		vkAllocateMemory = cast( typeof( vkAllocateMemory )) vkGetDeviceProcAddr( device, "vkAllocateMemory" );
		vkFreeMemory = cast( typeof( vkFreeMemory )) vkGetDeviceProcAddr( device, "vkFreeMemory" );
		vkMapMemory = cast( typeof( vkMapMemory )) vkGetDeviceProcAddr( device, "vkMapMemory" );
		vkUnmapMemory = cast( typeof( vkUnmapMemory )) vkGetDeviceProcAddr( device, "vkUnmapMemory" );
		vkFlushMappedMemoryRanges = cast( typeof( vkFlushMappedMemoryRanges )) vkGetDeviceProcAddr( device, "vkFlushMappedMemoryRanges" );
		vkInvalidateMappedMemoryRanges = cast( typeof( vkInvalidateMappedMemoryRanges )) vkGetDeviceProcAddr( device, "vkInvalidateMappedMemoryRanges" );
		vkGetDeviceMemoryCommitment = cast( typeof( vkGetDeviceMemoryCommitment )) vkGetDeviceProcAddr( device, "vkGetDeviceMemoryCommitment" );
		vkBindBufferMemory = cast( typeof( vkBindBufferMemory )) vkGetDeviceProcAddr( device, "vkBindBufferMemory" );
		vkBindImageMemory = cast( typeof( vkBindImageMemory )) vkGetDeviceProcAddr( device, "vkBindImageMemory" );
		vkGetBufferMemoryRequirements = cast( typeof( vkGetBufferMemoryRequirements )) vkGetDeviceProcAddr( device, "vkGetBufferMemoryRequirements" );
		vkGetImageMemoryRequirements = cast( typeof( vkGetImageMemoryRequirements )) vkGetDeviceProcAddr( device, "vkGetImageMemoryRequirements" );
		vkGetImageSparseMemoryRequirements = cast( typeof( vkGetImageSparseMemoryRequirements )) vkGetDeviceProcAddr( device, "vkGetImageSparseMemoryRequirements" );
		vkQueueBindSparse = cast( typeof( vkQueueBindSparse )) vkGetDeviceProcAddr( device, "vkQueueBindSparse" );
		vkCreateFence = cast( typeof( vkCreateFence )) vkGetDeviceProcAddr( device, "vkCreateFence" );
		vkDestroyFence = cast( typeof( vkDestroyFence )) vkGetDeviceProcAddr( device, "vkDestroyFence" );
		vkResetFences = cast( typeof( vkResetFences )) vkGetDeviceProcAddr( device, "vkResetFences" );
		vkGetFenceStatus = cast( typeof( vkGetFenceStatus )) vkGetDeviceProcAddr( device, "vkGetFenceStatus" );
		vkWaitForFences = cast( typeof( vkWaitForFences )) vkGetDeviceProcAddr( device, "vkWaitForFences" );
		vkCreateSemaphore = cast( typeof( vkCreateSemaphore )) vkGetDeviceProcAddr( device, "vkCreateSemaphore" );
		vkDestroySemaphore = cast( typeof( vkDestroySemaphore )) vkGetDeviceProcAddr( device, "vkDestroySemaphore" );
		vkCreateEvent = cast( typeof( vkCreateEvent )) vkGetDeviceProcAddr( device, "vkCreateEvent" );
		vkDestroyEvent = cast( typeof( vkDestroyEvent )) vkGetDeviceProcAddr( device, "vkDestroyEvent" );
		vkGetEventStatus = cast( typeof( vkGetEventStatus )) vkGetDeviceProcAddr( device, "vkGetEventStatus" );
		vkSetEvent = cast( typeof( vkSetEvent )) vkGetDeviceProcAddr( device, "vkSetEvent" );
		vkResetEvent = cast( typeof( vkResetEvent )) vkGetDeviceProcAddr( device, "vkResetEvent" );
		vkCreateQueryPool = cast( typeof( vkCreateQueryPool )) vkGetDeviceProcAddr( device, "vkCreateQueryPool" );
		vkDestroyQueryPool = cast( typeof( vkDestroyQueryPool )) vkGetDeviceProcAddr( device, "vkDestroyQueryPool" );
		vkGetQueryPoolResults = cast( typeof( vkGetQueryPoolResults )) vkGetDeviceProcAddr( device, "vkGetQueryPoolResults" );
		vkCreateBuffer = cast( typeof( vkCreateBuffer )) vkGetDeviceProcAddr( device, "vkCreateBuffer" );
		vkDestroyBuffer = cast( typeof( vkDestroyBuffer )) vkGetDeviceProcAddr( device, "vkDestroyBuffer" );
		vkCreateBufferView = cast( typeof( vkCreateBufferView )) vkGetDeviceProcAddr( device, "vkCreateBufferView" );
		vkDestroyBufferView = cast( typeof( vkDestroyBufferView )) vkGetDeviceProcAddr( device, "vkDestroyBufferView" );
		vkCreateImage = cast( typeof( vkCreateImage )) vkGetDeviceProcAddr( device, "vkCreateImage" );
		vkDestroyImage = cast( typeof( vkDestroyImage )) vkGetDeviceProcAddr( device, "vkDestroyImage" );
		vkGetImageSubresourceLayout = cast( typeof( vkGetImageSubresourceLayout )) vkGetDeviceProcAddr( device, "vkGetImageSubresourceLayout" );
		vkCreateImageView = cast( typeof( vkCreateImageView )) vkGetDeviceProcAddr( device, "vkCreateImageView" );
		vkDestroyImageView = cast( typeof( vkDestroyImageView )) vkGetDeviceProcAddr( device, "vkDestroyImageView" );
		vkCreateShaderModule = cast( typeof( vkCreateShaderModule )) vkGetDeviceProcAddr( device, "vkCreateShaderModule" );
		vkDestroyShaderModule = cast( typeof( vkDestroyShaderModule )) vkGetDeviceProcAddr( device, "vkDestroyShaderModule" );
		vkCreatePipelineCache = cast( typeof( vkCreatePipelineCache )) vkGetDeviceProcAddr( device, "vkCreatePipelineCache" );
		vkDestroyPipelineCache = cast( typeof( vkDestroyPipelineCache )) vkGetDeviceProcAddr( device, "vkDestroyPipelineCache" );
		vkGetPipelineCacheData = cast( typeof( vkGetPipelineCacheData )) vkGetDeviceProcAddr( device, "vkGetPipelineCacheData" );
		vkMergePipelineCaches = cast( typeof( vkMergePipelineCaches )) vkGetDeviceProcAddr( device, "vkMergePipelineCaches" );
		vkCreateGraphicsPipelines = cast( typeof( vkCreateGraphicsPipelines )) vkGetDeviceProcAddr( device, "vkCreateGraphicsPipelines" );
		vkCreateComputePipelines = cast( typeof( vkCreateComputePipelines )) vkGetDeviceProcAddr( device, "vkCreateComputePipelines" );
		vkDestroyPipeline = cast( typeof( vkDestroyPipeline )) vkGetDeviceProcAddr( device, "vkDestroyPipeline" );
		vkCreatePipelineLayout = cast( typeof( vkCreatePipelineLayout )) vkGetDeviceProcAddr( device, "vkCreatePipelineLayout" );
		vkDestroyPipelineLayout = cast( typeof( vkDestroyPipelineLayout )) vkGetDeviceProcAddr( device, "vkDestroyPipelineLayout" );
		vkCreateSampler = cast( typeof( vkCreateSampler )) vkGetDeviceProcAddr( device, "vkCreateSampler" );
		vkDestroySampler = cast( typeof( vkDestroySampler )) vkGetDeviceProcAddr( device, "vkDestroySampler" );
		vkCreateDescriptorSetLayout = cast( typeof( vkCreateDescriptorSetLayout )) vkGetDeviceProcAddr( device, "vkCreateDescriptorSetLayout" );
		vkDestroyDescriptorSetLayout = cast( typeof( vkDestroyDescriptorSetLayout )) vkGetDeviceProcAddr( device, "vkDestroyDescriptorSetLayout" );
		vkCreateDescriptorPool = cast( typeof( vkCreateDescriptorPool )) vkGetDeviceProcAddr( device, "vkCreateDescriptorPool" );
		vkDestroyDescriptorPool = cast( typeof( vkDestroyDescriptorPool )) vkGetDeviceProcAddr( device, "vkDestroyDescriptorPool" );
		vkResetDescriptorPool = cast( typeof( vkResetDescriptorPool )) vkGetDeviceProcAddr( device, "vkResetDescriptorPool" );
		vkAllocateDescriptorSets = cast( typeof( vkAllocateDescriptorSets )) vkGetDeviceProcAddr( device, "vkAllocateDescriptorSets" );
		vkFreeDescriptorSets = cast( typeof( vkFreeDescriptorSets )) vkGetDeviceProcAddr( device, "vkFreeDescriptorSets" );
		vkUpdateDescriptorSets = cast( typeof( vkUpdateDescriptorSets )) vkGetDeviceProcAddr( device, "vkUpdateDescriptorSets" );
		vkCreateFramebuffer = cast( typeof( vkCreateFramebuffer )) vkGetDeviceProcAddr( device, "vkCreateFramebuffer" );
		vkDestroyFramebuffer = cast( typeof( vkDestroyFramebuffer )) vkGetDeviceProcAddr( device, "vkDestroyFramebuffer" );
		vkCreateRenderPass = cast( typeof( vkCreateRenderPass )) vkGetDeviceProcAddr( device, "vkCreateRenderPass" );
		vkDestroyRenderPass = cast( typeof( vkDestroyRenderPass )) vkGetDeviceProcAddr( device, "vkDestroyRenderPass" );
		vkGetRenderAreaGranularity = cast( typeof( vkGetRenderAreaGranularity )) vkGetDeviceProcAddr( device, "vkGetRenderAreaGranularity" );
		vkCreateCommandPool = cast( typeof( vkCreateCommandPool )) vkGetDeviceProcAddr( device, "vkCreateCommandPool" );
		vkDestroyCommandPool = cast( typeof( vkDestroyCommandPool )) vkGetDeviceProcAddr( device, "vkDestroyCommandPool" );
		vkResetCommandPool = cast( typeof( vkResetCommandPool )) vkGetDeviceProcAddr( device, "vkResetCommandPool" );
		vkAllocateCommandBuffers = cast( typeof( vkAllocateCommandBuffers )) vkGetDeviceProcAddr( device, "vkAllocateCommandBuffers" );
		vkFreeCommandBuffers = cast( typeof( vkFreeCommandBuffers )) vkGetDeviceProcAddr( device, "vkFreeCommandBuffers" );
		vkBeginCommandBuffer = cast( typeof( vkBeginCommandBuffer )) vkGetDeviceProcAddr( device, "vkBeginCommandBuffer" );
		vkEndCommandBuffer = cast( typeof( vkEndCommandBuffer )) vkGetDeviceProcAddr( device, "vkEndCommandBuffer" );
		vkResetCommandBuffer = cast( typeof( vkResetCommandBuffer )) vkGetDeviceProcAddr( device, "vkResetCommandBuffer" );
		vkCmdBindPipeline = cast( typeof( vkCmdBindPipeline )) vkGetDeviceProcAddr( device, "vkCmdBindPipeline" );
		vkCmdSetViewport = cast( typeof( vkCmdSetViewport )) vkGetDeviceProcAddr( device, "vkCmdSetViewport" );
		vkCmdSetScissor = cast( typeof( vkCmdSetScissor )) vkGetDeviceProcAddr( device, "vkCmdSetScissor" );
		vkCmdSetLineWidth = cast( typeof( vkCmdSetLineWidth )) vkGetDeviceProcAddr( device, "vkCmdSetLineWidth" );
		vkCmdSetDepthBias = cast( typeof( vkCmdSetDepthBias )) vkGetDeviceProcAddr( device, "vkCmdSetDepthBias" );
		vkCmdSetBlendConstants = cast( typeof( vkCmdSetBlendConstants )) vkGetDeviceProcAddr( device, "vkCmdSetBlendConstants" );
		vkCmdSetDepthBounds = cast( typeof( vkCmdSetDepthBounds )) vkGetDeviceProcAddr( device, "vkCmdSetDepthBounds" );
		vkCmdSetStencilCompareMask = cast( typeof( vkCmdSetStencilCompareMask )) vkGetDeviceProcAddr( device, "vkCmdSetStencilCompareMask" );
		vkCmdSetStencilWriteMask = cast( typeof( vkCmdSetStencilWriteMask )) vkGetDeviceProcAddr( device, "vkCmdSetStencilWriteMask" );
		vkCmdSetStencilReference = cast( typeof( vkCmdSetStencilReference )) vkGetDeviceProcAddr( device, "vkCmdSetStencilReference" );
		vkCmdBindDescriptorSets = cast( typeof( vkCmdBindDescriptorSets )) vkGetDeviceProcAddr( device, "vkCmdBindDescriptorSets" );
		vkCmdBindIndexBuffer = cast( typeof( vkCmdBindIndexBuffer )) vkGetDeviceProcAddr( device, "vkCmdBindIndexBuffer" );
		vkCmdBindVertexBuffers = cast( typeof( vkCmdBindVertexBuffers )) vkGetDeviceProcAddr( device, "vkCmdBindVertexBuffers" );
		vkCmdDraw = cast( typeof( vkCmdDraw )) vkGetDeviceProcAddr( device, "vkCmdDraw" );
		vkCmdDrawIndexed = cast( typeof( vkCmdDrawIndexed )) vkGetDeviceProcAddr( device, "vkCmdDrawIndexed" );
		vkCmdDrawIndirect = cast( typeof( vkCmdDrawIndirect )) vkGetDeviceProcAddr( device, "vkCmdDrawIndirect" );
		vkCmdDrawIndexedIndirect = cast( typeof( vkCmdDrawIndexedIndirect )) vkGetDeviceProcAddr( device, "vkCmdDrawIndexedIndirect" );
		vkCmdDispatch = cast( typeof( vkCmdDispatch )) vkGetDeviceProcAddr( device, "vkCmdDispatch" );
		vkCmdDispatchIndirect = cast( typeof( vkCmdDispatchIndirect )) vkGetDeviceProcAddr( device, "vkCmdDispatchIndirect" );
		vkCmdCopyBuffer = cast( typeof( vkCmdCopyBuffer )) vkGetDeviceProcAddr( device, "vkCmdCopyBuffer" );
		vkCmdCopyImage = cast( typeof( vkCmdCopyImage )) vkGetDeviceProcAddr( device, "vkCmdCopyImage" );
		vkCmdBlitImage = cast( typeof( vkCmdBlitImage )) vkGetDeviceProcAddr( device, "vkCmdBlitImage" );
		vkCmdCopyBufferToImage = cast( typeof( vkCmdCopyBufferToImage )) vkGetDeviceProcAddr( device, "vkCmdCopyBufferToImage" );
		vkCmdCopyImageToBuffer = cast( typeof( vkCmdCopyImageToBuffer )) vkGetDeviceProcAddr( device, "vkCmdCopyImageToBuffer" );
		vkCmdUpdateBuffer = cast( typeof( vkCmdUpdateBuffer )) vkGetDeviceProcAddr( device, "vkCmdUpdateBuffer" );
		vkCmdFillBuffer = cast( typeof( vkCmdFillBuffer )) vkGetDeviceProcAddr( device, "vkCmdFillBuffer" );
		vkCmdClearColorImage = cast( typeof( vkCmdClearColorImage )) vkGetDeviceProcAddr( device, "vkCmdClearColorImage" );
		vkCmdClearDepthStencilImage = cast( typeof( vkCmdClearDepthStencilImage )) vkGetDeviceProcAddr( device, "vkCmdClearDepthStencilImage" );
		vkCmdClearAttachments = cast( typeof( vkCmdClearAttachments )) vkGetDeviceProcAddr( device, "vkCmdClearAttachments" );
		vkCmdResolveImage = cast( typeof( vkCmdResolveImage )) vkGetDeviceProcAddr( device, "vkCmdResolveImage" );
		vkCmdSetEvent = cast( typeof( vkCmdSetEvent )) vkGetDeviceProcAddr( device, "vkCmdSetEvent" );
		vkCmdResetEvent = cast( typeof( vkCmdResetEvent )) vkGetDeviceProcAddr( device, "vkCmdResetEvent" );
		vkCmdWaitEvents = cast( typeof( vkCmdWaitEvents )) vkGetDeviceProcAddr( device, "vkCmdWaitEvents" );
		vkCmdPipelineBarrier = cast( typeof( vkCmdPipelineBarrier )) vkGetDeviceProcAddr( device, "vkCmdPipelineBarrier" );
		vkCmdBeginQuery = cast( typeof( vkCmdBeginQuery )) vkGetDeviceProcAddr( device, "vkCmdBeginQuery" );
		vkCmdEndQuery = cast( typeof( vkCmdEndQuery )) vkGetDeviceProcAddr( device, "vkCmdEndQuery" );
		vkCmdResetQueryPool = cast( typeof( vkCmdResetQueryPool )) vkGetDeviceProcAddr( device, "vkCmdResetQueryPool" );
		vkCmdWriteTimestamp = cast( typeof( vkCmdWriteTimestamp )) vkGetDeviceProcAddr( device, "vkCmdWriteTimestamp" );
		vkCmdCopyQueryPoolResults = cast( typeof( vkCmdCopyQueryPoolResults )) vkGetDeviceProcAddr( device, "vkCmdCopyQueryPoolResults" );
		vkCmdPushConstants = cast( typeof( vkCmdPushConstants )) vkGetDeviceProcAddr( device, "vkCmdPushConstants" );
		vkCmdBeginRenderPass = cast( typeof( vkCmdBeginRenderPass )) vkGetDeviceProcAddr( device, "vkCmdBeginRenderPass" );
		vkCmdNextSubpass = cast( typeof( vkCmdNextSubpass )) vkGetDeviceProcAddr( device, "vkCmdNextSubpass" );
		vkCmdEndRenderPass = cast( typeof( vkCmdEndRenderPass )) vkGetDeviceProcAddr( device, "vkCmdEndRenderPass" );
		vkCmdExecuteCommands = cast( typeof( vkCmdExecuteCommands )) vkGetDeviceProcAddr( device, "vkCmdExecuteCommands" );

		// VK_VERSION_1_1
		vkBindBufferMemory2 = cast( typeof( vkBindBufferMemory2 )) vkGetDeviceProcAddr( device, "vkBindBufferMemory2" );
		vkBindImageMemory2 = cast( typeof( vkBindImageMemory2 )) vkGetDeviceProcAddr( device, "vkBindImageMemory2" );
		vkGetDeviceGroupPeerMemoryFeatures = cast( typeof( vkGetDeviceGroupPeerMemoryFeatures )) vkGetDeviceProcAddr( device, "vkGetDeviceGroupPeerMemoryFeatures" );
		vkCmdSetDeviceMask = cast( typeof( vkCmdSetDeviceMask )) vkGetDeviceProcAddr( device, "vkCmdSetDeviceMask" );
		vkCmdDispatchBase = cast( typeof( vkCmdDispatchBase )) vkGetDeviceProcAddr( device, "vkCmdDispatchBase" );
		vkGetImageMemoryRequirements2 = cast( typeof( vkGetImageMemoryRequirements2 )) vkGetDeviceProcAddr( device, "vkGetImageMemoryRequirements2" );
		vkGetBufferMemoryRequirements2 = cast( typeof( vkGetBufferMemoryRequirements2 )) vkGetDeviceProcAddr( device, "vkGetBufferMemoryRequirements2" );
		vkGetImageSparseMemoryRequirements2 = cast( typeof( vkGetImageSparseMemoryRequirements2 )) vkGetDeviceProcAddr( device, "vkGetImageSparseMemoryRequirements2" );
		vkTrimCommandPool = cast( typeof( vkTrimCommandPool )) vkGetDeviceProcAddr( device, "vkTrimCommandPool" );
		vkGetDeviceQueue2 = cast( typeof( vkGetDeviceQueue2 )) vkGetDeviceProcAddr( device, "vkGetDeviceQueue2" );
		vkCreateSamplerYcbcrConversion = cast( typeof( vkCreateSamplerYcbcrConversion )) vkGetDeviceProcAddr( device, "vkCreateSamplerYcbcrConversion" );
		vkDestroySamplerYcbcrConversion = cast( typeof( vkDestroySamplerYcbcrConversion )) vkGetDeviceProcAddr( device, "vkDestroySamplerYcbcrConversion" );
		vkCreateDescriptorUpdateTemplate = cast( typeof( vkCreateDescriptorUpdateTemplate )) vkGetDeviceProcAddr( device, "vkCreateDescriptorUpdateTemplate" );
		vkDestroyDescriptorUpdateTemplate = cast( typeof( vkDestroyDescriptorUpdateTemplate )) vkGetDeviceProcAddr( device, "vkDestroyDescriptorUpdateTemplate" );
		vkUpdateDescriptorSetWithTemplate = cast( typeof( vkUpdateDescriptorSetWithTemplate )) vkGetDeviceProcAddr( device, "vkUpdateDescriptorSetWithTemplate" );
		vkGetDescriptorSetLayoutSupport = cast( typeof( vkGetDescriptorSetLayoutSupport )) vkGetDeviceProcAddr( device, "vkGetDescriptorSetLayoutSupport" );

		// VK_VERSION_1_2
		vkCmdDrawIndirectCount = cast( typeof( vkCmdDrawIndirectCount )) vkGetDeviceProcAddr( device, "vkCmdDrawIndirectCount" );
		vkCmdDrawIndexedIndirectCount = cast( typeof( vkCmdDrawIndexedIndirectCount )) vkGetDeviceProcAddr( device, "vkCmdDrawIndexedIndirectCount" );
		vkCreateRenderPass2 = cast( typeof( vkCreateRenderPass2 )) vkGetDeviceProcAddr( device, "vkCreateRenderPass2" );
		vkCmdBeginRenderPass2 = cast( typeof( vkCmdBeginRenderPass2 )) vkGetDeviceProcAddr( device, "vkCmdBeginRenderPass2" );
		vkCmdNextSubpass2 = cast( typeof( vkCmdNextSubpass2 )) vkGetDeviceProcAddr( device, "vkCmdNextSubpass2" );
		vkCmdEndRenderPass2 = cast( typeof( vkCmdEndRenderPass2 )) vkGetDeviceProcAddr( device, "vkCmdEndRenderPass2" );
		vkResetQueryPool = cast( typeof( vkResetQueryPool )) vkGetDeviceProcAddr( device, "vkResetQueryPool" );
		vkGetSemaphoreCounterValue = cast( typeof( vkGetSemaphoreCounterValue )) vkGetDeviceProcAddr( device, "vkGetSemaphoreCounterValue" );
		vkWaitSemaphores = cast( typeof( vkWaitSemaphores )) vkGetDeviceProcAddr( device, "vkWaitSemaphores" );
		vkSignalSemaphore = cast( typeof( vkSignalSemaphore )) vkGetDeviceProcAddr( device, "vkSignalSemaphore" );
		vkGetBufferDeviceAddress = cast( typeof( vkGetBufferDeviceAddress )) vkGetDeviceProcAddr( device, "vkGetBufferDeviceAddress" );
		vkGetBufferOpaqueCaptureAddress = cast( typeof( vkGetBufferOpaqueCaptureAddress )) vkGetDeviceProcAddr( device, "vkGetBufferOpaqueCaptureAddress" );
		vkGetDeviceMemoryOpaqueCaptureAddress = cast( typeof( vkGetDeviceMemoryOpaqueCaptureAddress )) vkGetDeviceProcAddr( device, "vkGetDeviceMemoryOpaqueCaptureAddress" );

		// VK_VERSION_1_3
		vkCreatePrivateDataSlot = cast( typeof( vkCreatePrivateDataSlot )) vkGetDeviceProcAddr( device, "vkCreatePrivateDataSlot" );
		vkDestroyPrivateDataSlot = cast( typeof( vkDestroyPrivateDataSlot )) vkGetDeviceProcAddr( device, "vkDestroyPrivateDataSlot" );
		vkSetPrivateData = cast( typeof( vkSetPrivateData )) vkGetDeviceProcAddr( device, "vkSetPrivateData" );
		vkGetPrivateData = cast( typeof( vkGetPrivateData )) vkGetDeviceProcAddr( device, "vkGetPrivateData" );
		vkCmdSetEvent2 = cast( typeof( vkCmdSetEvent2 )) vkGetDeviceProcAddr( device, "vkCmdSetEvent2" );
		vkCmdResetEvent2 = cast( typeof( vkCmdResetEvent2 )) vkGetDeviceProcAddr( device, "vkCmdResetEvent2" );
		vkCmdWaitEvents2 = cast( typeof( vkCmdWaitEvents2 )) vkGetDeviceProcAddr( device, "vkCmdWaitEvents2" );
		vkCmdPipelineBarrier2 = cast( typeof( vkCmdPipelineBarrier2 )) vkGetDeviceProcAddr( device, "vkCmdPipelineBarrier2" );
		vkCmdWriteTimestamp2 = cast( typeof( vkCmdWriteTimestamp2 )) vkGetDeviceProcAddr( device, "vkCmdWriteTimestamp2" );
		vkQueueSubmit2 = cast( typeof( vkQueueSubmit2 )) vkGetDeviceProcAddr( device, "vkQueueSubmit2" );
		vkCmdCopyBuffer2 = cast( typeof( vkCmdCopyBuffer2 )) vkGetDeviceProcAddr( device, "vkCmdCopyBuffer2" );
		vkCmdCopyImage2 = cast( typeof( vkCmdCopyImage2 )) vkGetDeviceProcAddr( device, "vkCmdCopyImage2" );
		vkCmdCopyBufferToImage2 = cast( typeof( vkCmdCopyBufferToImage2 )) vkGetDeviceProcAddr( device, "vkCmdCopyBufferToImage2" );
		vkCmdCopyImageToBuffer2 = cast( typeof( vkCmdCopyImageToBuffer2 )) vkGetDeviceProcAddr( device, "vkCmdCopyImageToBuffer2" );
		vkCmdBlitImage2 = cast( typeof( vkCmdBlitImage2 )) vkGetDeviceProcAddr( device, "vkCmdBlitImage2" );
		vkCmdResolveImage2 = cast( typeof( vkCmdResolveImage2 )) vkGetDeviceProcAddr( device, "vkCmdResolveImage2" );
		vkCmdBeginRendering = cast( typeof( vkCmdBeginRendering )) vkGetDeviceProcAddr( device, "vkCmdBeginRendering" );
		vkCmdEndRendering = cast( typeof( vkCmdEndRendering )) vkGetDeviceProcAddr( device, "vkCmdEndRendering" );
		vkCmdSetCullMode = cast( typeof( vkCmdSetCullMode )) vkGetDeviceProcAddr( device, "vkCmdSetCullMode" );
		vkCmdSetFrontFace = cast( typeof( vkCmdSetFrontFace )) vkGetDeviceProcAddr( device, "vkCmdSetFrontFace" );
		vkCmdSetPrimitiveTopology = cast( typeof( vkCmdSetPrimitiveTopology )) vkGetDeviceProcAddr( device, "vkCmdSetPrimitiveTopology" );
		vkCmdSetViewportWithCount = cast( typeof( vkCmdSetViewportWithCount )) vkGetDeviceProcAddr( device, "vkCmdSetViewportWithCount" );
		vkCmdSetScissorWithCount = cast( typeof( vkCmdSetScissorWithCount )) vkGetDeviceProcAddr( device, "vkCmdSetScissorWithCount" );
		vkCmdBindVertexBuffers2 = cast( typeof( vkCmdBindVertexBuffers2 )) vkGetDeviceProcAddr( device, "vkCmdBindVertexBuffers2" );
		vkCmdSetDepthTestEnable = cast( typeof( vkCmdSetDepthTestEnable )) vkGetDeviceProcAddr( device, "vkCmdSetDepthTestEnable" );
		vkCmdSetDepthWriteEnable = cast( typeof( vkCmdSetDepthWriteEnable )) vkGetDeviceProcAddr( device, "vkCmdSetDepthWriteEnable" );
		vkCmdSetDepthCompareOp = cast( typeof( vkCmdSetDepthCompareOp )) vkGetDeviceProcAddr( device, "vkCmdSetDepthCompareOp" );
		vkCmdSetDepthBoundsTestEnable = cast( typeof( vkCmdSetDepthBoundsTestEnable )) vkGetDeviceProcAddr( device, "vkCmdSetDepthBoundsTestEnable" );
		vkCmdSetStencilTestEnable = cast( typeof( vkCmdSetStencilTestEnable )) vkGetDeviceProcAddr( device, "vkCmdSetStencilTestEnable" );
		vkCmdSetStencilOp = cast( typeof( vkCmdSetStencilOp )) vkGetDeviceProcAddr( device, "vkCmdSetStencilOp" );
		vkCmdSetRasterizerDiscardEnable = cast( typeof( vkCmdSetRasterizerDiscardEnable )) vkGetDeviceProcAddr( device, "vkCmdSetRasterizerDiscardEnable" );
		vkCmdSetDepthBiasEnable = cast( typeof( vkCmdSetDepthBiasEnable )) vkGetDeviceProcAddr( device, "vkCmdSetDepthBiasEnable" );
		vkCmdSetPrimitiveRestartEnable = cast( typeof( vkCmdSetPrimitiveRestartEnable )) vkGetDeviceProcAddr( device, "vkCmdSetPrimitiveRestartEnable" );
		vkGetDeviceBufferMemoryRequirements = cast( typeof( vkGetDeviceBufferMemoryRequirements )) vkGetDeviceProcAddr( device, "vkGetDeviceBufferMemoryRequirements" );
		vkGetDeviceImageMemoryRequirements = cast( typeof( vkGetDeviceImageMemoryRequirements )) vkGetDeviceProcAddr( device, "vkGetDeviceImageMemoryRequirements" );
		vkGetDeviceImageSparseMemoryRequirements = cast( typeof( vkGetDeviceImageSparseMemoryRequirements )) vkGetDeviceProcAddr( device, "vkGetDeviceImageSparseMemoryRequirements" );

		// VK_KHR_swapchain
		vkCreateSwapchainKHR = cast( typeof( vkCreateSwapchainKHR )) vkGetDeviceProcAddr( device, "vkCreateSwapchainKHR" );
		vkDestroySwapchainKHR = cast( typeof( vkDestroySwapchainKHR )) vkGetDeviceProcAddr( device, "vkDestroySwapchainKHR" );
		vkGetSwapchainImagesKHR = cast( typeof( vkGetSwapchainImagesKHR )) vkGetDeviceProcAddr( device, "vkGetSwapchainImagesKHR" );
		vkAcquireNextImageKHR = cast( typeof( vkAcquireNextImageKHR )) vkGetDeviceProcAddr( device, "vkAcquireNextImageKHR" );
		vkQueuePresentKHR = cast( typeof( vkQueuePresentKHR )) vkGetDeviceProcAddr( device, "vkQueuePresentKHR" );
		vkGetDeviceGroupPresentCapabilitiesKHR = cast( typeof( vkGetDeviceGroupPresentCapabilitiesKHR )) vkGetDeviceProcAddr( device, "vkGetDeviceGroupPresentCapabilitiesKHR" );
		vkGetDeviceGroupSurfacePresentModesKHR = cast( typeof( vkGetDeviceGroupSurfacePresentModesKHR )) vkGetDeviceProcAddr( device, "vkGetDeviceGroupSurfacePresentModesKHR" );
		vkAcquireNextImage2KHR = cast( typeof( vkAcquireNextImage2KHR )) vkGetDeviceProcAddr( device, "vkAcquireNextImage2KHR" );

		// VK_EXT_debug_utils
		vkSetDebugUtilsObjectNameEXT = cast( typeof( vkSetDebugUtilsObjectNameEXT )) vkGetDeviceProcAddr( device, "vkSetDebugUtilsObjectNameEXT" );
		vkSetDebugUtilsObjectTagEXT = cast( typeof( vkSetDebugUtilsObjectTagEXT )) vkGetDeviceProcAddr( device, "vkSetDebugUtilsObjectTagEXT" );
		vkQueueBeginDebugUtilsLabelEXT = cast( typeof( vkQueueBeginDebugUtilsLabelEXT )) vkGetDeviceProcAddr( device, "vkQueueBeginDebugUtilsLabelEXT" );
		vkQueueEndDebugUtilsLabelEXT = cast( typeof( vkQueueEndDebugUtilsLabelEXT )) vkGetDeviceProcAddr( device, "vkQueueEndDebugUtilsLabelEXT" );
		vkQueueInsertDebugUtilsLabelEXT = cast( typeof( vkQueueInsertDebugUtilsLabelEXT )) vkGetDeviceProcAddr( device, "vkQueueInsertDebugUtilsLabelEXT" );
		vkCmdBeginDebugUtilsLabelEXT = cast( typeof( vkCmdBeginDebugUtilsLabelEXT )) vkGetDeviceProcAddr( device, "vkCmdBeginDebugUtilsLabelEXT" );
		vkCmdEndDebugUtilsLabelEXT = cast( typeof( vkCmdEndDebugUtilsLabelEXT )) vkGetDeviceProcAddr( device, "vkCmdEndDebugUtilsLabelEXT" );
		vkCmdInsertDebugUtilsLabelEXT = cast( typeof( vkCmdInsertDebugUtilsLabelEXT )) vkGetDeviceProcAddr( device, "vkCmdInsertDebugUtilsLabelEXT" );
	}

	// Convenience member functions, forwarded to corresponding vulkan functions
	// If the first arg of the vulkan function is VkDevice it can be omitted
	// private 'DipatchDevice' member 'device' will be passed to the forwarded vulkan functions
	// the crux is that function pointers can't be overloaded with regular functions
	// hence the vk prefix is ditched for the convenience variants
	// e.g.:
	//		auto dd = DispatchDevice( device );
	//		dd.DestroyDevice( pAllocator );		// instead of: dd.vkDestroyDevice( dd.vkDevice, pAllocator );
	//
	// Same mechanism works with functions which require a VkCommandBuffer as first arg
	// In this case the public member 'commandBuffer' must be set beforehand
	// e.g.:
	//		dd.commandBuffer = some_command_buffer;
	//		dd.BeginCommandBuffer( &beginInfo );
	//		dd.CmdBindPipeline( VK_PIPELINE_BIND_POINT_GRAPHICS, some_pipeline );
	//
	// Does not work with queues, there are just too few queue related functions

	// VK_VERSION_1_0
	void DestroyDevice( const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyDevice( this.device, pAllocator );
	}
	void GetDeviceQueue( uint32_t queueFamilyIndex, uint32_t queueIndex, VkQueue* pQueue ) {
		vkGetDeviceQueue( this.device, queueFamilyIndex, queueIndex, pQueue );
	}
	VkResult DeviceWaitIdle() {
		return vkDeviceWaitIdle( this.device );
	}
	VkResult AllocateMemory( const( VkMemoryAllocateInfo )* pAllocateInfo, const( VkAllocationCallbacks )* pAllocator, VkDeviceMemory* pMemory ) {
		return vkAllocateMemory( this.device, pAllocateInfo, pAllocator, pMemory );
	}
	void FreeMemory( VkDeviceMemory memory, const( VkAllocationCallbacks )* pAllocator ) {
		vkFreeMemory( this.device, memory, pAllocator );
	}
	VkResult MapMemory( VkDeviceMemory memory, VkDeviceSize offset, VkDeviceSize size, VkMemoryMapFlags flags, void** ppData ) {
		return vkMapMemory( this.device, memory, offset, size, flags, ppData );
	}
	void UnmapMemory( VkDeviceMemory memory ) {
		vkUnmapMemory( this.device, memory );
	}
	VkResult FlushMappedMemoryRanges( uint32_t memoryRangeCount, const( VkMappedMemoryRange )* pMemoryRanges ) {
		return vkFlushMappedMemoryRanges( this.device, memoryRangeCount, pMemoryRanges );
	}
	VkResult InvalidateMappedMemoryRanges( uint32_t memoryRangeCount, const( VkMappedMemoryRange )* pMemoryRanges ) {
		return vkInvalidateMappedMemoryRanges( this.device, memoryRangeCount, pMemoryRanges );
	}
	void GetDeviceMemoryCommitment( VkDeviceMemory memory, VkDeviceSize* pCommittedMemoryInBytes ) {
		vkGetDeviceMemoryCommitment( this.device, memory, pCommittedMemoryInBytes );
	}
	VkResult BindBufferMemory( VkBuffer buffer, VkDeviceMemory memory, VkDeviceSize memoryOffset ) {
		return vkBindBufferMemory( this.device, buffer, memory, memoryOffset );
	}
	VkResult BindImageMemory( VkImage image, VkDeviceMemory memory, VkDeviceSize memoryOffset ) {
		return vkBindImageMemory( this.device, image, memory, memoryOffset );
	}
	void GetBufferMemoryRequirements( VkBuffer buffer, VkMemoryRequirements* pMemoryRequirements ) {
		vkGetBufferMemoryRequirements( this.device, buffer, pMemoryRequirements );
	}
	void GetImageMemoryRequirements( VkImage image, VkMemoryRequirements* pMemoryRequirements ) {
		vkGetImageMemoryRequirements( this.device, image, pMemoryRequirements );
	}
	void GetImageSparseMemoryRequirements( VkImage image, uint32_t* pSparseMemoryRequirementCount, VkSparseImageMemoryRequirements* pSparseMemoryRequirements ) {
		vkGetImageSparseMemoryRequirements( this.device, image, pSparseMemoryRequirementCount, pSparseMemoryRequirements );
	}
	VkResult CreateFence( const( VkFenceCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkFence* pFence ) {
		return vkCreateFence( this.device, pCreateInfo, pAllocator, pFence );
	}
	void DestroyFence( VkFence fence, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyFence( this.device, fence, pAllocator );
	}
	VkResult ResetFences( uint32_t fenceCount, const( VkFence )* pFences ) {
		return vkResetFences( this.device, fenceCount, pFences );
	}
	VkResult GetFenceStatus( VkFence fence ) {
		return vkGetFenceStatus( this.device, fence );
	}
	VkResult WaitForFences( uint32_t fenceCount, const( VkFence )* pFences, VkBool32 waitAll, uint64_t timeout ) {
		return vkWaitForFences( this.device, fenceCount, pFences, waitAll, timeout );
	}
	VkResult CreateSemaphore( const( VkSemaphoreCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSemaphore* pSemaphore ) {
		return vkCreateSemaphore( this.device, pCreateInfo, pAllocator, pSemaphore );
	}
	void DestroySemaphore( VkSemaphore semaphore, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroySemaphore( this.device, semaphore, pAllocator );
	}
	VkResult CreateEvent( const( VkEventCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkEvent* pEvent ) {
		return vkCreateEvent( this.device, pCreateInfo, pAllocator, pEvent );
	}
	void DestroyEvent( VkEvent event, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyEvent( this.device, event, pAllocator );
	}
	VkResult GetEventStatus( VkEvent event ) {
		return vkGetEventStatus( this.device, event );
	}
	VkResult SetEvent( VkEvent event ) {
		return vkSetEvent( this.device, event );
	}
	VkResult ResetEvent( VkEvent event ) {
		return vkResetEvent( this.device, event );
	}
	VkResult CreateQueryPool( const( VkQueryPoolCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkQueryPool* pQueryPool ) {
		return vkCreateQueryPool( this.device, pCreateInfo, pAllocator, pQueryPool );
	}
	void DestroyQueryPool( VkQueryPool queryPool, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyQueryPool( this.device, queryPool, pAllocator );
	}
	VkResult GetQueryPoolResults( VkQueryPool queryPool, uint32_t firstQuery, uint32_t queryCount, size_t dataSize, void* pData, VkDeviceSize stride, VkQueryResultFlags flags ) {
		return vkGetQueryPoolResults( this.device, queryPool, firstQuery, queryCount, dataSize, pData, stride, flags );
	}
	VkResult CreateBuffer( const( VkBufferCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkBuffer* pBuffer ) {
		return vkCreateBuffer( this.device, pCreateInfo, pAllocator, pBuffer );
	}
	void DestroyBuffer( VkBuffer buffer, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyBuffer( this.device, buffer, pAllocator );
	}
	VkResult CreateBufferView( const( VkBufferViewCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkBufferView* pView ) {
		return vkCreateBufferView( this.device, pCreateInfo, pAllocator, pView );
	}
	void DestroyBufferView( VkBufferView bufferView, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyBufferView( this.device, bufferView, pAllocator );
	}
	VkResult CreateImage( const( VkImageCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkImage* pImage ) {
		return vkCreateImage( this.device, pCreateInfo, pAllocator, pImage );
	}
	void DestroyImage( VkImage image, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyImage( this.device, image, pAllocator );
	}
	void GetImageSubresourceLayout( VkImage image, const( VkImageSubresource )* pSubresource, VkSubresourceLayout* pLayout ) {
		vkGetImageSubresourceLayout( this.device, image, pSubresource, pLayout );
	}
	VkResult CreateImageView( const( VkImageViewCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkImageView* pView ) {
		return vkCreateImageView( this.device, pCreateInfo, pAllocator, pView );
	}
	void DestroyImageView( VkImageView imageView, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyImageView( this.device, imageView, pAllocator );
	}
	VkResult CreateShaderModule( const( VkShaderModuleCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkShaderModule* pShaderModule ) {
		return vkCreateShaderModule( this.device, pCreateInfo, pAllocator, pShaderModule );
	}
	void DestroyShaderModule( VkShaderModule shaderModule, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyShaderModule( this.device, shaderModule, pAllocator );
	}
	VkResult CreatePipelineCache( const( VkPipelineCacheCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkPipelineCache* pPipelineCache ) {
		return vkCreatePipelineCache( this.device, pCreateInfo, pAllocator, pPipelineCache );
	}
	void DestroyPipelineCache( VkPipelineCache pipelineCache, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyPipelineCache( this.device, pipelineCache, pAllocator );
	}
	VkResult GetPipelineCacheData( VkPipelineCache pipelineCache, size_t* pDataSize, void* pData ) {
		return vkGetPipelineCacheData( this.device, pipelineCache, pDataSize, pData );
	}
	VkResult MergePipelineCaches( VkPipelineCache dstCache, uint32_t srcCacheCount, const( VkPipelineCache )* pSrcCaches ) {
		return vkMergePipelineCaches( this.device, dstCache, srcCacheCount, pSrcCaches );
	}
	VkResult CreateGraphicsPipelines( VkPipelineCache pipelineCache, uint32_t createInfoCount, const( VkGraphicsPipelineCreateInfo )* pCreateInfos, const( VkAllocationCallbacks )* pAllocator, VkPipeline* pPipelines ) {
		return vkCreateGraphicsPipelines( this.device, pipelineCache, createInfoCount, pCreateInfos, pAllocator, pPipelines );
	}
	VkResult CreateComputePipelines( VkPipelineCache pipelineCache, uint32_t createInfoCount, const( VkComputePipelineCreateInfo )* pCreateInfos, const( VkAllocationCallbacks )* pAllocator, VkPipeline* pPipelines ) {
		return vkCreateComputePipelines( this.device, pipelineCache, createInfoCount, pCreateInfos, pAllocator, pPipelines );
	}
	void DestroyPipeline( VkPipeline pipeline, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyPipeline( this.device, pipeline, pAllocator );
	}
	VkResult CreatePipelineLayout( const( VkPipelineLayoutCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkPipelineLayout* pPipelineLayout ) {
		return vkCreatePipelineLayout( this.device, pCreateInfo, pAllocator, pPipelineLayout );
	}
	void DestroyPipelineLayout( VkPipelineLayout pipelineLayout, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyPipelineLayout( this.device, pipelineLayout, pAllocator );
	}
	VkResult CreateSampler( const( VkSamplerCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSampler* pSampler ) {
		return vkCreateSampler( this.device, pCreateInfo, pAllocator, pSampler );
	}
	void DestroySampler( VkSampler sampler, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroySampler( this.device, sampler, pAllocator );
	}
	VkResult CreateDescriptorSetLayout( const( VkDescriptorSetLayoutCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkDescriptorSetLayout* pSetLayout ) {
		return vkCreateDescriptorSetLayout( this.device, pCreateInfo, pAllocator, pSetLayout );
	}
	void DestroyDescriptorSetLayout( VkDescriptorSetLayout descriptorSetLayout, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyDescriptorSetLayout( this.device, descriptorSetLayout, pAllocator );
	}
	VkResult CreateDescriptorPool( const( VkDescriptorPoolCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkDescriptorPool* pDescriptorPool ) {
		return vkCreateDescriptorPool( this.device, pCreateInfo, pAllocator, pDescriptorPool );
	}
	void DestroyDescriptorPool( VkDescriptorPool descriptorPool, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyDescriptorPool( this.device, descriptorPool, pAllocator );
	}
	VkResult ResetDescriptorPool( VkDescriptorPool descriptorPool, VkDescriptorPoolResetFlags flags ) {
		return vkResetDescriptorPool( this.device, descriptorPool, flags );
	}
	VkResult AllocateDescriptorSets( const( VkDescriptorSetAllocateInfo )* pAllocateInfo, VkDescriptorSet* pDescriptorSets ) {
		return vkAllocateDescriptorSets( this.device, pAllocateInfo, pDescriptorSets );
	}
	VkResult FreeDescriptorSets( VkDescriptorPool descriptorPool, uint32_t descriptorSetCount, const( VkDescriptorSet )* pDescriptorSets ) {
		return vkFreeDescriptorSets( this.device, descriptorPool, descriptorSetCount, pDescriptorSets );
	}
	void UpdateDescriptorSets( uint32_t descriptorWriteCount, const( VkWriteDescriptorSet )* pDescriptorWrites, uint32_t descriptorCopyCount, const( VkCopyDescriptorSet )* pDescriptorCopies ) {
		vkUpdateDescriptorSets( this.device, descriptorWriteCount, pDescriptorWrites, descriptorCopyCount, pDescriptorCopies );
	}
	VkResult CreateFramebuffer( const( VkFramebufferCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkFramebuffer* pFramebuffer ) {
		return vkCreateFramebuffer( this.device, pCreateInfo, pAllocator, pFramebuffer );
	}
	void DestroyFramebuffer( VkFramebuffer framebuffer, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyFramebuffer( this.device, framebuffer, pAllocator );
	}
	VkResult CreateRenderPass( const( VkRenderPassCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkRenderPass* pRenderPass ) {
		return vkCreateRenderPass( this.device, pCreateInfo, pAllocator, pRenderPass );
	}
	void DestroyRenderPass( VkRenderPass renderPass, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyRenderPass( this.device, renderPass, pAllocator );
	}
	void GetRenderAreaGranularity( VkRenderPass renderPass, VkExtent2D* pGranularity ) {
		vkGetRenderAreaGranularity( this.device, renderPass, pGranularity );
	}
	VkResult CreateCommandPool( const( VkCommandPoolCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkCommandPool* pCommandPool ) {
		return vkCreateCommandPool( this.device, pCreateInfo, pAllocator, pCommandPool );
	}
	void DestroyCommandPool( VkCommandPool commandPool, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyCommandPool( this.device, commandPool, pAllocator );
	}
	VkResult ResetCommandPool( VkCommandPool commandPool, VkCommandPoolResetFlags flags ) {
		return vkResetCommandPool( this.device, commandPool, flags );
	}
	VkResult AllocateCommandBuffers( const( VkCommandBufferAllocateInfo )* pAllocateInfo, VkCommandBuffer* pCommandBuffers ) {
		return vkAllocateCommandBuffers( this.device, pAllocateInfo, pCommandBuffers );
	}
	void FreeCommandBuffers( VkCommandPool commandPool, uint32_t commandBufferCount, const( VkCommandBuffer )* pCommandBuffers ) {
		vkFreeCommandBuffers( this.device, commandPool, commandBufferCount, pCommandBuffers );
	}
	VkResult BeginCommandBuffer( const( VkCommandBufferBeginInfo )* pBeginInfo ) {
		return vkBeginCommandBuffer( this.commandBuffer, pBeginInfo );
	}
	VkResult EndCommandBuffer() {
		return vkEndCommandBuffer( this.commandBuffer );
	}
	VkResult ResetCommandBuffer( VkCommandBufferResetFlags flags ) {
		return vkResetCommandBuffer( this.commandBuffer, flags );
	}
	void CmdBindPipeline( VkPipelineBindPoint pipelineBindPoint, VkPipeline pipeline ) {
		vkCmdBindPipeline( this.commandBuffer, pipelineBindPoint, pipeline );
	}
	void CmdSetViewport( uint32_t firstViewport, uint32_t viewportCount, const( VkViewport )* pViewports ) {
		vkCmdSetViewport( this.commandBuffer, firstViewport, viewportCount, pViewports );
	}
	void CmdSetScissor( uint32_t firstScissor, uint32_t scissorCount, const( VkRect2D )* pScissors ) {
		vkCmdSetScissor( this.commandBuffer, firstScissor, scissorCount, pScissors );
	}
	void CmdSetLineWidth( float lineWidth ) {
		vkCmdSetLineWidth( this.commandBuffer, lineWidth );
	}
	void CmdSetDepthBias( float depthBiasConstantFactor, float depthBiasClamp, float depthBiasSlopeFactor ) {
		vkCmdSetDepthBias( this.commandBuffer, depthBiasConstantFactor, depthBiasClamp, depthBiasSlopeFactor );
	}
	void CmdSetBlendConstants( const float[4] blendConstants ) {
		vkCmdSetBlendConstants( this.commandBuffer, blendConstants );
	}
	void CmdSetDepthBounds( float minDepthBounds, float maxDepthBounds ) {
		vkCmdSetDepthBounds( this.commandBuffer, minDepthBounds, maxDepthBounds );
	}
	void CmdSetStencilCompareMask( VkStencilFaceFlags faceMask, uint32_t compareMask ) {
		vkCmdSetStencilCompareMask( this.commandBuffer, faceMask, compareMask );
	}
	void CmdSetStencilWriteMask( VkStencilFaceFlags faceMask, uint32_t writeMask ) {
		vkCmdSetStencilWriteMask( this.commandBuffer, faceMask, writeMask );
	}
	void CmdSetStencilReference( VkStencilFaceFlags faceMask, uint32_t reference ) {
		vkCmdSetStencilReference( this.commandBuffer, faceMask, reference );
	}
	void CmdBindDescriptorSets( VkPipelineBindPoint pipelineBindPoint, VkPipelineLayout layout, uint32_t firstSet, uint32_t descriptorSetCount, const( VkDescriptorSet )* pDescriptorSets, uint32_t dynamicOffsetCount, const( uint32_t )* pDynamicOffsets ) {
		vkCmdBindDescriptorSets( this.commandBuffer, pipelineBindPoint, layout, firstSet, descriptorSetCount, pDescriptorSets, dynamicOffsetCount, pDynamicOffsets );
	}
	void CmdBindIndexBuffer( VkBuffer buffer, VkDeviceSize offset, VkIndexType indexType ) {
		vkCmdBindIndexBuffer( this.commandBuffer, buffer, offset, indexType );
	}
	void CmdBindVertexBuffers( uint32_t firstBinding, uint32_t bindingCount, const( VkBuffer )* pBuffers, const( VkDeviceSize )* pOffsets ) {
		vkCmdBindVertexBuffers( this.commandBuffer, firstBinding, bindingCount, pBuffers, pOffsets );
	}
	void CmdDraw( uint32_t vertexCount, uint32_t instanceCount, uint32_t firstVertex, uint32_t firstInstance ) {
		vkCmdDraw( this.commandBuffer, vertexCount, instanceCount, firstVertex, firstInstance );
	}
	void CmdDrawIndexed( uint32_t indexCount, uint32_t instanceCount, uint32_t firstIndex, int32_t vertexOffset, uint32_t firstInstance ) {
		vkCmdDrawIndexed( this.commandBuffer, indexCount, instanceCount, firstIndex, vertexOffset, firstInstance );
	}
	void CmdDrawIndirect( VkBuffer buffer, VkDeviceSize offset, uint32_t drawCount, uint32_t stride ) {
		vkCmdDrawIndirect( this.commandBuffer, buffer, offset, drawCount, stride );
	}
	void CmdDrawIndexedIndirect( VkBuffer buffer, VkDeviceSize offset, uint32_t drawCount, uint32_t stride ) {
		vkCmdDrawIndexedIndirect( this.commandBuffer, buffer, offset, drawCount, stride );
	}
	void CmdDispatch( uint32_t groupCountX, uint32_t groupCountY, uint32_t groupCountZ ) {
		vkCmdDispatch( this.commandBuffer, groupCountX, groupCountY, groupCountZ );
	}
	void CmdDispatchIndirect( VkBuffer buffer, VkDeviceSize offset ) {
		vkCmdDispatchIndirect( this.commandBuffer, buffer, offset );
	}
	void CmdCopyBuffer( VkBuffer srcBuffer, VkBuffer dstBuffer, uint32_t regionCount, const( VkBufferCopy )* pRegions ) {
		vkCmdCopyBuffer( this.commandBuffer, srcBuffer, dstBuffer, regionCount, pRegions );
	}
	void CmdCopyImage( VkImage srcImage, VkImageLayout srcImageLayout, VkImage dstImage, VkImageLayout dstImageLayout, uint32_t regionCount, const( VkImageCopy )* pRegions ) {
		vkCmdCopyImage( this.commandBuffer, srcImage, srcImageLayout, dstImage, dstImageLayout, regionCount, pRegions );
	}
	void CmdBlitImage( VkImage srcImage, VkImageLayout srcImageLayout, VkImage dstImage, VkImageLayout dstImageLayout, uint32_t regionCount, const( VkImageBlit )* pRegions, VkFilter filter ) {
		vkCmdBlitImage( this.commandBuffer, srcImage, srcImageLayout, dstImage, dstImageLayout, regionCount, pRegions, filter );
	}
	void CmdCopyBufferToImage( VkBuffer srcBuffer, VkImage dstImage, VkImageLayout dstImageLayout, uint32_t regionCount, const( VkBufferImageCopy )* pRegions ) {
		vkCmdCopyBufferToImage( this.commandBuffer, srcBuffer, dstImage, dstImageLayout, regionCount, pRegions );
	}
	void CmdCopyImageToBuffer( VkImage srcImage, VkImageLayout srcImageLayout, VkBuffer dstBuffer, uint32_t regionCount, const( VkBufferImageCopy )* pRegions ) {
		vkCmdCopyImageToBuffer( this.commandBuffer, srcImage, srcImageLayout, dstBuffer, regionCount, pRegions );
	}
	void CmdUpdateBuffer( VkBuffer dstBuffer, VkDeviceSize dstOffset, VkDeviceSize dataSize, const( void )* pData ) {
		vkCmdUpdateBuffer( this.commandBuffer, dstBuffer, dstOffset, dataSize, pData );
	}
	void CmdFillBuffer( VkBuffer dstBuffer, VkDeviceSize dstOffset, VkDeviceSize size, uint32_t data ) {
		vkCmdFillBuffer( this.commandBuffer, dstBuffer, dstOffset, size, data );
	}
	void CmdClearColorImage( VkImage image, VkImageLayout imageLayout, const( VkClearColorValue )* pColor, uint32_t rangeCount, const( VkImageSubresourceRange )* pRanges ) {
		vkCmdClearColorImage( this.commandBuffer, image, imageLayout, pColor, rangeCount, pRanges );
	}
	void CmdClearDepthStencilImage( VkImage image, VkImageLayout imageLayout, const( VkClearDepthStencilValue )* pDepthStencil, uint32_t rangeCount, const( VkImageSubresourceRange )* pRanges ) {
		vkCmdClearDepthStencilImage( this.commandBuffer, image, imageLayout, pDepthStencil, rangeCount, pRanges );
	}
	void CmdClearAttachments( uint32_t attachmentCount, const( VkClearAttachment )* pAttachments, uint32_t rectCount, const( VkClearRect )* pRects ) {
		vkCmdClearAttachments( this.commandBuffer, attachmentCount, pAttachments, rectCount, pRects );
	}
	void CmdResolveImage( VkImage srcImage, VkImageLayout srcImageLayout, VkImage dstImage, VkImageLayout dstImageLayout, uint32_t regionCount, const( VkImageResolve )* pRegions ) {
		vkCmdResolveImage( this.commandBuffer, srcImage, srcImageLayout, dstImage, dstImageLayout, regionCount, pRegions );
	}
	void CmdSetEvent( VkEvent event, VkPipelineStageFlags stageMask ) {
		vkCmdSetEvent( this.commandBuffer, event, stageMask );
	}
	void CmdResetEvent( VkEvent event, VkPipelineStageFlags stageMask ) {
		vkCmdResetEvent( this.commandBuffer, event, stageMask );
	}
	void CmdWaitEvents( uint32_t eventCount, const( VkEvent )* pEvents, VkPipelineStageFlags srcStageMask, VkPipelineStageFlags dstStageMask, uint32_t memoryBarrierCount, const( VkMemoryBarrier )* pMemoryBarriers, uint32_t bufferMemoryBarrierCount, const( VkBufferMemoryBarrier )* pBufferMemoryBarriers, uint32_t imageMemoryBarrierCount, const( VkImageMemoryBarrier )* pImageMemoryBarriers ) {
		vkCmdWaitEvents( this.commandBuffer, eventCount, pEvents, srcStageMask, dstStageMask, memoryBarrierCount, pMemoryBarriers, bufferMemoryBarrierCount, pBufferMemoryBarriers, imageMemoryBarrierCount, pImageMemoryBarriers );
	}
	void CmdPipelineBarrier( VkPipelineStageFlags srcStageMask, VkPipelineStageFlags dstStageMask, VkDependencyFlags dependencyFlags, uint32_t memoryBarrierCount, const( VkMemoryBarrier )* pMemoryBarriers, uint32_t bufferMemoryBarrierCount, const( VkBufferMemoryBarrier )* pBufferMemoryBarriers, uint32_t imageMemoryBarrierCount, const( VkImageMemoryBarrier )* pImageMemoryBarriers ) {
		vkCmdPipelineBarrier( this.commandBuffer, srcStageMask, dstStageMask, dependencyFlags, memoryBarrierCount, pMemoryBarriers, bufferMemoryBarrierCount, pBufferMemoryBarriers, imageMemoryBarrierCount, pImageMemoryBarriers );
	}
	void CmdBeginQuery( VkQueryPool queryPool, uint32_t query, VkQueryControlFlags flags ) {
		vkCmdBeginQuery( this.commandBuffer, queryPool, query, flags );
	}
	void CmdEndQuery( VkQueryPool queryPool, uint32_t query ) {
		vkCmdEndQuery( this.commandBuffer, queryPool, query );
	}
	void CmdResetQueryPool( VkQueryPool queryPool, uint32_t firstQuery, uint32_t queryCount ) {
		vkCmdResetQueryPool( this.commandBuffer, queryPool, firstQuery, queryCount );
	}
	void CmdWriteTimestamp( VkPipelineStageFlagBits pipelineStage, VkQueryPool queryPool, uint32_t query ) {
		vkCmdWriteTimestamp( this.commandBuffer, pipelineStage, queryPool, query );
	}
	void CmdCopyQueryPoolResults( VkQueryPool queryPool, uint32_t firstQuery, uint32_t queryCount, VkBuffer dstBuffer, VkDeviceSize dstOffset, VkDeviceSize stride, VkQueryResultFlags flags ) {
		vkCmdCopyQueryPoolResults( this.commandBuffer, queryPool, firstQuery, queryCount, dstBuffer, dstOffset, stride, flags );
	}
	void CmdPushConstants( VkPipelineLayout layout, VkShaderStageFlags stageFlags, uint32_t offset, uint32_t size, const( void )* pValues ) {
		vkCmdPushConstants( this.commandBuffer, layout, stageFlags, offset, size, pValues );
	}
	void CmdBeginRenderPass( const( VkRenderPassBeginInfo )* pRenderPassBegin, VkSubpassContents contents ) {
		vkCmdBeginRenderPass( this.commandBuffer, pRenderPassBegin, contents );
	}
	void CmdNextSubpass( VkSubpassContents contents ) {
		vkCmdNextSubpass( this.commandBuffer, contents );
	}
	void CmdEndRenderPass() {
		vkCmdEndRenderPass( this.commandBuffer );
	}
	void CmdExecuteCommands( uint32_t commandBufferCount, const( VkCommandBuffer )* pCommandBuffers ) {
		vkCmdExecuteCommands( this.commandBuffer, commandBufferCount, pCommandBuffers );
	}

	// VK_VERSION_1_1
	VkResult BindBufferMemory2( uint32_t bindInfoCount, const( VkBindBufferMemoryInfo )* pBindInfos ) {
		return vkBindBufferMemory2( this.device, bindInfoCount, pBindInfos );
	}
	VkResult BindImageMemory2( uint32_t bindInfoCount, const( VkBindImageMemoryInfo )* pBindInfos ) {
		return vkBindImageMemory2( this.device, bindInfoCount, pBindInfos );
	}
	void GetDeviceGroupPeerMemoryFeatures( uint32_t heapIndex, uint32_t localDeviceIndex, uint32_t remoteDeviceIndex, VkPeerMemoryFeatureFlags* pPeerMemoryFeatures ) {
		vkGetDeviceGroupPeerMemoryFeatures( this.device, heapIndex, localDeviceIndex, remoteDeviceIndex, pPeerMemoryFeatures );
	}
	void CmdSetDeviceMask( uint32_t deviceMask ) {
		vkCmdSetDeviceMask( this.commandBuffer, deviceMask );
	}
	void CmdDispatchBase( uint32_t baseGroupX, uint32_t baseGroupY, uint32_t baseGroupZ, uint32_t groupCountX, uint32_t groupCountY, uint32_t groupCountZ ) {
		vkCmdDispatchBase( this.commandBuffer, baseGroupX, baseGroupY, baseGroupZ, groupCountX, groupCountY, groupCountZ );
	}
	void GetImageMemoryRequirements2( const( VkImageMemoryRequirementsInfo2 )* pInfo, VkMemoryRequirements2* pMemoryRequirements ) {
		vkGetImageMemoryRequirements2( this.device, pInfo, pMemoryRequirements );
	}
	void GetBufferMemoryRequirements2( const( VkBufferMemoryRequirementsInfo2 )* pInfo, VkMemoryRequirements2* pMemoryRequirements ) {
		vkGetBufferMemoryRequirements2( this.device, pInfo, pMemoryRequirements );
	}
	void GetImageSparseMemoryRequirements2( const( VkImageSparseMemoryRequirementsInfo2 )* pInfo, uint32_t* pSparseMemoryRequirementCount, VkSparseImageMemoryRequirements2* pSparseMemoryRequirements ) {
		vkGetImageSparseMemoryRequirements2( this.device, pInfo, pSparseMemoryRequirementCount, pSparseMemoryRequirements );
	}
	void TrimCommandPool( VkCommandPool commandPool, VkCommandPoolTrimFlags flags ) {
		vkTrimCommandPool( this.device, commandPool, flags );
	}
	void GetDeviceQueue2( const( VkDeviceQueueInfo2 )* pQueueInfo, VkQueue* pQueue ) {
		vkGetDeviceQueue2( this.device, pQueueInfo, pQueue );
	}
	VkResult CreateSamplerYcbcrConversion( const( VkSamplerYcbcrConversionCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSamplerYcbcrConversion* pYcbcrConversion ) {
		return vkCreateSamplerYcbcrConversion( this.device, pCreateInfo, pAllocator, pYcbcrConversion );
	}
	void DestroySamplerYcbcrConversion( VkSamplerYcbcrConversion ycbcrConversion, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroySamplerYcbcrConversion( this.device, ycbcrConversion, pAllocator );
	}
	VkResult CreateDescriptorUpdateTemplate( const( VkDescriptorUpdateTemplateCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkDescriptorUpdateTemplate* pDescriptorUpdateTemplate ) {
		return vkCreateDescriptorUpdateTemplate( this.device, pCreateInfo, pAllocator, pDescriptorUpdateTemplate );
	}
	void DestroyDescriptorUpdateTemplate( VkDescriptorUpdateTemplate descriptorUpdateTemplate, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyDescriptorUpdateTemplate( this.device, descriptorUpdateTemplate, pAllocator );
	}
	void UpdateDescriptorSetWithTemplate( VkDescriptorSet descriptorSet, VkDescriptorUpdateTemplate descriptorUpdateTemplate, const( void )* pData ) {
		vkUpdateDescriptorSetWithTemplate( this.device, descriptorSet, descriptorUpdateTemplate, pData );
	}
	void GetDescriptorSetLayoutSupport( const( VkDescriptorSetLayoutCreateInfo )* pCreateInfo, VkDescriptorSetLayoutSupport* pSupport ) {
		vkGetDescriptorSetLayoutSupport( this.device, pCreateInfo, pSupport );
	}

	// VK_VERSION_1_2
	void CmdDrawIndirectCount( VkBuffer buffer, VkDeviceSize offset, VkBuffer countBuffer, VkDeviceSize countBufferOffset, uint32_t maxDrawCount, uint32_t stride ) {
		vkCmdDrawIndirectCount( this.commandBuffer, buffer, offset, countBuffer, countBufferOffset, maxDrawCount, stride );
	}
	void CmdDrawIndexedIndirectCount( VkBuffer buffer, VkDeviceSize offset, VkBuffer countBuffer, VkDeviceSize countBufferOffset, uint32_t maxDrawCount, uint32_t stride ) {
		vkCmdDrawIndexedIndirectCount( this.commandBuffer, buffer, offset, countBuffer, countBufferOffset, maxDrawCount, stride );
	}
	VkResult CreateRenderPass2( const( VkRenderPassCreateInfo2 )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkRenderPass* pRenderPass ) {
		return vkCreateRenderPass2( this.device, pCreateInfo, pAllocator, pRenderPass );
	}
	void CmdBeginRenderPass2( const( VkRenderPassBeginInfo )* pRenderPassBegin, const( VkSubpassBeginInfo )* pSubpassBeginInfo ) {
		vkCmdBeginRenderPass2( this.commandBuffer, pRenderPassBegin, pSubpassBeginInfo );
	}
	void CmdNextSubpass2( const( VkSubpassBeginInfo )* pSubpassBeginInfo, const( VkSubpassEndInfo )* pSubpassEndInfo ) {
		vkCmdNextSubpass2( this.commandBuffer, pSubpassBeginInfo, pSubpassEndInfo );
	}
	void CmdEndRenderPass2( const( VkSubpassEndInfo )* pSubpassEndInfo ) {
		vkCmdEndRenderPass2( this.commandBuffer, pSubpassEndInfo );
	}
	void ResetQueryPool( VkQueryPool queryPool, uint32_t firstQuery, uint32_t queryCount ) {
		vkResetQueryPool( this.device, queryPool, firstQuery, queryCount );
	}
	VkResult GetSemaphoreCounterValue( VkSemaphore semaphore, uint64_t* pValue ) {
		return vkGetSemaphoreCounterValue( this.device, semaphore, pValue );
	}
	VkResult WaitSemaphores( const( VkSemaphoreWaitInfo )* pWaitInfo, uint64_t timeout ) {
		return vkWaitSemaphores( this.device, pWaitInfo, timeout );
	}
	VkResult SignalSemaphore( const( VkSemaphoreSignalInfo )* pSignalInfo ) {
		return vkSignalSemaphore( this.device, pSignalInfo );
	}
	VkDeviceAddress GetBufferDeviceAddress( const( VkBufferDeviceAddressInfo )* pInfo ) {
		return vkGetBufferDeviceAddress( this.device, pInfo );
	}
	uint64_t GetBufferOpaqueCaptureAddress( const( VkBufferDeviceAddressInfo )* pInfo ) {
		return vkGetBufferOpaqueCaptureAddress( this.device, pInfo );
	}
	uint64_t GetDeviceMemoryOpaqueCaptureAddress( const( VkDeviceMemoryOpaqueCaptureAddressInfo )* pInfo ) {
		return vkGetDeviceMemoryOpaqueCaptureAddress( this.device, pInfo );
	}

	// VK_VERSION_1_3
	VkResult CreatePrivateDataSlot( const( VkPrivateDataSlotCreateInfo )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkPrivateDataSlot* pPrivateDataSlot ) {
		return vkCreatePrivateDataSlot( this.device, pCreateInfo, pAllocator, pPrivateDataSlot );
	}
	void DestroyPrivateDataSlot( VkPrivateDataSlot privateDataSlot, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroyPrivateDataSlot( this.device, privateDataSlot, pAllocator );
	}
	VkResult SetPrivateData( VkObjectType objectType, uint64_t objectHandle, VkPrivateDataSlot privateDataSlot, uint64_t data ) {
		return vkSetPrivateData( this.device, objectType, objectHandle, privateDataSlot, data );
	}
	void GetPrivateData( VkObjectType objectType, uint64_t objectHandle, VkPrivateDataSlot privateDataSlot, uint64_t* pData ) {
		vkGetPrivateData( this.device, objectType, objectHandle, privateDataSlot, pData );
	}
	void CmdSetEvent2( VkEvent event, const( VkDependencyInfo )* pDependencyInfo ) {
		vkCmdSetEvent2( this.commandBuffer, event, pDependencyInfo );
	}
	void CmdResetEvent2( VkEvent event, VkPipelineStageFlags2 stageMask ) {
		vkCmdResetEvent2( this.commandBuffer, event, stageMask );
	}
	void CmdWaitEvents2( uint32_t eventCount, const( VkEvent )* pEvents, const( VkDependencyInfo )* pDependencyInfos ) {
		vkCmdWaitEvents2( this.commandBuffer, eventCount, pEvents, pDependencyInfos );
	}
	void CmdPipelineBarrier2( const( VkDependencyInfo )* pDependencyInfo ) {
		vkCmdPipelineBarrier2( this.commandBuffer, pDependencyInfo );
	}
	void CmdWriteTimestamp2( VkPipelineStageFlags2 stage, VkQueryPool queryPool, uint32_t query ) {
		vkCmdWriteTimestamp2( this.commandBuffer, stage, queryPool, query );
	}
	void CmdCopyBuffer2( const( VkCopyBufferInfo2 )* pCopyBufferInfo ) {
		vkCmdCopyBuffer2( this.commandBuffer, pCopyBufferInfo );
	}
	void CmdCopyImage2( const( VkCopyImageInfo2 )* pCopyImageInfo ) {
		vkCmdCopyImage2( this.commandBuffer, pCopyImageInfo );
	}
	void CmdCopyBufferToImage2( const( VkCopyBufferToImageInfo2 )* pCopyBufferToImageInfo ) {
		vkCmdCopyBufferToImage2( this.commandBuffer, pCopyBufferToImageInfo );
	}
	void CmdCopyImageToBuffer2( const( VkCopyImageToBufferInfo2 )* pCopyImageToBufferInfo ) {
		vkCmdCopyImageToBuffer2( this.commandBuffer, pCopyImageToBufferInfo );
	}
	void CmdBlitImage2( const( VkBlitImageInfo2 )* pBlitImageInfo ) {
		vkCmdBlitImage2( this.commandBuffer, pBlitImageInfo );
	}
	void CmdResolveImage2( const( VkResolveImageInfo2 )* pResolveImageInfo ) {
		vkCmdResolveImage2( this.commandBuffer, pResolveImageInfo );
	}
	void CmdBeginRendering( const( VkRenderingInfo )* pRenderingInfo ) {
		vkCmdBeginRendering( this.commandBuffer, pRenderingInfo );
	}
	void CmdEndRendering() {
		vkCmdEndRendering( this.commandBuffer );
	}
	void CmdSetCullMode( VkCullModeFlags cullMode ) {
		vkCmdSetCullMode( this.commandBuffer, cullMode );
	}
	void CmdSetFrontFace( VkFrontFace frontFace ) {
		vkCmdSetFrontFace( this.commandBuffer, frontFace );
	}
	void CmdSetPrimitiveTopology( VkPrimitiveTopology primitiveTopology ) {
		vkCmdSetPrimitiveTopology( this.commandBuffer, primitiveTopology );
	}
	void CmdSetViewportWithCount( uint32_t viewportCount, const( VkViewport )* pViewports ) {
		vkCmdSetViewportWithCount( this.commandBuffer, viewportCount, pViewports );
	}
	void CmdSetScissorWithCount( uint32_t scissorCount, const( VkRect2D )* pScissors ) {
		vkCmdSetScissorWithCount( this.commandBuffer, scissorCount, pScissors );
	}
	void CmdBindVertexBuffers2( uint32_t firstBinding, uint32_t bindingCount, const( VkBuffer )* pBuffers, const( VkDeviceSize )* pOffsets, const( VkDeviceSize )* pSizes, const( VkDeviceSize )* pStrides ) {
		vkCmdBindVertexBuffers2( this.commandBuffer, firstBinding, bindingCount, pBuffers, pOffsets, pSizes, pStrides );
	}
	void CmdSetDepthTestEnable( VkBool32 depthTestEnable ) {
		vkCmdSetDepthTestEnable( this.commandBuffer, depthTestEnable );
	}
	void CmdSetDepthWriteEnable( VkBool32 depthWriteEnable ) {
		vkCmdSetDepthWriteEnable( this.commandBuffer, depthWriteEnable );
	}
	void CmdSetDepthCompareOp( VkCompareOp depthCompareOp ) {
		vkCmdSetDepthCompareOp( this.commandBuffer, depthCompareOp );
	}
	void CmdSetDepthBoundsTestEnable( VkBool32 depthBoundsTestEnable ) {
		vkCmdSetDepthBoundsTestEnable( this.commandBuffer, depthBoundsTestEnable );
	}
	void CmdSetStencilTestEnable( VkBool32 stencilTestEnable ) {
		vkCmdSetStencilTestEnable( this.commandBuffer, stencilTestEnable );
	}
	void CmdSetStencilOp( VkStencilFaceFlags faceMask, VkStencilOp failOp, VkStencilOp passOp, VkStencilOp depthFailOp, VkCompareOp compareOp ) {
		vkCmdSetStencilOp( this.commandBuffer, faceMask, failOp, passOp, depthFailOp, compareOp );
	}
	void CmdSetRasterizerDiscardEnable( VkBool32 rasterizerDiscardEnable ) {
		vkCmdSetRasterizerDiscardEnable( this.commandBuffer, rasterizerDiscardEnable );
	}
	void CmdSetDepthBiasEnable( VkBool32 depthBiasEnable ) {
		vkCmdSetDepthBiasEnable( this.commandBuffer, depthBiasEnable );
	}
	void CmdSetPrimitiveRestartEnable( VkBool32 primitiveRestartEnable ) {
		vkCmdSetPrimitiveRestartEnable( this.commandBuffer, primitiveRestartEnable );
	}
	void GetDeviceBufferMemoryRequirements( const( VkDeviceBufferMemoryRequirements )* pInfo, VkMemoryRequirements2* pMemoryRequirements ) {
		vkGetDeviceBufferMemoryRequirements( this.device, pInfo, pMemoryRequirements );
	}
	void GetDeviceImageMemoryRequirements( const( VkDeviceImageMemoryRequirements )* pInfo, VkMemoryRequirements2* pMemoryRequirements ) {
		vkGetDeviceImageMemoryRequirements( this.device, pInfo, pMemoryRequirements );
	}
	void GetDeviceImageSparseMemoryRequirements( const( VkDeviceImageMemoryRequirements )* pInfo, uint32_t* pSparseMemoryRequirementCount, VkSparseImageMemoryRequirements2* pSparseMemoryRequirements ) {
		vkGetDeviceImageSparseMemoryRequirements( this.device, pInfo, pSparseMemoryRequirementCount, pSparseMemoryRequirements );
	}

	// VK_KHR_swapchain
	VkResult CreateSwapchainKHR( const( VkSwapchainCreateInfoKHR )* pCreateInfo, const( VkAllocationCallbacks )* pAllocator, VkSwapchainKHR* pSwapchain ) {
		return vkCreateSwapchainKHR( this.device, pCreateInfo, pAllocator, pSwapchain );
	}
	void DestroySwapchainKHR( VkSwapchainKHR swapchain, const( VkAllocationCallbacks )* pAllocator ) {
		vkDestroySwapchainKHR( this.device, swapchain, pAllocator );
	}
	VkResult GetSwapchainImagesKHR( VkSwapchainKHR swapchain, uint32_t* pSwapchainImageCount, VkImage* pSwapchainImages ) {
		return vkGetSwapchainImagesKHR( this.device, swapchain, pSwapchainImageCount, pSwapchainImages );
	}
	VkResult AcquireNextImageKHR( VkSwapchainKHR swapchain, uint64_t timeout, VkSemaphore semaphore, VkFence fence, uint32_t* pImageIndex ) {
		return vkAcquireNextImageKHR( this.device, swapchain, timeout, semaphore, fence, pImageIndex );
	}
	VkResult GetDeviceGroupPresentCapabilitiesKHR( VkDeviceGroupPresentCapabilitiesKHR* pDeviceGroupPresentCapabilities ) {
		return vkGetDeviceGroupPresentCapabilitiesKHR( this.device, pDeviceGroupPresentCapabilities );
	}
	VkResult GetDeviceGroupSurfacePresentModesKHR( VkSurfaceKHR surface, VkDeviceGroupPresentModeFlagsKHR* pModes ) {
		return vkGetDeviceGroupSurfacePresentModesKHR( this.device, surface, pModes );
	}
	VkResult AcquireNextImage2KHR( const( VkAcquireNextImageInfoKHR )* pAcquireInfo, uint32_t* pImageIndex ) {
		return vkAcquireNextImage2KHR( this.device, pAcquireInfo, pImageIndex );
	}

	// Member vulkan function decelerations
	PFN_vkDestroyDevice vkDestroyDevice;
	PFN_vkGetDeviceQueue vkGetDeviceQueue;
	PFN_vkQueueSubmit vkQueueSubmit;
	PFN_vkQueueWaitIdle vkQueueWaitIdle;
	PFN_vkDeviceWaitIdle vkDeviceWaitIdle;
	PFN_vkAllocateMemory vkAllocateMemory;
	PFN_vkFreeMemory vkFreeMemory;
	PFN_vkMapMemory vkMapMemory;
	PFN_vkUnmapMemory vkUnmapMemory;
	PFN_vkFlushMappedMemoryRanges vkFlushMappedMemoryRanges;
	PFN_vkInvalidateMappedMemoryRanges vkInvalidateMappedMemoryRanges;
	PFN_vkGetDeviceMemoryCommitment vkGetDeviceMemoryCommitment;
	PFN_vkBindBufferMemory vkBindBufferMemory;
	PFN_vkBindImageMemory vkBindImageMemory;
	PFN_vkGetBufferMemoryRequirements vkGetBufferMemoryRequirements;
	PFN_vkGetImageMemoryRequirements vkGetImageMemoryRequirements;
	PFN_vkGetImageSparseMemoryRequirements vkGetImageSparseMemoryRequirements;
	PFN_vkQueueBindSparse vkQueueBindSparse;
	PFN_vkCreateFence vkCreateFence;
	PFN_vkDestroyFence vkDestroyFence;
	PFN_vkResetFences vkResetFences;
	PFN_vkGetFenceStatus vkGetFenceStatus;
	PFN_vkWaitForFences vkWaitForFences;
	PFN_vkCreateSemaphore vkCreateSemaphore;
	PFN_vkDestroySemaphore vkDestroySemaphore;
	PFN_vkCreateEvent vkCreateEvent;
	PFN_vkDestroyEvent vkDestroyEvent;
	PFN_vkGetEventStatus vkGetEventStatus;
	PFN_vkSetEvent vkSetEvent;
	PFN_vkResetEvent vkResetEvent;
	PFN_vkCreateQueryPool vkCreateQueryPool;
	PFN_vkDestroyQueryPool vkDestroyQueryPool;
	PFN_vkGetQueryPoolResults vkGetQueryPoolResults;
	PFN_vkCreateBuffer vkCreateBuffer;
	PFN_vkDestroyBuffer vkDestroyBuffer;
	PFN_vkCreateBufferView vkCreateBufferView;
	PFN_vkDestroyBufferView vkDestroyBufferView;
	PFN_vkCreateImage vkCreateImage;
	PFN_vkDestroyImage vkDestroyImage;
	PFN_vkGetImageSubresourceLayout vkGetImageSubresourceLayout;
	PFN_vkCreateImageView vkCreateImageView;
	PFN_vkDestroyImageView vkDestroyImageView;
	PFN_vkCreateShaderModule vkCreateShaderModule;
	PFN_vkDestroyShaderModule vkDestroyShaderModule;
	PFN_vkCreatePipelineCache vkCreatePipelineCache;
	PFN_vkDestroyPipelineCache vkDestroyPipelineCache;
	PFN_vkGetPipelineCacheData vkGetPipelineCacheData;
	PFN_vkMergePipelineCaches vkMergePipelineCaches;
	PFN_vkCreateGraphicsPipelines vkCreateGraphicsPipelines;
	PFN_vkCreateComputePipelines vkCreateComputePipelines;
	PFN_vkDestroyPipeline vkDestroyPipeline;
	PFN_vkCreatePipelineLayout vkCreatePipelineLayout;
	PFN_vkDestroyPipelineLayout vkDestroyPipelineLayout;
	PFN_vkCreateSampler vkCreateSampler;
	PFN_vkDestroySampler vkDestroySampler;
	PFN_vkCreateDescriptorSetLayout vkCreateDescriptorSetLayout;
	PFN_vkDestroyDescriptorSetLayout vkDestroyDescriptorSetLayout;
	PFN_vkCreateDescriptorPool vkCreateDescriptorPool;
	PFN_vkDestroyDescriptorPool vkDestroyDescriptorPool;
	PFN_vkResetDescriptorPool vkResetDescriptorPool;
	PFN_vkAllocateDescriptorSets vkAllocateDescriptorSets;
	PFN_vkFreeDescriptorSets vkFreeDescriptorSets;
	PFN_vkUpdateDescriptorSets vkUpdateDescriptorSets;
	PFN_vkCreateFramebuffer vkCreateFramebuffer;
	PFN_vkDestroyFramebuffer vkDestroyFramebuffer;
	PFN_vkCreateRenderPass vkCreateRenderPass;
	PFN_vkDestroyRenderPass vkDestroyRenderPass;
	PFN_vkGetRenderAreaGranularity vkGetRenderAreaGranularity;
	PFN_vkCreateCommandPool vkCreateCommandPool;
	PFN_vkDestroyCommandPool vkDestroyCommandPool;
	PFN_vkResetCommandPool vkResetCommandPool;
	PFN_vkAllocateCommandBuffers vkAllocateCommandBuffers;
	PFN_vkFreeCommandBuffers vkFreeCommandBuffers;
	PFN_vkBeginCommandBuffer vkBeginCommandBuffer;
	PFN_vkEndCommandBuffer vkEndCommandBuffer;
	PFN_vkResetCommandBuffer vkResetCommandBuffer;
	PFN_vkCmdBindPipeline vkCmdBindPipeline;
	PFN_vkCmdSetViewport vkCmdSetViewport;
	PFN_vkCmdSetScissor vkCmdSetScissor;
	PFN_vkCmdSetLineWidth vkCmdSetLineWidth;
	PFN_vkCmdSetDepthBias vkCmdSetDepthBias;
	PFN_vkCmdSetBlendConstants vkCmdSetBlendConstants;
	PFN_vkCmdSetDepthBounds vkCmdSetDepthBounds;
	PFN_vkCmdSetStencilCompareMask vkCmdSetStencilCompareMask;
	PFN_vkCmdSetStencilWriteMask vkCmdSetStencilWriteMask;
	PFN_vkCmdSetStencilReference vkCmdSetStencilReference;
	PFN_vkCmdBindDescriptorSets vkCmdBindDescriptorSets;
	PFN_vkCmdBindIndexBuffer vkCmdBindIndexBuffer;
	PFN_vkCmdBindVertexBuffers vkCmdBindVertexBuffers;
	PFN_vkCmdDraw vkCmdDraw;
	PFN_vkCmdDrawIndexed vkCmdDrawIndexed;
	PFN_vkCmdDrawIndirect vkCmdDrawIndirect;
	PFN_vkCmdDrawIndexedIndirect vkCmdDrawIndexedIndirect;
	PFN_vkCmdDispatch vkCmdDispatch;
	PFN_vkCmdDispatchIndirect vkCmdDispatchIndirect;
	PFN_vkCmdCopyBuffer vkCmdCopyBuffer;
	PFN_vkCmdCopyImage vkCmdCopyImage;
	PFN_vkCmdBlitImage vkCmdBlitImage;
	PFN_vkCmdCopyBufferToImage vkCmdCopyBufferToImage;
	PFN_vkCmdCopyImageToBuffer vkCmdCopyImageToBuffer;
	PFN_vkCmdUpdateBuffer vkCmdUpdateBuffer;
	PFN_vkCmdFillBuffer vkCmdFillBuffer;
	PFN_vkCmdClearColorImage vkCmdClearColorImage;
	PFN_vkCmdClearDepthStencilImage vkCmdClearDepthStencilImage;
	PFN_vkCmdClearAttachments vkCmdClearAttachments;
	PFN_vkCmdResolveImage vkCmdResolveImage;
	PFN_vkCmdSetEvent vkCmdSetEvent;
	PFN_vkCmdResetEvent vkCmdResetEvent;
	PFN_vkCmdWaitEvents vkCmdWaitEvents;
	PFN_vkCmdPipelineBarrier vkCmdPipelineBarrier;
	PFN_vkCmdBeginQuery vkCmdBeginQuery;
	PFN_vkCmdEndQuery vkCmdEndQuery;
	PFN_vkCmdResetQueryPool vkCmdResetQueryPool;
	PFN_vkCmdWriteTimestamp vkCmdWriteTimestamp;
	PFN_vkCmdCopyQueryPoolResults vkCmdCopyQueryPoolResults;
	PFN_vkCmdPushConstants vkCmdPushConstants;
	PFN_vkCmdBeginRenderPass vkCmdBeginRenderPass;
	PFN_vkCmdNextSubpass vkCmdNextSubpass;
	PFN_vkCmdEndRenderPass vkCmdEndRenderPass;
	PFN_vkCmdExecuteCommands vkCmdExecuteCommands;
	PFN_vkBindBufferMemory2 vkBindBufferMemory2;
	PFN_vkBindImageMemory2 vkBindImageMemory2;
	PFN_vkGetDeviceGroupPeerMemoryFeatures vkGetDeviceGroupPeerMemoryFeatures;
	PFN_vkCmdSetDeviceMask vkCmdSetDeviceMask;
	PFN_vkCmdDispatchBase vkCmdDispatchBase;
	PFN_vkGetImageMemoryRequirements2 vkGetImageMemoryRequirements2;
	PFN_vkGetBufferMemoryRequirements2 vkGetBufferMemoryRequirements2;
	PFN_vkGetImageSparseMemoryRequirements2 vkGetImageSparseMemoryRequirements2;
	PFN_vkTrimCommandPool vkTrimCommandPool;
	PFN_vkGetDeviceQueue2 vkGetDeviceQueue2;
	PFN_vkCreateSamplerYcbcrConversion vkCreateSamplerYcbcrConversion;
	PFN_vkDestroySamplerYcbcrConversion vkDestroySamplerYcbcrConversion;
	PFN_vkCreateDescriptorUpdateTemplate vkCreateDescriptorUpdateTemplate;
	PFN_vkDestroyDescriptorUpdateTemplate vkDestroyDescriptorUpdateTemplate;
	PFN_vkUpdateDescriptorSetWithTemplate vkUpdateDescriptorSetWithTemplate;
	PFN_vkGetDescriptorSetLayoutSupport vkGetDescriptorSetLayoutSupport;
	PFN_vkCmdDrawIndirectCount vkCmdDrawIndirectCount;
	PFN_vkCmdDrawIndexedIndirectCount vkCmdDrawIndexedIndirectCount;
	PFN_vkCreateRenderPass2 vkCreateRenderPass2;
	PFN_vkCmdBeginRenderPass2 vkCmdBeginRenderPass2;
	PFN_vkCmdNextSubpass2 vkCmdNextSubpass2;
	PFN_vkCmdEndRenderPass2 vkCmdEndRenderPass2;
	PFN_vkResetQueryPool vkResetQueryPool;
	PFN_vkGetSemaphoreCounterValue vkGetSemaphoreCounterValue;
	PFN_vkWaitSemaphores vkWaitSemaphores;
	PFN_vkSignalSemaphore vkSignalSemaphore;
	PFN_vkGetBufferDeviceAddress vkGetBufferDeviceAddress;
	PFN_vkGetBufferOpaqueCaptureAddress vkGetBufferOpaqueCaptureAddress;
	PFN_vkGetDeviceMemoryOpaqueCaptureAddress vkGetDeviceMemoryOpaqueCaptureAddress;
	PFN_vkCreatePrivateDataSlot vkCreatePrivateDataSlot;
	PFN_vkDestroyPrivateDataSlot vkDestroyPrivateDataSlot;
	PFN_vkSetPrivateData vkSetPrivateData;
	PFN_vkGetPrivateData vkGetPrivateData;
	PFN_vkCmdSetEvent2 vkCmdSetEvent2;
	PFN_vkCmdResetEvent2 vkCmdResetEvent2;
	PFN_vkCmdWaitEvents2 vkCmdWaitEvents2;
	PFN_vkCmdPipelineBarrier2 vkCmdPipelineBarrier2;
	PFN_vkCmdWriteTimestamp2 vkCmdWriteTimestamp2;
	PFN_vkQueueSubmit2 vkQueueSubmit2;
	PFN_vkCmdCopyBuffer2 vkCmdCopyBuffer2;
	PFN_vkCmdCopyImage2 vkCmdCopyImage2;
	PFN_vkCmdCopyBufferToImage2 vkCmdCopyBufferToImage2;
	PFN_vkCmdCopyImageToBuffer2 vkCmdCopyImageToBuffer2;
	PFN_vkCmdBlitImage2 vkCmdBlitImage2;
	PFN_vkCmdResolveImage2 vkCmdResolveImage2;
	PFN_vkCmdBeginRendering vkCmdBeginRendering;
	PFN_vkCmdEndRendering vkCmdEndRendering;
	PFN_vkCmdSetCullMode vkCmdSetCullMode;
	PFN_vkCmdSetFrontFace vkCmdSetFrontFace;
	PFN_vkCmdSetPrimitiveTopology vkCmdSetPrimitiveTopology;
	PFN_vkCmdSetViewportWithCount vkCmdSetViewportWithCount;
	PFN_vkCmdSetScissorWithCount vkCmdSetScissorWithCount;
	PFN_vkCmdBindVertexBuffers2 vkCmdBindVertexBuffers2;
	PFN_vkCmdSetDepthTestEnable vkCmdSetDepthTestEnable;
	PFN_vkCmdSetDepthWriteEnable vkCmdSetDepthWriteEnable;
	PFN_vkCmdSetDepthCompareOp vkCmdSetDepthCompareOp;
	PFN_vkCmdSetDepthBoundsTestEnable vkCmdSetDepthBoundsTestEnable;
	PFN_vkCmdSetStencilTestEnable vkCmdSetStencilTestEnable;
	PFN_vkCmdSetStencilOp vkCmdSetStencilOp;
	PFN_vkCmdSetRasterizerDiscardEnable vkCmdSetRasterizerDiscardEnable;
	PFN_vkCmdSetDepthBiasEnable vkCmdSetDepthBiasEnable;
	PFN_vkCmdSetPrimitiveRestartEnable vkCmdSetPrimitiveRestartEnable;
	PFN_vkGetDeviceBufferMemoryRequirements vkGetDeviceBufferMemoryRequirements;
	PFN_vkGetDeviceImageMemoryRequirements vkGetDeviceImageMemoryRequirements;
	PFN_vkGetDeviceImageSparseMemoryRequirements vkGetDeviceImageSparseMemoryRequirements;
	PFN_vkCreateSwapchainKHR vkCreateSwapchainKHR;
	PFN_vkDestroySwapchainKHR vkDestroySwapchainKHR;
	PFN_vkGetSwapchainImagesKHR vkGetSwapchainImagesKHR;
	PFN_vkAcquireNextImageKHR vkAcquireNextImageKHR;
	PFN_vkQueuePresentKHR vkQueuePresentKHR;
	PFN_vkGetDeviceGroupPresentCapabilitiesKHR vkGetDeviceGroupPresentCapabilitiesKHR;
	PFN_vkGetDeviceGroupSurfacePresentModesKHR vkGetDeviceGroupSurfacePresentModesKHR;
	PFN_vkAcquireNextImage2KHR vkAcquireNextImage2KHR;
	PFN_vkSetDebugUtilsObjectNameEXT vkSetDebugUtilsObjectNameEXT;
	PFN_vkSetDebugUtilsObjectTagEXT vkSetDebugUtilsObjectTagEXT;
	PFN_vkQueueBeginDebugUtilsLabelEXT vkQueueBeginDebugUtilsLabelEXT;
	PFN_vkQueueEndDebugUtilsLabelEXT vkQueueEndDebugUtilsLabelEXT;
	PFN_vkQueueInsertDebugUtilsLabelEXT vkQueueInsertDebugUtilsLabelEXT;
	PFN_vkCmdBeginDebugUtilsLabelEXT vkCmdBeginDebugUtilsLabelEXT;
	PFN_vkCmdEndDebugUtilsLabelEXT vkCmdEndDebugUtilsLabelEXT;
	PFN_vkCmdInsertDebugUtilsLabelEXT vkCmdInsertDebugUtilsLabelEXT;
}

// Derelict loader to acquire entry point vkGetInstanceProcAddr
version( ERUPTED_FROM_DERELICT ) {
	import derelict.util.loader;
	import derelict.util.system;

	private {
		version( Windows )
			enum libNames = "vulkan-1.dll";

		else version( Posix )
			enum libNames = "libvulkan.so.1";

		else
			static assert( 0,"Need to implement Vulkan libNames for this operating system." );
	}

	class DerelictEruptedLoader : SharedLibLoader {
		this() {
			super( libNames );
		}

		protected override void loadSymbols() {
			typeof( vkGetInstanceProcAddr ) getProcAddr;
			bindFunc( cast( void** )&getProcAddr, "vkGetInstanceProcAddr" );
			loadGlobalLevelFunctions( getProcAddr );
		}
	}

	__gshared DerelictEruptedLoader DerelictErupted;

	shared static this() {
		DerelictErupted = new DerelictEruptedLoader();
	}
}


