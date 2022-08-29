// main.dart
import 'package:dotted_line/dotted_line.dart';
import 'package:fitpage/Criteria.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for using json.decode()

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      title: 'Kindacode.com',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // The list that contains information about photos
  List _loadeddata = [];

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    const apiUrl = 'https://mobile-app-challenge.herokuapp.com/data';

    final response = await http.get(Uri.parse(apiUrl));
    List data = json.decode(response.body);

    setState(() {
      _loadeddata = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black26,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: _loadeddata.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Criteria(data: _loadeddata[index]),
                      ));
                },
                child: ListTile(
                  leading: bullet(),
                  title: Text(
                    _loadeddata[index]['name'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' ${_loadeddata[index]["tag"]}',
                        style: TextStyle(
                            color: _loadeddata[index]["color"] == "green"
                                ? Colors.green
                                : Colors.red),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      dottedLine()
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  Widget dottedLine() {
    return const DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 4.0,
      dashColor: Colors.white,
      dashRadius: 0.0,
      dashGapLength: 4.0,
      dashGapColor: Colors.transparent,
      dashGapRadius: 0.0,
    );
  }

  Widget bullet() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: 5,
      width: 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white54),
    );
  }
}
