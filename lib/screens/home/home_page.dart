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

  void getTodos() async {
    final response =
        await _dio.get('https://jsonplaceholder.typicode.com/todos');
    debugPrint(response.data.toString());
    List list = jsonDecode(response.data.toString());
    List<TodoItem> itemList =
        list.map((item) => TodoItem.fromJson(item)).toList();
    itemList.forEach((elm) {
      debugPrint(elm.title);
    });
  }

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
