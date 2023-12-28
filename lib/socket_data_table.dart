import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'global.dart';
class SocketDataTable extends StatefulWidget {
  final IO.Socket socket;

  SocketDataTable({required this.socket});

  @override
  _SocketDataTableState createState() => _SocketDataTableState();
}

class _SocketDataTableState extends State<SocketDataTable> {
  List<TicketData> ticketDataList = [];

  @override
  void initState() {
    super.initState();

    widget.socket.onConnect((_) {
      print('Connected to socket');
    });

    widget.socket.on('getCancelDataReply', (data) {
      final jsonData = data as List<dynamic>;
      List<TicketData> dataList = jsonData.map<TicketData>((json) => TicketData.fromJson(json)).toList();

      setState(() {
        ticketDataList = dataList;
      });
    });

    widget.socket.onDisconnect((_) {
      print('Disconnected from socket');
    });

    widget.socket.connect();
  }

  @override
  void dispose() {
    widget.socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DataTable(
            columns: [
              DataColumn(label: Text('Ticket ID')),
              DataColumn(label: Text('Draw Time')),
              DataColumn(label: Text('Total Bet')),
              DataColumn(label: Text('Status')),
            ],
            rows: ticketDataList.map((ticketData) {
              return DataRow(cells: [
                DataCell(Text(ticketData.ticketId.toString())),
                DataCell(Text(ticketData.drawTime)),
                DataCell(Text('\$${ticketData.totalBet.toString()}')),
                DataCell(Text(ticketData.status)),
              ]);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class TicketData {
  final int ticketId;
  final String drawTime;
  final int totalBet;
  final String status;

  TicketData(this.ticketId, this.drawTime, this.totalBet, this.status);

  factory TicketData.fromJson(Map<String, dynamic> json) {
    return TicketData(
      json['ticketId'] as int,
      json['drawTime'] as String,
      json['totalBet'] as int,
      json['status'] as String,
    );
  }
}
