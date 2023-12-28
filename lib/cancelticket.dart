import 'package:flutter/material.dart';
import 'homepage.dart';
import 'global.dart';
import 'dart:async';

class cancelticketScreen extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  cancelticketScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.lightBlueAccent, width: 5.0),
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.green[200], // Header background color
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 09.0),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CANCEL TICKET',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(01,2,1,0),
              scrollDirection: Axis.horizontal,
              child: DataTable(
                border: TableBorder.all(
                  width: 1.0,
                  color: Colors.black,
                ),
                columns: const [
                  DataColumn(label: Text('Ticket ID')),
                  DataColumn(label: Text('Draw Time')),
                  DataColumn(label: Text('Bet Total')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Ticket View')), // New column for "Action"
                ],
                rows: data.map((item) {
                  final status = item['status'] != null ? item['status'].toString() : '';

                  return DataRow(cells: [
                    DataCell(Text(item['ticketId'].toString())),
                    DataCell(Text(item['drawTime'].toString())),
                    DataCell(Text(item['betTotal'].toString())),
                    DataCell(
                      Row(
                        children: [
                          Text(status),
                          ElevatedButton(
                            onPressed: () {
                              socket.emit('cancelThisTkt', {
                                "ticketId": item['ticketId'].toString(),
                                "userId": userId,
                                "amount": item['betTotal'].toString(),
                              });
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      // Add your view button or widget here
                      ElevatedButton(
                        onPressed: () {
                          // Handle the action fitem['betTotal']or "View"
                          socket.emit('getticketdata',item['ticketId'].toString());
                        },
                        child: const Text('View'),
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                cancelPopup = false;
                Navigator.pop(context); // Close the modal
              },
              child: const Center(
                child: Text('Close'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

