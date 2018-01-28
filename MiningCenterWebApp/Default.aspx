<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MiningCenterWebApp.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        .Header {
             font-size: 32px;
             align-content: left;
             background-color: silver;
            color: white;
        }
        td {
             font-size: 32px;
             align-content: left;
             background-color: orange;
         }
         .bar {
             font-size: 32px;
             background-color: greenyellow;
         }
    </style>
    <title>Mining Center WebApp</title>
    <script src="Scripts/jquery-3.3.1.js"></script>
    <script src="Scripts/jquery.signalR-2.2.2.js"></script>
    <script src="signalr/hubs"></script>

<script type="text/javascript">
    $(document).ready(function ()
    {
        var minerClientsArray = [];
        var miningHub = $.connection.miningHub;

        // Ping data arrives here
        miningHub.client.pingToClient = function (sender, msg)
        {
            var lblLastPing = $('#lblLastPing');
            lblLastPing.text("Ping from" + sender + " : " + msg + " at: " + new Date().toLocaleTimeString());
        };

        /// MiningData from Clients arrives here
        miningHub.client.sendDataToMiningCenter = function (miningData)
        {
            var updated = false;
            {
                for (var i = 0; i < minerClientsArray.length; i++)
                {
                    if (minerClientsArray[i].Sender == miningData.Sender)
                    {
                        minerClientsArray[i].Timestamp = miningData.Timestamp;
                        minerClientsArray[i].CrunchesPerSecond = miningData.CrunchesPerSecond;
                        updated = true;
                        continue;
                    }
                }
                if (updated == false)
                {
                    minerClientsArray.push(miningData);
                }
            }
            minerClientsArray.sort();

            $("#minerClientTable tbody tr").remove();
            var tbody = $('#minerClientTable tbody'),
                props = ["Sender", "Timestamp", "CrunchesPerSecond"];
            $.each(minerClientsArray, function (i, minerClient) {
                var tr = $('<tr>');
                $.each(props, function (i, prop)
                {
                    if (prop == "CrunchesPerSecond")
                    {
                        $('<td><div style="width:' + minerClient[prop] + '%" class="bar">' + minerClient[prop] + '</div></td>').appendTo(tr);
                    }
                    else {
                        $('<td>').html(minerClient[prop]).appendTo(tr);
                    }
                });
                tbody.append(tr);
            });

        };

        // Init Hub
        $.connection.hub.start()
            .done(function ()
            {
                $('#btnSendPing') // Diagnose SignalR functionality
                    .click(function ()
                    {
                        miningHub.server.pingToServer("MiningCenter WebApp", "Are you alive?");
                    });

                $('#btnSendMiningDataDummy') // Diagnose SignalR functionality
                    .click(function ()
                    {
                        
                        var dummyMiningData =
                            {
                                Sender: new Date().getSeconds(),
                                CrunchesPerSecond: new Date().getSeconds()
                            };
                        miningHub.server.sendDataToMiningCenter(dummyMiningData);
                    });
            });
    });
</script>
</head>

<body>
    <form id="form1" runat="server">
        <h1>Mining Center WebApp</h1>
        Last Ping: <div id="lblLastPing">...</div><br />
        <input type="button" id="btnSendPing" value="Send Ping"/><br />
        <input type="button" id="btnSendMiningDataDummy" value="Send Mining Data"/>
        <div id="statusMessage"></div>
        <hr />
        <ul id="messageList">
        </ul>

        <table id="minerClientTable" width="100%">
            <thead>
                <tr>
                    <th style="align-content:center"><div id="divHeaderA" class="Header">Sender</div></th>
                    <th style="align-content:center"><div id="divHeaderB" class="Header">TimeStamp</div></th>
                    <th style="align-content:center"><div id="divHeaderC" class="Header">CrunchesPerSecond</div></th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>

    </form>
</body>
</html>
