/*
 *
 *  Matter
 *
 */

// Definitions
#include <CHIPVersion.h>
#include <app/AppBuildConfig.h>
#include <system/SystemBuildConfig.h>

// Core Types
#include <lib/core/CHIPConfig.h>
#include <lib/core/CHIPError.h>

// BLE
#include <ble/Ble.h>

// Setup Payload
#include <setup_payload/SetupPayload.h>
#include <setup_payload/QRCodeSetupPayloadParser.h>
#include <setup_payload/QRCodeSetupPayloadGenerator.h>
#include <setup_payload/ManualSetupPayloadParser.h>
#include <setup_payload/ManualSetupPayloadGenerator.h>

// Swift helpers
#include <swift/Error-Swift.h>
#include <swift/SetupPayload-Swift.h>

// App
#include <app/App.h>
