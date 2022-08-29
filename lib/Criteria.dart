import 'dart:developer';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:flutter/material.dart';

class Criteria extends StatelessWidget {
  var data;
  Criteria({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("$data");
    return Scaffold(
        backgroundColor: Colors.black12,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                tileColor: Colors.blue[100],
                title: Text(
                  "${toBeginningOfSentenceCase(data["name"])}",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  "${toBeginningOfSentenceCase(data["tag"])}",
                  style: TextStyle(
                      color:
                          data["color"] == "green" ? Colors.green : Colors.red),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                    itemCount: data['criteria'].length,
                    itemBuilder: (BuildContext ctx, index) {
                      return ListTile(
                        title: Text(
                          "${toBeginningOfSentenceCase(data['criteria'][index]['text'])}",
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: data['criteria'].length > 2 &&
                                index <= data['criteria'].length - 2
                            ? Text(
                                "\nand\n ",
                                style: TextStyle(color: Colors.white),
                              )
                            : Container(),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
