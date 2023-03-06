#include <app-common/zap-generated/callback.h>
#include <app-common/zap-generated/ids/Clusters.h>
#include <lib/support/Span.h>
#include <protocols/interaction_model/Constants.h>

using namespace chip;

// Cluster Init Functions
void emberAfClusterInitCallback(EndpointId endpoint, ClusterId clusterId)
{
    switch (clusterId)
    {
    case app::Clusters::AccessControl::Id:
        emberAfAccessControlClusterInitCallback(endpoint);
        break;
    case app::Clusters::Actions::Id:
        emberAfActionsClusterInitCallback(endpoint);
        break;
    case app::Clusters::AdministratorCommissioning::Id:
        emberAfAdministratorCommissioningClusterInitCallback(endpoint);
        break;
    case app::Clusters::ApplicationBasic::Id:
        emberAfApplicationBasicClusterInitCallback(endpoint);
        break;
    case app::Clusters::BasicInformation::Id:
        emberAfBasicInformationClusterInitCallback(endpoint);
        break;
    case app::Clusters::BooleanState::Id:
        emberAfBooleanStateClusterInitCallback(endpoint);
        break;
    case app::Clusters::ColorControl::Id:
        emberAfColorControlClusterInitCallback(endpoint);
        break;
    case app::Clusters::ContentLauncher::Id:
        emberAfContentLauncherClusterInitCallback(endpoint);
        break;
    case app::Clusters::Descriptor::Id:
        emberAfDescriptorClusterInitCallback(endpoint);
        break;
    case app::Clusters::EthernetNetworkDiagnostics::Id:
        emberAfEthernetNetworkDiagnosticsClusterInitCallback(endpoint);
        break;
    case app::Clusters::FixedLabel::Id:
        emberAfFixedLabelClusterInitCallback(endpoint);
        break;
    case app::Clusters::FlowMeasurement::Id:
        emberAfFlowMeasurementClusterInitCallback(endpoint);
        break;
    case app::Clusters::GeneralCommissioning::Id:
        emberAfGeneralCommissioningClusterInitCallback(endpoint);
        break;
    case app::Clusters::GeneralDiagnostics::Id:
        emberAfGeneralDiagnosticsClusterInitCallback(endpoint);
        break;
    case app::Clusters::Groups::Id:
        emberAfGroupsClusterInitCallback(endpoint);
        break;
    case app::Clusters::Identify::Id:
        emberAfIdentifyClusterInitCallback(endpoint);
        break;
    case app::Clusters::IlluminanceMeasurement::Id:
        emberAfIlluminanceMeasurementClusterInitCallback(endpoint);
        break;
    case app::Clusters::KeypadInput::Id:
        emberAfKeypadInputClusterInitCallback(endpoint);
        break;
    case app::Clusters::LevelControl::Id:
        emberAfLevelControlClusterInitCallback(endpoint);
        break;
    case app::Clusters::LocalizationConfiguration::Id:
        emberAfLocalizationConfigurationClusterInitCallback(endpoint);
        break;
    case app::Clusters::ModeSelect::Id:
        emberAfModeSelectClusterInitCallback(endpoint);
        break;
    case app::Clusters::NetworkCommissioning::Id:
        emberAfNetworkCommissioningClusterInitCallback(endpoint);
        break;
    case app::Clusters::OccupancySensing::Id:
        emberAfOccupancySensingClusterInitCallback(endpoint);
        break;
    case app::Clusters::OnOff::Id:
        emberAfOnOffClusterInitCallback(endpoint);
        break;
    case app::Clusters::OperationalCredentials::Id:
        emberAfOperationalCredentialsClusterInitCallback(endpoint);
        break;
    case app::Clusters::PowerSource::Id:
        emberAfPowerSourceClusterInitCallback(endpoint);
        break;
    case app::Clusters::PowerSourceConfiguration::Id:
        emberAfPowerSourceConfigurationClusterInitCallback(endpoint);
        break;
    case app::Clusters::PressureMeasurement::Id:
        emberAfPressureMeasurementClusterInitCallback(endpoint);
        break;
    case app::Clusters::PumpConfigurationAndControl::Id:
        emberAfPumpConfigurationAndControlClusterInitCallback(endpoint);
        break;
    case app::Clusters::RelativeHumidityMeasurement::Id:
        emberAfRelativeHumidityMeasurementClusterInitCallback(endpoint);
        break;
    case app::Clusters::Scenes::Id:
        emberAfScenesClusterInitCallback(endpoint);
        break;
    case app::Clusters::SoftwareDiagnostics::Id:
        emberAfSoftwareDiagnosticsClusterInitCallback(endpoint);
        break;
    case app::Clusters::Switch::Id:
        emberAfSwitchClusterInitCallback(endpoint);
        break;
    case app::Clusters::TargetNavigator::Id:
        emberAfTargetNavigatorClusterInitCallback(endpoint);
        break;
    case app::Clusters::TemperatureMeasurement::Id:
        emberAfTemperatureMeasurementClusterInitCallback(endpoint);
        break;
    case app::Clusters::Thermostat::Id:
        emberAfThermostatClusterInitCallback(endpoint);
        break;
    case app::Clusters::ThermostatUserInterfaceConfiguration::Id:
        emberAfThermostatUserInterfaceConfigurationClusterInitCallback(endpoint);
        break;
    case app::Clusters::TimeFormatLocalization::Id:
        emberAfTimeFormatLocalizationClusterInitCallback(endpoint);
        break;
    case app::Clusters::UnitLocalization::Id:
        emberAfUnitLocalizationClusterInitCallback(endpoint);
        break;
    case app::Clusters::UserLabel::Id:
        emberAfUserLabelClusterInitCallback(endpoint);
        break;
    case app::Clusters::WiFiNetworkDiagnostics::Id:
        emberAfWiFiNetworkDiagnosticsClusterInitCallback(endpoint);
        break;
    case app::Clusters::WindowCovering::Id:
        emberAfWindowCoveringClusterInitCallback(endpoint);
        break;
    default:
        // Unrecognized cluster ID
        break;
    }
}
void __attribute__((weak)) emberAfAccessControlClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfActionsClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfAdministratorCommissioningClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfApplicationBasicClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfBasicInformationClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfBooleanStateClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfColorControlClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfContentLauncherClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfDescriptorClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfEthernetNetworkDiagnosticsClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfFixedLabelClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfFlowMeasurementClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfGeneralCommissioningClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfGeneralDiagnosticsClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfGroupsClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfIdentifyClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfIlluminanceMeasurementClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfKeypadInputClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfLevelControlClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfLocalizationConfigurationClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfModeSelectClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfNetworkCommissioningClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfOccupancySensingClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfOnOffClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfOperationalCredentialsClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfPowerSourceClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfPowerSourceConfigurationClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfPressureMeasurementClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfPumpConfigurationAndControlClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfRelativeHumidityMeasurementClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfScenesClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfSoftwareDiagnosticsClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfSwitchClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfTargetNavigatorClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfTemperatureMeasurementClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfThermostatClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfThermostatUserInterfaceConfigurationClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfTimeFormatLocalizationClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfUnitLocalizationClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfUserLabelClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfWiFiNetworkDiagnosticsClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
void __attribute__((weak)) emberAfWindowCoveringClusterInitCallback(EndpointId endpoint)
{
    // To prevent warning
    (void) endpoint;
}
