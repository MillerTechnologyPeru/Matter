/*
 *
 *    Copyright (c) 2020 Project CHIP Authors
 *    Copyright (c) 2018 Nest Labs, Inc.
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */

/**
 *    @file
 *          Provides an implementation of the PlatformManager object
 *          for Linux platforms.
 */

#include <platform/internal/CHIPDeviceLayerInternal.h>

#if !CHIP_DISABLE_PLATFORM_KVS
#include <platform/Linux/DeviceInstanceInfoProviderImpl.h>
#include <platform/DeviceInstanceInfoProvider.h>
#endif

#include <platform/Linux/DiagnosticDataProviderImpl.h>
#include <platform/PlatformManager.h>

// Include the non-inline definitions for the GenericPlatformManagerImpl<> template,
#include <platform/internal/GenericPlatformManagerImpl.ipp>

#include <CoreFoundation/CoreFoundation.h>

namespace chip {
namespace DeviceLayer {

PlatformManagerImpl PlatformManagerImpl::sInstance;

CHIP_ERROR PlatformManagerImpl::_InitChipStack()
{
    CHIP_ERROR err;

    // Initialize the configuration system.
#if !CHIP_DISABLE_PLATFORM_KVS
    err = Internal::PosixConfig::Init();
    SuccessOrExit(err);
#endif // CHIP_DISABLE_PLATFORM_KVS

    // Ensure there is a dispatch queue available
    static_cast<System::LayerSocketsLoop &>(DeviceLayer::SystemLayer()).SetDispatchQueue(GetWorkQueue());

    // Call _InitChipStack() on the generic implementation base class
    // to finish the initialization process.
    err = Internal::GenericPlatformManagerImpl<PlatformManagerImpl>::_InitChipStack();
    SuccessOrExit(err);

#if !CHIP_DISABLE_PLATFORM_KVS
    // Now set up our device instance info provider.  We couldn't do that
    // earlier, because the generic implementation sets a generic one.
    // FIXME: SetDeviceInstanceInfoProvider
    //SetDeviceInstanceInfoProvider(&DeviceInstanceInfoProviderMgrImpl());
#endif // CHIP_DISABLE_PLATFORM_KVS

    mStartTime = System::SystemClock().GetMonotonicTimestamp();

exit:
    return err;
}

CHIP_ERROR PlatformManagerImpl::_StartEventLoopTask()
{
    //CFRunLoopRun();
    return CHIP_NO_ERROR;
};

CHIP_ERROR PlatformManagerImpl::_StopEventLoopTask()
{
    //CFRunLoopStop(CFRunLoopGetMain());
    return CHIP_NO_ERROR;
}

void PlatformManagerImpl::_RunEventLoop()
{
    CFRunLoopRun();
}

void PlatformManagerImpl::_Shutdown()
{
    CFRunLoopStop(CFRunLoopGetMain());
    // Call up to the base class _Shutdown() to perform the bulk of the shutdown.
    GenericPlatformManagerImpl<ImplClass>::_Shutdown();
}

CHIP_ERROR PlatformManagerImpl::_PostEvent(const ChipDeviceEvent * event)
{
    if (mWorkQueue == nullptr)
    {
        return CHIP_ERROR_INCORRECT_STATE;
    }

    const ChipDeviceEvent eventCopy = *event;
    dispatch_async(mWorkQueue, ^{
        Impl()->DispatchEvent(&eventCopy);
    });
    return CHIP_NO_ERROR;
}

#if CHIP_STACK_LOCK_TRACKING_ENABLED
bool PlatformManagerImpl::_IsChipStackLockedByCurrentThread() const
{
    // If we have no work queue, or it's suspended, then we assume our caller
    // knows what they are doing in terms of their own concurrency.
    return !mWorkQueue || mIsWorkQueueSuspended || dispatch_get_current_queue() == mWorkQueue;
};
#endif

CHIP_ERROR PlatformManagerImpl::PrepareCommissioning()
{
    auto error = CHIP_NO_ERROR;
#if CONFIG_NETWORK_LAYER_BLE
    // FIXME: BLE PrepareConnection()
    error = Internal::BLEMgrImpl().PrepareConnection();
#endif // CONFIG_NETWORK_LAYER_BLE
    return error;
}

} // namespace DeviceLayer
} // namespace chip
