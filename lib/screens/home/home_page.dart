import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _dio = Dio(BaseOptions(responseType: ResponseType.plain));
  List<TodoItem>? _itemList;
  String? _error;

  void getTodos() async {
    try {
      setState(() {
        _error = null;
      });

      // await Future.delayed(const Duration(seconds: 3), () {});

      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/albums');
      debugPrint(response.data.toString());
      // parse
      List list = jsonDecode(response.data.toString());
      setState(() {
        _itemList = list.map((item) => TodoItem.fromJson(item)).toList();
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
      debugPrint('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_error != null) {
      body = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_error!),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              getTodos();
            },
            child: const Text('RETRY'),
          )
        ],
      );
    } else if (_itemList == null) {
      body = const Center(child: CircularProgressIndicator());
    } else {
      body = ListView.builder(
          itemCount: _itemList!.length,
          itemBuilder: (context, index) {
            var todoItem = _itemList![index];
            return Card(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(

                      children: [
                        Row(children: [
                          Expanded(child: Text(todoItem.title)),

                        ]),
                        Row(
                          children: [
                            Text("Album ID:"+" "+todoItem.id.toString()+" "),
                            Text("User ID:"+" "+todoItem.userId.toString()),
                          ],
                        ),
                      ],
                    )));
          });

    }

    return Scaffold(body: body);
  }
}
