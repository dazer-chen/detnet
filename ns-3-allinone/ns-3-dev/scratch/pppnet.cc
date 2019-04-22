#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/internet-module.h"
#include "ns3/applications-module.h"

using namespace ns3;

NS_LOG_COMPONENT_DEFINE("PPP-network");

int main (int argc, char *argv[]) {
CommandLine cmd;
cmd.Parse (argc, argv);

NodeContainer nodes;
nodes.Create(2);

PointToPointHelper ppplink;
ppplink.SetDeviceAttribute("DataRate", StringValue("1Mbps"));
ppplink.SetChannelAttribute("Delay", StringValue("10ms"));

NetDeviceContainer devices;
devices = ppplink.Install (nodes);

InternetStackHelper tcpip;
tcpip.Install (nodes);

Ipv4AddressHelper net_address;
net_address.SetBase ("10.1.1.0", "255.255.255.0");


Ipv4InterfaceContainer host_addrresses;
host_addrresses = net_address.Assign (devices);

UdpEchoServerHelper echoServer(9);

ApplicationContainer serverApps = echoServer.Install (nodes.Get(1));
serverApps.Start (Seconds(1.0));
serverApps.Stop (Seconds(10.0));

UdpEchoClientHelper echoClient (host_addrresses.GetAddress(1), 9);
echoClient.SetAttribute ("MaxPackets", UintegerValue(1));
echoClient.SetAttribute("Interval", TimeValue(Seconds (1.0)));
echoClient.SetAttribute ("PacketSize", UintegerValue(1024));

ApplicationContainer clientApps = echoClient.Install(nodes.Get(0));
clientApps.Start (Seconds (2.0));
clientApps.Stop (Seconds (10.0));

LogComponentEnable("UdpEchoClientApplication", LOG_LEVEL_INFO);
LogComponentEnable("UdpEchoServerApplication", LOG_LEVEL_INFO);
ppplink.EnablePcapAll("mytraceppp");


Simulator::Stop (Seconds (10));
Simulator::Run();
Simulator::Destroy();
return 0;

}