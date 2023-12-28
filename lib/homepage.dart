import 'package:dus_kadam/loginpage.dart';
import 'package:dus_kadam/result.dart';
import 'package:dus_kadam/usertickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cancelticket.dart';
import 'global.dart';
import 'package:intl/intl.dart';
import 'socket_data_table.dart';
import 'package:dus_kadam/advancedraw.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  final dateString =  DateTime.now();
  bool isBottomSheetOpen = false;
  bool hasPrintedData = false;
  String formattedDate = "";
  String confirmBet = 'bhaskar';
  int selectedCoinValue = 0;
  String message = '';

  Map<int, int> numbersMap = Map.fromIterable(
    List.generate(12, (index) => index + 1),
    key: (item) => item,
    value: (item) => 0,
  );

  void addCoinValue(int number) {
    if (selectedCoinValue > 0) {
      betArray[number]+= selectedCoinValue;
      setState(() {
        numbersMap[number] = (numbersMap[number] ?? 0) + selectedCoinValue;
      });
    }
  }
  void clearCoinValues() {
    advanecDrawArray =[];
    betArray = List.filled(13, 0);

    // numbersMap.clear();
    for (int i = 1; i <= 12; i++) {
      numbersMap[i] =  0;
    }
    selectedCoinValue = 0;
  }

  int getTotalValue() {
    if(advanecDrawArray.length>0) {
      var ttl = numbersMap.values.reduce((sum, value) => sum + value);
      return  ttl * advanecDrawArray.length;
    }else{
      return numbersMap.values.reduce((sum, value) => sum + value);
    }
  }

  int getTotalValue1() {
    return numbersMap.values.reduce((sum, value) => sum + value);
  }

  String timerData = 'No timer data yet';
  String currentDrawTime = 'No draw time yet';
  String loginSuccess = '';
  String receivedData = '';
  String drawTime = "";
  String winner = "";
  bool hasData = false;

  List<Map<String, dynamic>> winningNumbers = [];
  @override
  void initState() {
    super.initState();
    _initSocket();
  }

  void _initSocket() {
    socket.on('timer', (data) {
      setState(() {
        dynamic countdown = data['countdown']; // Get the countdown data
        int seconds;
        if (countdown is int) {
          seconds = countdown;
          // print('$countdown');
          if(countdown == 298){
            String dateToday = DateFormat('yyyy-MM-dd').format(DateTime.now());
            socket.emit('getWinningNumber',dateToday);
            socket.emit('getDrawAndDate');
          }
        } else if (countdown is String) {
          seconds = int.tryParse(countdown) ?? 0; // Use 0 if parsing fails
        } else {
          seconds = 0; // Default value if countdown is not an int or a String
        }
        int minutes = seconds ~/ 60;
        int remainingSeconds = seconds % 60;
        timerData = '$minutes : $remainingSeconds';
      });
    });

    socket.on('getCancelDataReply', (data) {
      // print('Received getCancelDataReply: $data');
      // Ensure that data is parsed into a List<Map<String, dynamic>>
      List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(data);
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return cancelticketScreen(data: dataList); // Pass the parsed data
        },
      );
    });

    socket.on('userDataReply', (data) {
            balance = data['balance'];
          });
    socket.on('currentDrawTime', (data) {
      setState(() {
        // print('this is DrawDate comming from server --------->> : $data');
        currentDrawTime = '$data';
        drawTime = '$data';
        currentBetTIme = '$data';
      });
    });

    socket.on('showWinning', (data) {
      setState(() {
        if (data is List<dynamic>) {
          winningNumbers = List<Map<String, dynamic>>.from(
              data.map<Map<String, dynamic>>((dynamic item) => item as Map<String, dynamic>)
          );
        } else {
          winningNumbers = [];
        }
      });
    });

    socket.on('printMsg', (data) {
      setState(() {
        if (data is String) {
          receivedData = data; // Assign the received string directly
        } else if (data is Map<String, dynamic>) {
          // Extract the relevant string data from the JSON map
          if(data['msg'] == 'yes'){
             var winAmount = data['winAmt'];
             var betMo = data['betNo'];
             var betTime = data['betTime'];
              receivedData = "Congratulations You won : $winAmount \n Bet number : $betMo \n Draw Time  : $betTime";
             _showSuccessDialog();
          }else{
            final message = data['msg'];
            receivedData = message;
            if(smallCancelBox == false){

            _showSuccessDialog();
            }
          }
        }
      });
    });

    socket.on('showWinningNumber', (data) {
      // print('this is winningNumber $data');
      List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(data);
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            // Reuse the popup content
            return resultScreen(data: dataList);
          },
        );
    });

    String inputTime = "10:20AM";
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    DateTime parsedTime = DateFormat('hh:mma').parse(inputTime);

