import 'package:socket_io_client/socket_io_client.dart' as IO;

 var socket = IO.io('http://103.154.233.247:3333', <String, dynamic>{
'transports': ['websocket'],
'autoConnect': true,
});
 var urname ,aId,mId,dId,balance,userId,drawTime,currentBetTIme,cancelPopup = false ,smallCancelBox = false;
String username = "";
List<int> betArray = List.filled(13, 0);
var advanecDrawArray = [];
var lastCancelTkt;

