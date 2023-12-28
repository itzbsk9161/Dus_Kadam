import 'package:dus_kadam/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'global.dart';

void main() {
  runApp(Login());
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Perform login logic here with dynamic username and password
    // For demonstration, we're using hardcoded values.
    socket.emit('userLogin', {'username': username, 'password': password});

    socket.on('loginFailed', (data) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect username or password'),
          duration: Duration(seconds: 2),
        ),
      );
    });

    socket.on('loginSuccess', (data) {

      aId = data['aId'];
      mId = data['mId'];
      dId = data['dId'];
      balance = data['balance'];
      username = data['username'];
      urname=data['username'];
      userId = data['userId'];
      // print('this is username :"$username"');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: MediaQuery.of(context).size.height * 0.57,
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.yellow[900]!, width: 1.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.4,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 5.0),
                        Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'LOGIN ID:',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: TextFormField(
                                    controller: _usernameController,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                               padding: EdgeInsets.all(6.0),
                                child: Text(
                                  'PASSWORD:',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: TextFormField(
                                    controller: _passwordController,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4, // Adjust the fraction as needed
                                child: ElevatedButton(
                                  onPressed: _submitForm,
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.blue, width: 2),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    primary: Colors.yellow[700],
                                  ),
                                  child: const Text('LOGIN', style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4, // Adjust the fraction as needed
                                child: ElevatedButton(
                                  onPressed: () {
                                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red[900],
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.blue, width: 2),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: const Text(
                                    'CANCEL',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