// Format the DateTime object back to a string in your desired format
    String formattedTime = DateFormat('hh:mma').format(parsedTime);

    socket.on('userTicketsReplt', (data) {
      // print('user data : $data');
      var s = data.reversed.toList();
      List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(s);
    // if (!isBottomSheetOpen) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return UserTicketScreen(
              data: dataList, selectedRadio: ''); // Pass the parsed data
        },
      );
      // isBottomSheetOpen = false;
    // }
    });

    socket.on('viewTicketdata', (data) {
      // print('viewTicketdata----------->$data');
      // Extracting specific fields from the received data
      String ticketId = data['ticketId'].toString();
      String betTotal = data['betTotal'].toString();
      String winAmount = data['winAmount'].toString();
      String drawDate = data['drawDate'].toString();
      String winner = data['winner'].toString();
      String bet1 = data['bet1'].toString();
      String bet2 = data['bet2'].toString();
      String bet3 = data['bet3'].toString();
      String bet4 = data['bet4'].toString();
      String bet5 = data['bet5'].toString();
      String bet6 = data['bet6'].toString();
      String bet7 = data['bet7'].toString();
      String bet8 = data['bet8'].toString();
      String bet9 = data['bet9'].toString();
      String bet10 = data['bet10'].toString();
      String bet11 = data['bet11'].toString();
      String bet12 = data['bet12'].toString();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text('VIEW TICKET')),
            content: SingleChildScrollView(
              child: DataTable(
                border: TableBorder.all(
                  width: 1.0,
                  color: Colors.black,
                ),
                columns: const [
                  DataColumn(label: Text('Field')),
                  DataColumn(label: Text('Value')),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Text('Ticket ID')),
                      DataCell(Text('$ticketId')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Bet Total')),
                      DataCell(Text('$betTotal')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Win Amount')),
                      DataCell(Text('$winAmount')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Draw')),
                      DataCell(Text('$drawDate')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Number')),
                      DataCell(Text('$winner')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('bet1')),
                      DataCell(Text('$bet1')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('bet2')),
                      DataCell(Text('$bet2')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('bet3')),
                      DataCell(Text('$bet3')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('bet4')),
                      DataCell(Text('$bet4')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('bet5')),
                      DataCell(Text('$bet5')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('bet6')),
                      DataCell(Text('$bet6')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('bet7')),
                      DataCell(Text('$bet7')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('bet8')),
                      DataCell(Text('$bet8')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('bet9')),
                      DataCell(Text('$bet9')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('bet10')),
                      DataCell(Text('$bet10')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('bet11')),
                      DataCell(Text('$bet11')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('bet12')),
                      DataCell(Text('$bet12')),
                    ],
                  ),
                ],
              )

            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the alert dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });


    // Emit events
    socket.emit('getDrawAndDate');
    socket.emit('getWinningNumber');
  }
  void _showSuccessDialog() {
    smallCancelBox == true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(receivedData),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                smallCancelBox == false;
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  String getCurrentDate() {
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    return formattedDate;
  }
  void connectToSocket() {
    try {
      DateTime currentDate = DateTime.now();
      // Format the date as "YYYY-MM-DD"
      String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
      if ( getTotalValue() <= 0) {
        // Bet is placed with a coin selected
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a coin'),
            duration: Duration(seconds: 2),
          ),
        );
        // You can proceed with the bet logic here
      } else {

      List<Map<String, dynamic>> jsonArray = [
          {
            'userId': userId,
            'betTotal': getTotalValue1(),
            'drawTime': '$drawTime',
            'aId': aId,
            'mId': mId,
            'dId': dId,
            'username':'$urname',
            'drawDate': getCurrentDate(),
            'confirmTime': '$currentDate',
            'bet1': betArray[1],
            'bet2': betArray[2],
            'bet3': betArray[3],
            'bet4': betArray[4], // Set 'bet4' to 100
            'bet5': betArray[5], // Set 'bet5' to 100
            'bet6': betArray[6],   // Set the rest to 0
            'bet7': betArray[7],
            'bet8': betArray[8],
            'bet9': betArray[9],
            'bet10': betArray[10],
            'bet11': betArray[11],
            'bet12': betArray[12],
          },
          {
            'advanecDrawArray': advanecDrawArray // Comma added here
          }
        ];
          // Now you can send the modified jsonArray to the server.
        // print('Sending data to server: $jsonArray');
        // Send the jsonArray when connected.
        socket.emit('confirmBet', {jsonArray});
      setState(() {
        for (int i = 1; i <= 12; i++) {
          numbersMap[i] =  0;
        }
        advanecDrawArray =[];
      });
      }
    } catch (e) {
      // print('Error connecting to socket: $e');
    }
  }
  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  Color getColorForWinner(int winner){
    if ([1,5,9].contains(winner)) {
      return Color(0xFF73B273);
    } else if ([2,6,10].contains(winner)) {
      return Color(0xFFD1248E);
    } else if ([3,7,11].contains(winner)) {
      return Color(0xFFC0952B);
    } else if ([4,8,12].contains(winner)) {
      return Color(0xFF956EFF);
    } else {
      return Colors.black87;
    }
  }
  List<int> coinValues = [10, 20, 50, 100, 500, 1000];
  Map<int, List<String>> coinImages = {
    10: ['assets/10(1).png', 'assets/10(2).png'],
    20: ['assets/20.png', 'assets/20(2).png'],
    50: ['assets/50.png', 'assets/50(2).png'],
    100: ['assets/100.png', 'assets/100(2).png'],
    500: ['assets/500.png', 'assets/500(2).png'],
    1000: ['assets/1000.png', 'assets/1000(2).png'],
  };

  Map<int, int> selectedCoins = {
    10: 0,
    20: 0,
    50: 0,
    100: 0,
    500: 0,
    1000: 0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1.0, // Takes up 50% of the screen width
        heightFactor: 1.0, // Takes up 20% of the screen height
        child: Stack(
            children: <Widget>[
              const Text(
                'Received Data:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                receivedData, // Display received data here
                style: TextStyle(fontSize: 20),
              ),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/01.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  // Use constraints to make responsive decisions
                  double paddingVertical = 5.0;
                  double paddingStart = constraints.maxWidth * 0.69;
                  double imageHeight = 40.0;
                  double imageWidth = 40.0;

                  // Adjust these values based on screen size
                  if (constraints.maxWidth >= 600) {
                    // For tablets or larger devices
                    paddingVertical = 0.15;
                    imageHeight = 50.0;
                    imageWidth = 30.0;
                  } else if (constraints.maxWidth >= 400) {
                    // For medium-sized devices
                    paddingVertical = 5.0;
                    imageHeight = 40.0;
                    imageWidth = 40.0;
                  } else {
                    // For mobile devices (iPhone and Android)
                    paddingVertical = 5.0;
                    paddingStart = 10.0;
                    imageHeight = 40.0;
                    imageWidth = 40.0;
                  }
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                      paddingStart,
                      paddingVertical,
                      MediaQuery.of(context).size.width * 0.015,
                      0,
                    ),
                    child: Wrap(
                      spacing: 0.0,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            final DateTime now = DateTime.now();
                            // Format the date in "YYYY-MM-DD" format
                            final String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                            String date = formattedDate; // Use the formattedDate
                            cancelPopup=false;
                            // phone uchal na kt ata cl
                            socket.emit('getUserTickets', {
                              'username': '$urname',
                              'type': 'all', // Set 'type' to 'won'
                              'date': date,   // Use the formattedDate
                            });
                          },
                          child: Stack(
                            children: [
                              Image.asset("assets/03.png",
                                  height: imageHeight, width: imageWidth),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            socket.emit('getCancelData', {"username":'$urname'});
                          },
                          child: Stack(
                            children: [
                              Image.asset("assets/06.png", height: 50, width: 40),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
                            socket.emit('getDateResult', date);
                          },
                          child: Stack(
                            children: [
                              Image.asset("assets/07.png", height: 50, width: 30),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return Material(
                                  child: AdvMyWidget(), // Display your advancedraw page here
                                );
                              },
                            );
                            // socket.off('getCancelDataReply');
                            // socket.off('userTicketsReplt');
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> AdvMyWidget(),
                            // ),
                            // );
                          },
                          child: Stack(
                            children: [
                              Image.asset("assets/08.png", height: 60, width: 40),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                          },
                          child: Stack(
                            children: [
                              Image.asset("assets/04.png",
                                  height: imageHeight, width: imageWidth),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              // Example of using InkWell with onTap
              const Padding(
                padding: EdgeInsets.fromLTRB(360,3,1,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      child: Column(
                        children: [
                          Text(
                            'Draw : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10,),
              Padding(
                padding: EdgeInsets.fromLTRB(20,3, 1, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      child: Column(
                        children: [
                          Text(
                            'Balance : $balance',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 300,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(420,6, 1, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      child: Column(
                        children: [
                          Text(
                            currentDrawTime, // Display the received draw time
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 300.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(250, 5, 1, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      timerData,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              //Start 1 to 12 Numbers code
              const SizedBox(height: 20.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        (numbersMap.length / 4).ceil(),
                            (batchIndex) {
                          final startIndex = batchIndex * 4;
                          final endIndex = startIndex + 4;
                          final batchNumbers = numbersMap.keys.toList().sublist(startIndex, endIndex);

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center, // Change this to CrossAxisAlignment.center
                            children: batchNumbers.map((number) {
                              var value = numbersMap[number] == 0 ? '' : numbersMap[number].toString();
                              return GestureDetector(
                                onTap: () {
                                  addCoinValue(number);
                                },
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width *
                                        0.02, // Left padding as 10% of the screen width
                                    MediaQuery.of(context).size.height *
                                        0.08, // Top padding as 22% of the screen height
                                    MediaQuery.of(context).size.width *
                                        0.0, // Right p
                                    // adding as 1% of the screen width
                                    0,
                                  ), // Adjust padding as needed
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/$number.png',
                                    width: MediaQuery.of(context).size.width * 0.08,
                                    height: MediaQuery.of(context).size.width * 0.08,),
                                      Text(
                                        '${value ?? 0}',
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                );
                            }).toList(),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width *
                      0.15, // Left padding as 10% of the screen width
                  MediaQuery.of(context).size.height *
                      0.56, // Top padding as 22% of the screen height
                  MediaQuery.of(context).size.width *
                      0.10, // Right p
                  // adding as 1% of the screen width
                  0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('assets/99.png',
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,),
                        Text(
                          ' ${getTotalValue()}',
                          semanticsLabel: ' ${getTotalValue()}',// Replace with the actual logic to get the total value
                          style: const TextStyle(
                            color: Colors.black87, // Set the text color
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
        Padding(
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width *
                  0.0, // Left padding as 10% of the screen width
              MediaQuery.of(context).size.height *
                  0.80, // Top padding as 22% of the screen height
              MediaQuery.of(context).size.width *
                  0.12, // Right p
              // adding as 1% of the screen width
              0,
            ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: coinValues.map((coinValue) {
                    int selectedImageIndex = selectedCoins[coinValue] ?? 0;
                    String filename = coinImages[coinValue]![selectedImageIndex];
                    return Container(
                      margin: EdgeInsets.only(right: 2.0), // Adjust the margin to control spacing
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedCoins[coinValue] = (selectedImageIndex + 1) % coinImages[coinValue]!.length;
                            selectedCoinValue = coinValue;
                            // print('selectedCoinValue:$coinValue');
                          });
                          coinValues.forEach((value) {
                            if (value != coinValue) {
                              selectedCoins[value] = 0;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                          padding: EdgeInsets.all(0), // Set padding to zero
                        ),
                        child: Image.asset(
                          filename,
                          width: MediaQuery.of(context).size.width * 0.10,
                          height: MediaQuery.of(context).size.width * 0.10,
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ),

              //set image print and invoice
              const SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width *
                      0.50, // Left padding as 10% of the screen width
                  MediaQuery.of(context).size.height *
                      0.39, // Top padding as 22% of the screen height
                  MediaQuery.of(context).size.width *
                      0.09, // Right p
                  // adding as 1% of the screen width
                  0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        clearCoinValues();
                      },
                      child: Image.asset('assets/21.png',
                        height: MediaQuery.of(context).size.width * 0.11,
                        width: MediaQuery.of(context).size.width * 0.11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width *
                      0.47, // Left padding as 10% of the screen width
                  MediaQuery.of(context).size.height *
                      0.13, // Top padding as 6% of the screen height
                  MediaQuery.of(context).size.width *
                      0.01, // Right padding as 1% of the screen width
                  0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add your onPressed logic here
                        connectToSocket();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        elevation: MaterialStateProperty.all(0),// Set the background color to transparent
                      ),
                      child: Image.asset(
                        'assets/22.png',
                        height: MediaQuery.of(context).size.width * 0.11,
                        width: MediaQuery.of(context).size.width * 0.11,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                    padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width *
                          0.70, // Left padding as 10% of the screen width
                      MediaQuery.of(context).size.height *
                          0.14, // Top padding as 6% of the screen height
                      MediaQuery.of(context).size.width *
                          0.01, // Right padding as 1% of the screen width
                      0,
                    ), // Adjust padding as needed
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, // Allow horizontal scrolling
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width, // Ensure minimum width
                    ),
                    child: DataTable(
                      border: TableBorder.all(
                        width: 1.0,
                        color: Colors.white,
                        // dividerThickness: 5
                      ),
                      dataRowHeight: 30,
                      headingRowHeight: 30,
                      headingRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.red[900] ?? Colors.red),
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'TIME',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'RESULT',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Add more DataColumn widgets for additional columns if needed
                      ],
                      rows: winningNumbers.map<DataRow>((Map<String, dynamic> row) {
                        int winnerValue = int.tryParse(row['winner'].toString()) ?? 0;
                        Color rowColor = getColorForWinner(winnerValue);
                        return DataRow(
                          color: MaterialStateColor.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return rowColor.withOpacity(0.2);
                            }
                            return rowColor;
                          }),
                          cells: <DataCell>[
                            DataCell(
                              Text(
                                row['drawTime'].toString(),
                                overflow: TextOverflow.ellipsis, // Handle text overflow
                                maxLines: 1, // Set max lines to 1 to prevent excessive cell height
                              ),
                            ),
                            DataCell(
                              Text(
                                row['winner'].toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            // Add more DataCell widgets for additional columns if needed
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              )
            ]
        ),
      ),
    );
  }
}




