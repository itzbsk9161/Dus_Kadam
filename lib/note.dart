// import 'package:flutter/material.dart';
//
// class bsk extends StatefulWidget {
//   const bsk({super.key});
//
//   @override
//   State<bsk> createState() => _bskState();
// }
//
// class _bskState extends State<bsk> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(

// why to change flutter:
// I want to work on client side so have to turn there.

// best answer for reason job change?
// it is always encouraged that after a certain point for over betterment,
// growth,and development and to understand the new set of world, taking up new challenges, and to greet
// and meet new people for a complete enhancement package. It is better to step- up and explore new opportunities.//

// What is flutter application architecture?
//  'Flutter is a popular open-source UI kit by Google, which allows building cross-platform applications'
//  'with solid architecture. Speaking about mobile apps development,'
//  'the technology allows code reuse across both Android and iOS operating systems'

// What is Flutter?
//  'Flutter is a mobile application development framework that allows developers to create high-performance,'
//  'beautiful, and responsive mobile applications for multiple platforms using a single codebase.'

// what is scaffold, and properties?
//  'scaffold widget is the base of the screen for a single page.it is used to implement'
//  'the basic functional layout structure for an app'
//  1.appBar, 2.body, 3.floatingActionButton, 4.bottomNavigationBar, 5.drawer,

//Column:
//     A Column widget in Flutter is used to arrange its children in a vertical sequence.
//     It takes multiple child widgets and arranges them from top to bottom.
//     Children are added to the column using the children property..

// Row:
//     A Row widget is used to arrange its children in a horizontal sequence.
//     It takes multiple child widgets and arranges them from left to right.
//     Children are added to the row using the children property.

// What are the different types of widgets in Flutter?
//  'Stateless widgets:'
//   'These widgets are immutable, meaning they cannot be changed once they are created'
//  Stateful widgets:
//   'These widgets are mutable and can be updated dynamically based on user interactions or other events'
// What is Dart, and why is it used in Flutter?
//  'Dart is a client-side programming language that is used in Flutter for developing mobile applications'

// main pillers of oops?
// class:A class is a blueprint for creating objects. It defines the properties and behaviors
//       that objects of the class will have.
//objects: An object is an instance of a class.
// 'Encapsulation: Encapsulation is the concept of bundling data and the methods that operate'
//     'on that data into a single unit called a class.'
//'Inheritance: Inheritance allows you to create a new class based on an existing class'
//'Polymorphism: Polymorphism is the ability of different objects to respond to the same'
//    'method call in a way that is appropriate for their specific types'
//'Abstraction: Abstraction involves simplifying complex systems by breaking them into smaller,'
//    'more manageable parts.'

//what is Access Modifier
//   'Public: Public members can be accessed from anywhere.'
//   'Private: private Members can only be accessed within the same library'
//   'Protected: Protected member can be accessible to subclasses outside the library'

//What is Api and how to integrate in flutter
//  'API is a set of definitions and protocols through which applications communicate with each other'
//  'Step 1: Get the API URL and endpoints'
//  'Step 2: Add relevant packages into the app (http, dio, chopper, etc.).'
//  'Step 3: Create a constant file that stores URLs and endpoints.'
//  'Step 4: Create a model class to parse the JSON'

