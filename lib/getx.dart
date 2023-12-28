import 'package:flutter/material.dart';

class getx extends StatefulWidget {
  const getx({super.key});

  @override
  State<getx> createState() => _getxState();
}

class _getxState extends State<getx> {
  @override
  Widget build(BuildContext context) {
 return Scaffold(
      appBar: AppBar(
          title: const Text(
       //What is GetX in flutter?
        'GetX is also a powerful micro framework and using this, we can manage states,'
        'make routing, and can perform dependency injection'
        //Three principle of GetX
        '1-Productivity,2-Performance,3-Organization'
       //What is the difference between Get.put() and Get.lazyPut() in GetX?
        'Get.put() registers an instance of a class as a dependency in the GetX container,'
        ' and it is created immediately. '
        'Get.lazyPut() registers a class as a dependency in the GetX container, '
        'but the instance is only created when it is first requested.'
       //What is the difference between GetX and Provider in Flutter?
       'GetX provides a lightweight and easy-to-use approach to state management'
        'Provider is a more complex framework that provides more advanced features. '
        'GetX also includes built-in support for dependency injection and routing,'
        ' while Provider is mainly focused on state management.'
       //Advantages of using GetX for Flutter development?
        'Advantages of using GetX include its simplicity, performance, and flexibility.'
        ' GetX is lightweight and easy to learn, making it a great choice for small to medium-sized projects'
        //What is dependency injection and how does GetX handle it?
        'Dependency injection is a design pattern that separates object creation and object usage by allowing '
        'objects to be passed as arguments to other objects.'
        //what is firebase messaging
        'Flutter plugin for Firebase Cloud Messaging, a cross-platform messaging'
        'solution that lets you reliably deliver messages on Android and iOS'
        //Does flutter have a push notification feature?
        'We have successfully added a push notification feature in our Flutter application '
        'using Firebase Cloud Messaging. Push notifications are essential in any app.'
        //how to use firebase in flutter application
        'Firebase is a comprehensive platform that offers various services such as Firestore'
        '(a NoSQL database), Authentication, Cloud Functions, Cloud Storage, and more.'
      ),
      ),
    );
  }
}
