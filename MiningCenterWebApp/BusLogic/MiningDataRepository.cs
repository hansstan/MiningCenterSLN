using MiningCenterWebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MiningCenterWebApp.BusLogic
{
    public class MiningDataRepository
    {
        public MiningData GetMiningDataFromRepository(string sender)
        {
            try
            {
                HttpContext.Current.Application.Lock(); // BAD for performance, do never use in real world!
                int eventACounter = (int)HttpContext.Current.Application["EventA"];
                int eventBCounter = (int)HttpContext.Current.Application["EventB"];
                int eventCCounter = (int)HttpContext.Current.Application["EventC"];
                int eventDCounter = (int)HttpContext.Current.Application["EventD"];
                //switch (id)
                //{
                //    case 1:
                //        eventACounter++;
                //        break;
                //    case 2:
                //        eventBCounter++;
                //        break;
                //    case 3:
                //        eventCCounter++;
                //        break;
                //    case 4:
                //        eventDCounter++;
                //        break;
                //}
                HttpContext.Current.Application["EventA"] = eventACounter;
                HttpContext.Current.Application["EventB"] = eventBCounter;
                HttpContext.Current.Application["EventC"] = eventCCounter;
                HttpContext.Current.Application["EventD"] = eventDCounter;

                var miningData = new MiningData()
                {
                    //Sender = id.ToString(),
                    //Timestamp = DateTime.UtcNow.ToString("HH:mm:ss"),
                    //EventACount = eventACounter,
                    //EventBCount = eventBCounter,
                    //EventCCount = eventCCounter,
                    //EventDCount = eventDCounter,
                };
                return miningData;
            }
            catch (Exception ex)
            {
            }
            finally
            {
                HttpContext.Current.Application.UnLock();
            }
            return null;
        }

        public MiningData HandleNewMiningData(MiningData miningData)
        {
            //var miningData = new MiningDataRepository().GetMiningDataFromRepository(miningData.Sender);
            //if (miningData != null)
            //{
            //    SignalRManager.TriggerSendData(miningData);
            //}
            return miningData;
        }
    }
}