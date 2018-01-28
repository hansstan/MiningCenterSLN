using MiningCenterWebApp.Models;

namespace MiningCenterWebApp.SignalR
{
    public interface IMiningHub
    {
        // Define all functions, which are provided on client side (in Javascript)
        void PingToClient(string sender, string msg);                  // must be implemented in camelCase notation in Javascript
        void SendDataToMiningCenter(MiningData miningData);   // must be implemented in camelCase notation in Javascript
    }
}