//   Build Method?
//     'The build method is a method that is called when a widget needs to build its user interface.'
//   BuildContext?
//          'The build method takes a BuildContext object as an argument, which provides information about'
//          'the location of the widget in the widget tree.'
//   What is the difference between SizedBox VS Container?
// Container?
//       'The Container in Flutter is a parent widget that can contain multiple child widgets and manage'
//       'them efficiently through width, height, padding, background color, etc.'
// SizedBox?
//          'The SizedBox widget in Flutter is a box that comes with a specified size.'
//          'Unlike Container, it does not allows us to set color or decoration for the widget.'
// Why is the build() method on State and not StatefulWidgets?
//          'The main reason behind this is that the StatefulWidget uses a separate State class'
//          'without building a method inside its body. It means all fields inside a Widget are'
//          'immutable and includes all its sub-classes.'
// method overriding?
//  'method overriding is a way for a subclass to customize the behavior of a method inherited from its superclass.'
//
// When to call flutter setState() method?
//    'Whenever you change the internal state of a State object, '
//    'make the change in a function that you pass to setState.'
//
// flutter lifecycle method?
//     'InitState','DidChangeDependencies','DidUpdateWidget,Deactivate,Dispose'
// GetMaterialApp?
//       'GetMaterialApp simplifies the process of defining and managing app routes using the GetX router.'
//       'It eliminates the need for a separate Navigator widget, making route management more intuitive.'
// flutter and react?
//      'Flutter: Flutter is primarily used for building mobile apps (iOS and Android) and desktop applications. '
//       react: React is used for building web applications (React) and mobile apps (React Native).'
//           ' Its primarily focused on web and mobile development'
// What is the purpose of a key in Flutter?
//     'Key is an object that identifies a widget. It is used to maintain the state of the widget'
//       'and to optimize the rendering performance of the app'
// GlobalKey:
//     'This key is used to identify a widget from anywhere in the app'
// ObjectKey:
//     'This key is used to identify a widget based on its object identity'
// What is the difference between MaterialApp and WidgetsApp in Flutter?
//  MaterialApp?
//         'MaterialApp is used for creating applications that follow the Material Design guidelines.'
//  WidgetsApp?
//         'It provides a minimal set of widgets that can be used to create custom UI elements.'
//  What is the purpose of the ListView widget in Flutter?
//         'The ListView widget is used to display a scrolling list of items in a Flutter application'
//  ListView.builder?
//         'which can be used to customize the behavior of the list.'
//  GridView widget?
//         'The GridView widget is used to display a grid of items in a Flutter application'
//  GestureDetector widget in Flutter?
//         'The GestureDetector widget is used to detect gestures,'
//         'such as taps and swipes, in a Flutter application.'
//  Navigator widget in Flutter?
//         'The Navigator widget is used to manage a stack of screens,'
//           'or “routes,” in a Flutter application'
//  LayoutBuilder widget in Flutter? 
//         'The LayoutBuilder widget is used to rebuild a widget when its'
//           'parent widget changes size in a Flutter application'
//  StreamBuilder widget in Flutter?
//         'The StreamBuilder widget is used to rebuild a widget when data is emitted by'
//           'a Stream in a Flutter application. The StreamBuilder widget provides a '
//           'builder function that can be used to rebuild a widget tree when data is '
//           'emitted by a Stream.'
//  Expanded widget in Flutter?
//          'The Expanded widget is used to fill the available space of a Flex container'
//           ' in a Flutter application. The Expanded widget is useful for creating UIs'
//           ' that adjust to different screen sizes and orientations.'
//  FutureBuilder widget in Flutter?
//          'The FutureBuilder widget is used to rebuild a widget when a Future completes in '
//          'a Flutter application. The FutureBuilder widget provides a builder function that'
//          'can be used to rebuild a widget tree when a Future completes'
//  Static Keyword:
//          'static, any variable you declare inside of the class becomes the same for every '
//          'instance of the class. Such data members can be accessed directly without '
//          'creating any object.'
//  Final Keyword:
//          'Once assigned variables cannot be re-assigned i.e. they are completely immutable'
//          'but it does not necessarily mean we cannot change the internal state of the'
//          'variable. A final variable must be initialized.'
//  Const Keyword:
//          '‘const’ keyword, the objects state is determined entirely at compile-time'
//          'setting the state to be completely immutable or unchangeable.'
// MediaQuery:
//      The MediaQueryData object provides properties, such as devicePixelRatio, orientation, and size,
//      which can be used to create responsive UIs that adapt to different screen sizes and orientations.
// variable:
//        A variable is the name of a reserved area allocated in memory.
//Local Variable:
//        A variable declared inside the body of the method is called local variable
//Instance Variable:
//        A variable declared inside the class but outside the body of the method, is called
//        an instance variable
//Static Variable:
//        A variable that is declared as static is called a static variable
//        Memory allocation for static variables happens only once when the class is loaded in the memory.
//       ),
//     );
//   }
// }
