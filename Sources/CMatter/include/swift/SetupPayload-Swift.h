//
//  SetupPayload-Swift.h
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

#import <setup_payload/SetupPayload.h>

using MatterSetupPayload = ::chip::SetupPayload;

static inline bool MatterSetupPayloadIsEqual(chip::SetupPayload payload, chip::SetupPayload other)
__attribute__((swift_name("MatterSetupPayload.isEqual(self:_:)")))
{
    return payload == other;
}

static inline uint8_t MatterSetupPayloadGetVersion(chip::SetupPayload payload)
__attribute__((swift_name("getter:MatterSetupPayload.version(self:)")))
{
    return payload.version;
}

static inline void MatterSetupPayloadSetVersion(chip::SetupPayload* payload, uint8_t version)
__attribute__((swift_name("setter:MatterSetupPayload.version(self:_:)")))
{
    payload->version = version;
}
