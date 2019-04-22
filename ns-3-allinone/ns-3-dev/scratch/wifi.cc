#include "ns3/wifi-module.h"
#include "ns3/mobility-module.h"
#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/internet-module.h"
#include "ns3/applications-module.h"


using namespace ns3;

NS_LOG_COMPONENT_DEFINE("WIFI-network");

int main (int argc, char *argv[]) {
CommandLine cmd;
cmd.Parse (argc, argv);

NodeContainer aps;
aps.Create(1);

NodeContainer stas;
stas.Create(2);

YansWifiChannelHelper channel = YansWifiChannelHelper::Default();
YansWifiPhyHelper phy = YansWifiPhyHelper::Default();
phy.SetChannel(channel.Create());

WifiMacHelper mac;

Ssid ssid = Ssid("mason");

WifiHelper wifi;

mac.SetType("ns3::ApWifiMac","Ssid",SsidValue(ssid));

NetDeviceContainer apdevs;
apdevs = wifi.Install(phy,mac,aps);

mac.SetType("ns3::StaWifiMac","Ssid",SsidValue(ssid),"ActiveProbing",BooleanValue(false));

NetDeviceContainer stadevs;
stadevs = wifi.Install(phy,mac,stas);

MobilityHelper mobility;
mobility.SetMobilityModel("ns3::ConstantPositionMobilityModel");
mobility.Install(aps);
mobility.Install(stas);

InternetStackHelper tcpip;
tcpip.Install (stas);

Ipv4AddressHelper net_address;
net_address.SetBase ("10.1.1.0", "255.255.255.0");


Ipv4InterfaceContainer host_addrresses;
host_addrresses = net_address.Assign (stadevs);

UdpEchoServerHelper echoServer(9);

ApplicationContainer serverApps = echoServer.Install (stas.Get(1));
serverApps.Start (Seconds(1.0));
serverApps.Stop (Seconds(10.0));

UdpEchoClientHelper echoClient (host_addrresses.GetAddress(1), 9);
echoClient.SetAttribute ("MaxPackets", UintegerValue(1));
echoClient.SetAttribute("Interval", TimeValue(Seconds (1.0)));
echoClient.SetAttribute ("PacketSize", UintegerValue(1024));

ApplicationContainer clientApps = echoClient.Install(stas.Get(0));
clientApps.Start (Seconds (2.0));
clientApps.Stop (Seconds (10.0));

LogComponentEnable("UdpEchoClientApplication", LOG_LEVEL_INFO);
LogComponentEnable("UdpEchoServerApplication", LOG_LEVEL_INFO);
phy.EnablePcapAll("mytracewifi");


Simulator::Stop (Seconds (10));
Simulator::Run();
Simulator::Destroy();
return 0;

}