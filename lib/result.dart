import 'package:flutter/material.dart';
import 'homepage.dart';
import 'global.dart';


// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//     );
//   }
// }

class resultScreen extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  resultScreen({required this.data});

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
            color: Colors.teal[100], // Header background color
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 08.0),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Result',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6, // You can adjust the number of columns as needed
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final item = data[index];
                return Container(
                  margin: EdgeInsets.all(5.0),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightBlueAccent),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.green[200],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${item['drawTime']}'),
                      Text('${item['winner']}'),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
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
