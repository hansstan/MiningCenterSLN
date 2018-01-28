using Microsoft.AspNet.SignalR;
using MiningCenterWebApp.BusLogic;
using MiningCenterWebApp.Models;
using System;
using System.Diagnostics;

namespace MiningCenterWebApp.SignalR
{
    public class MiningHub : Hub<IMiningHub>
    {
        public void PingToServer(string sender, string msg)
        {
            Debug.WriteLine($"PingToServer({msg}...");

            Clients.All.PingToClient(sender, msg); // defined in Interface => define camelCased in Javascript on the client
        }

        public void SendDataToMiningCenter(MiningData miningData)
        {
            Clients.All.SendDataToMiningCenter(miningData); // defined in Interface => define camelCased in Javascript on the client

            //    Debug.WriteLine($"SendDataToBank({miningData.Sender}, {miningData.CrunchesPerSecond}");
            //    //            var motionRepos = new MotionDataRepository();
            //    //            var motionData = motionRepos.HandleMotion(id);
            //    //            SignalRManager.TriggerSendData(motionData);
            //    //try
            //    //{
            //    //    Debug.WriteLine($"TriggerSendData({miningData}");
            //    //    var hubContext = GlobalHost.ConnectionManager.GetHubContext<MiningHub>();
            //    //    if (hubContext != null)
            //    //    {
            //    //        hubContext.Clients.All.SendDataToMiningCenter(miningData);
            //    //    }
            //    //}
            //    //catch (Exception ex)
            //    //{
            //    //    LogiT
            //    //}
        }
    }
}
