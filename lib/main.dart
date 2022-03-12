import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'data.dart';
import 'package:http/http.dart' as http;

void main() {
  const app = MyApp();
  runApp(app);

}
var  food=[];
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // callback method
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            fontSize: 22.0,
            //fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      home: Test(),
    );
  }
}

class Test extends StatelessWidget {
  Test({Key? key}) : super(key: key);

  final List<data_json> covidReportList = [


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('FLUTTER FOOD')
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _handleClickButton,
            child: const Text('LOAD FOODS DATA'),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: covidReportList.length,
                itemBuilder: (context, index) =>
                    MyCard(covid: covidReportList[index])
            ),
            ),
        ],

      ),

    );
  }
}
void _handleClickButton() async{
  final url = Uri.parse('https://cpsu-test-api.herokuapp.com/foods');
  var result = await http.get(url);


  var json = jsonDecode(result.body);
  String status = json['status'];
  String? message = json['message'];
  List<dynamic> data = json['data'];

  food = data;

  print(data.length);
  print('Foodddddddd : $food ');
  print(data[0]['image']);

}
class MyCard extends StatelessWidget {
  final data_json covid;

  const MyCard({
    Key? key,
    required this.covid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text(covid.date),
            Row(
              children: [
                //SizedBox(width: 20.0),
                Column(
                  children: [
                    Image.asset('assets/images/${covid.image}', fit:BoxFit.contain,height: 400,width: 450,),

                  ],
                ),
                Column(
                  children: [
                    Text(' ${covid.name}' ,style: TextStyle(fontSize: 20),),
                    Text(' ${covid.name} บาท'),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
