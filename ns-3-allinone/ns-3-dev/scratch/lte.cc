
#include "ns3/wifi-module.h"
#include "ns3/mobility-module.h"
#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/internet-module.h"
#include "ns3/applications-module.h"
#include "ns3/lte-module.h"


using namespace ns3;

NS_LOG_COMPONENT_DEFINE("WIFI-network");

int main (int argc, char *argv[]) {
CommandLine cmd;
cmd.Parse (argc, argv);

Ptr<LteHelper> ltehelper = CreateObject<LteHelper>();
Ptr<PointToPointEpcHelper> epchelper = CreateObject<PointToPointEpcHelper> ();
ltehelper->SetEpcHelper(epchelper);

NodeContainer enbs;
NodeContainer ues;
enbs.Create(1);
ues.Create(2);

MobilityHelper mobility;
mobility.SetMobilityModel("ns3::ConstantPositionMobilityModel");
mobility.Install(enbs);
mobility.Install(ues);


NetDeviceContainer enbsdev;
NetDeviceContainer uesdev;
enbsdev = ltehelper->InstallEnbDevice(enbs);
uesdev = ltehelper->InstallUeDevice(ues);


InternetStackHelper tcpip;
tcpip.Install(ues);


Ipv4InterfaceContainer ueIpaddrs;
ueIpaddrs = epchelper->AssignUeIpv4Address(uesdev);

ltehelper->Attach(uesdev,enbsdev.Get(0));


UdpEchoServerHelper echoServer(9);

ApplicationContainer serverApps = echoServer.Install (ues.Get(0));
serverApps.Start (Seconds(1.0));
serverApps.Stop (Seconds(10.0));

UdpEchoClientHelper echoClient (ueIpaddrs.GetAddress(0), 9);
echoClient.SetAttribute ("MaxPackets", UintegerValue(1));
echoClient.SetAttribute("Interval", TimeValue(Seconds (1.0)));
echoClient.SetAttribute ("PacketSize", UintegerValue(1024));

ApplicationContainer clientApps = echoClient.Install(ues.Get(1));
clientApps.Start (Seconds (2.0));
clientApps.Stop (Seconds (10.0));

LogComponentEnable("UdpEchoClientApplication", LOG_LEVEL_INFO);
LogComponentEnable("UdpEchoServerApplication", LOG_LEVEL_INFO);
//phy.EnablePcapAll("mytracewifi");


Simulator::Stop (Seconds (10));
Simulator::Run();
Simulator::Destroy();
return 0;

}