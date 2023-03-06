//
//  SetupPayload-Swift.h
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

#import <setup_payload/SetupPayload.h>

using MatterSetupPayload = ::chip::SetupPayload;

static inline MatterSetupPayload MatterSetupPayloadCreate()
//__attribute__((swift_name("MatterSetupPayload.init()")))
{
    ::chip::SetupPayload payload;
    return payload;
}

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

static inline uint16_t MatterSetupPayloadGetVendorID(chip::SetupPayload payload)
__attribute__((swift_name("getter:MatterSetupPayload.vendorID(self:)")))
{
    return payload.vendorID;
}

static inline void MatterSetupPayloadSetVendorID(chip::SetupPayload* payload, uint16_t vendorID)
__attribute__((swift_name("setter:MatterSetupPayload.vendorID(self:_:)")))
{
    payload->vendorID = vendorID;
}

static inline uint16_t MatterSetupPayloadGetProductID(chip::SetupPayload payload)
__attribute__((swift_name("getter:MatterSetupPayload.productID(self:)")))
{
    return payload.productID;
}

static inline void MatterSetupPayloadSetProductID(chip::SetupPayload* payload, uint16_t productID)
__attribute__((swift_name("setter:MatterSetupPayload.productID(self:_:)")))
{
    payload->productID = productID;
}

static inline chip::CommissioningFlow MatterSetupPayloadGetCommissioningFlow(chip::SetupPayload payload)
__attribute__((swift_name("getter:MatterSetupPayload.commissioningFlow(self:)")))
{
    return payload.commissioningFlow;
}

static inline void MatterSetupPayloadSetCommissioningFlow(chip::SetupPayload* payload, chip::CommissioningFlow commissioningFlow)
__attribute__((swift_name("setter:MatterSetupPayload.commissioningFlow(self:_:)")))
{
    payload->commissioningFlow = commissioningFlow;
}

static inline chip::Optional<chip::RendezvousInformationFlags> MatterSetupPayloadGetRendezvousInformation(chip::SetupPayload payload)
__attribute__((swift_name("getter:MatterSetupPayload.rendezvousInformation(self:)")))
{
    return payload.rendezvousInformation;
}

static inline void MatterSetupPayloadSetRendezvousInformation(chip::SetupPayload* payload, chip::Optional<chip::RendezvousInformationFlags> rendezvousInformation)
__attribute__((swift_name("setter:MatterSetupPayload.rendezvousInformation(self:_:)")))
{
    payload->rendezvousInformation = rendezvousInformation;
}

static inline chip::SetupDiscriminator MatterSetupPayloadGetDiscriminator(chip::SetupPayload payload)
__attribute__((swift_name("getter:MatterSetupPayload.discriminator(self:)")))
{
    return payload.discriminator;
}

static inline void MatterSetupPayloadSetDiscriminator(chip::SetupPayload* payload, chip::SetupDiscriminator discriminator)
__attribute__((swift_name("setter:MatterSetupPayload.discriminator(self:_:)")))
{
    payload->discriminator = discriminator;
}

static inline uint32_t MatterSetupPayloadGetSetupPinCode(chip::SetupPayload payload)
__attribute__((swift_name("getter:MatterSetupPayload.setupPinCode(self:)")))
{
    return payload.setUpPINCode;
}

static inline void MatterSetupPayloadSetSetupPinCode(chip::SetupPayload* payload, uint32_t setUpPINCode)
__attribute__((swift_name("setter:MatterSetupPayload.setupPinCode(self:_:)")))
{
    payload->setUpPINCode = setUpPINCode;
}

static inline bool MatterSetupPayloadIsValidQRCodePayload(chip::SetupPayload payload)
__attribute__((swift_name("getter:MatterSetupPayload.isValidQRCodePayload(self:)")))
{
    return payload.isValidQRCodePayload();
}

static inline bool MatterSetupPayloadIsValidManualCode(chip::SetupPayload payload)
__attribute__((swift_name("getter:MatterSetupPayload.isValidManualCode(self:)")))
{
    return payload.isValidManualCode();
}
