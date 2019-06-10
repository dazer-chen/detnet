import os
import plotly.plotly as py
import plotly

import urllib, json
detnet_flow=['rgba(0, 39, 102, 0.3)','rgba(0, 39, 102, 0.35)','rgba(0, 39, 102, 0.40)','rgba(0, 39, 102, 0.45)','rgba(0, 39, 102, 0.5)','rgba(0, 39, 102, 0.6)','rgba(0, 39, 102, 0.7)','rgba(0, 39, 102, 0.8)','rgba(0, 39, 102, 0.9)','rgba(0, 39, 102, 1)']
other_flow=['rgba(204, 0, 0, 0.6)','rgba(204, 0, 0, 0.7)']
data = dict(
    type='sankey',
    node = dict(
      pad = 15,
      thickness = 20,
      line = dict(
        color = "black",
        width = 0.5
      ),
      #label = ["detnet-1", "detnet-2", "detnet-3", "detnet-4", "detnet-5", "detnet-6", "detnet-7", "detnet-8", "detnet-9", "detnet-10", "detnet-11", "detnet-12", "other-1", "other-2"],
      
      label = ["traffic-generator", "router", "sink", "drop"],
      color = ['rgba(0, 20, 51, 0.75)', 'rgba(0, 20, 51, 0.75)','rgba(0, 20, 51, 0.75)','rgba(0, 20, 51, 0.75)',]
      
    ),
    link = dict(
      source = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
      target = [1,1,1,1,1,1,1,1,1,1,1,1,3,3,2,2,2,2,2,2,2,2,2,2,2,2,3,3],
      value = [1,2,3,4,5,6,7,8,9,10,50,50,10,10,1,2,3,4,5,6,7,8,9,10,20,20,30,30],
      color = [detnet_flow[0],detnet_flow[1],detnet_flow[2],detnet_flow[3],detnet_flow[4],detnet_flow[5],detnet_flow[6],detnet_flow[7],detnet_flow[8],detnet_flow[9],other_flow[0],other_flow[1],other_flow[0],other_flow[1],detnet_flow[0],detnet_flow[1],detnet_flow[2],detnet_flow[3],detnet_flow[4],detnet_flow[5],detnet_flow[6],detnet_flow[7],detnet_flow[8],detnet_flow[9],other_flow[0],other_flow[1],other_flow[0],other_flow[1]],
      label = ["detnet-1","detnet-2","detnet-3","detnet-4","detnet-5","detnet-6","detnet-7","detnet-8","detnet-9","detnet-10","other-2","other-2"],
  ))

layout =  dict(
    title = "Basic Sankey Diagram",
    font = dict(
      size = 10
    )
)

fig = dict(data=[data], layout=layout)
plotly.offline.plot(fig, validate=True)
