import 'package:flutter/material.dart';
import 'global.dart'; // Import the intl package for date formatting

import 'package:intl/intl.dart';

import 'dart:async';

// void main() {
//   runApp(usertickets());
// }



class UserTicketScreen extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final String? selectedRadio;


  UserTicketScreen({required this.data, required this.selectedRadio});

  @override
  _UserTicketScreenState createState() => _UserTicketScreenState();
}

class _UserTicketScreenState extends State<UserTicketScreen> {
  DateTime? _selectedDate;
  String? selectedRadio;
  bool isBottomSheetOpen = false;

  @override
  void initState() {
    super.initState();
  }

  void handleSubmitButtonClicked(String selectedDate, String selectedRadio) {
    // You can perform actions with the selectedDate and selectedRadio parameters here

    socket.emit('getUserTickets', {
      'username': '$urname',
      'type': selectedRadio, // Set 'type' to 'won'
      'date': selectedDate,   // Use the formattedDate
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.lightBlueAccent, width: 5.0),
        color: Colors.transparent,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.green[200], // Header background color
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 08.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text('Select Date:'),
                          SizedBox(width: 10.0),
                          ElevatedButton(
                            onPressed: () async {
                              final DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (selectedDate != null) {
                                // Handle date selection here
                                setState(() {
                                  _selectedDate = selectedDate;
                                });
                              }
                            },
                            child: Text(
                              _selectedDate != null
                                  ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                                  : 'Select Date',
                            ),
                          ),
                        ],
                      ),
                      Radio(
                        value: "Won",
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          // Handle radio button selection
                          setState(() {
                            selectedRadio = value;
                          });
                        },
                      ),
                      Text("Won"),
                      Radio(
                        value: "All",
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          // Handle radio button selection
                          setState(() {
                            selectedRadio = value;
                          });
                        },
                      ),
                      Text("All"),
                      SizedBox(height: 10.0, width: 80,), // Add spacing between elements
                      // Submit Button
                      ElevatedButton(
                        onPressed: () {

                          final String selectedDateStr = _selectedDate != null
                              ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                              : '';

                          // Access selected radio value using selectedRadio
                          final String radioValue = selectedRadio ?? '';

                          // Call the submit function and pass the parameters
                          handleSubmitButtonClicked(selectedDateStr, radioValue);
                          Navigator.of(context).pop();
                          isBottomSheetOpen = false;
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
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
                    DataColumn(label: Text('Action')),
                    DataColumn(label: Text('Ticket View')), // New column for "View"
                  ],
                  rows: widget.data.map((item) {
                    String claimStatusString = item['claimStatus'].toString().toLowerCase();
                    bool claimStatus = claimStatusString == 'true';

                    return DataRow(cells: [
                      DataCell(Text(item['ticketId'].toString())),
                      DataCell(Text(item['drawTime'].toString())),
                      DataCell(Text(item['betTotal'].toString())),
                      DataCell(
                        claimStatus
                            ? ElevatedButton(
                          onPressed: () {
                            // Handle the action for "Already Claimed"
                          },
                          child: Text('Already Claimed'),
                        )
                            : ElevatedButton(
                          onPressed: () {
                            var ur = username;
                            socket.emit('claimTicket', {
                              "ticketId": item['ticketId'].toString(),
                              "username": urname,
                            });
                          },
                          child: Text('Claim'),
                        ),
                      ),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            socket.emit('getticketdata',item['ticketId'].toString());
                          },
                          child: Text('View'),
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
                  Navigator.pop(context);
                },
                child: const Center(
                  child: Text('Close'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
