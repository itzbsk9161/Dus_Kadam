import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'global.dart';
import 'homepage.dart';

class AdvMyWidget extends StatefulWidget {
  @override
  _AdvMyWidgetState createState() => _AdvMyWidgetState();
}

class _AdvMyWidgetState extends State<AdvMyWidget> {
  List<bool> checkboxValues = List.generate(192, (index) => false);
  List<String> timestamps = [];

  @override
  void initState() {
    super.initState();
    timestamps = generateTimeStamps();
    checkboxValues = List.generate(timestamps.length, (index) => false); // Match the length
  }

  List<String> generateTimeStamps() {
    DateTime startTime = DateFormat('hh:mm a').parse('10:20 AM');
    DateTime endTime = DateFormat('hh:mm a').parse('10:20 PM');
    List<String> timestamps = [];
    DateTime currentTime = startTime;
    while (currentTime.isBefore(endTime)) {
      String formattedTime = DateFormat('hh:mm a').format(currentTime);
      timestamps.add(formattedTime);
      currentTime = currentTime.add(Duration(minutes: 5));
    }
    return timestamps;
  }

  void _updateCheckboxValue(int index, bool? value) {
    setState(() {
      // Checkbox is clicked, print the corresponding time

      var searchString =timestamps[index] as String;

      if (advanecDrawArray.contains(searchString)) {
        // String exists in the array, remove it
        advanecDrawArray.remove(searchString);
        // print("Removed: $advanecDrawArray");
      } else {
        // String does not exist in the array, add it
        advanecDrawArray.add(searchString);
        // print("Added: $advanecDrawArray");
      }
      checkboxValues[index] = value ?? false;
    });
  }

  @override
  void dispose() {
    _AdvMyWidgetState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> timestamps = generateTimeStamps();
    return Scaffold(
      body: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.green[200],
                  padding: const EdgeInsets.symmetric(vertical: 08.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text(
                            'ADVANCE DRAW',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Close"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 4.0,
              ),
              shrinkWrap: true,
              itemCount: timestamps.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildTimeCheckboxBox(timestamps[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCheckboxBox(String timestamp, int index) {
    DateTime currentDrawTime = DateFormat('hh:mm a').parse(currentBetTIme);
    DateTime appendedTime = DateFormat('hh:mm a').parse(timestamp);
    if (appendedTime.isBefore( currentDrawTime)) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(color: Colors.blue, width: 3.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timestamp,
              style: TextStyle(fontSize: 10),
            ),
            Checkbox(
              value: false,
              onChanged: (bool? value) {
              },
            ),
          ],
        ),
      );
    }else{
      if (advanecDrawArray.indexOf(timestamp) != -1) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.yellow[300],
            border: Border.all(color: Colors.blue, width: 3.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                timestamp,
                style: TextStyle(fontSize: 10),
              ),
              Checkbox(
                value: true,
                onChanged: (bool? value) {
                  _updateCheckboxValue(index, value);
                },
              ),
            ],
          ),
        );
      } else {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.yellow[300],
            border: Border.all(color: Colors.blue, width: 3.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                timestamp,
                style: TextStyle(fontSize: 10),
              ),
              Checkbox(
                value: checkboxValues[index],
                onChanged: (bool? value) {
                  _updateCheckboxValue(index, value);
                },
              ),
            ],
          ),
        );
      }
    }
  }
}