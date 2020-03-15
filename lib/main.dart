import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(FoodApp());

class FoodApp extends StatefulWidget {
  @override
  _FoodAppState createState() => _FoodAppState();
}

class _FoodAppState extends State<FoodApp> {
  final String url =
      'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail';
  List data;

  Future<String> getData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});

    setState(() {
      var content = json.decode(res.body);
      data = content['drinks'];
    });
    return 'success';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Food'),
        ),
        body: Container(
          child: GridView.builder(
              itemCount: data == null ? 0 : data.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: Image.network(data[index]['strDrinkThumb']))
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }
}
