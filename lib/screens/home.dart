import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoapp/screens/addtodo.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading =true;
  List items = [];
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 80, 80, 80),
          centerTitle: true,
          title: Text(
            'Todo App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Visibility(
          visible:isLoading ,
          child: Center(child: CircularProgressIndicator(),),
          replacement: RefreshIndicator  (
              onRefresh:fetchTodo ,
            
              child: ListView.builder(
                itemCount: items.length,   
                itemBuilder: (context,index){
                  final item =items[index] as Map ;
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index+1}')),
                    title: Text(item['title'] ) ,
                    subtitle: Text(item['description']),
                  );
                
              
              }),
            ),
        ),
        
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddTodo()));
            },
            label: Text('Add Todo')),
      ),
    );
  }

  Future<void> fetchTodo() async {
 
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    } 
    setState(() {
      isLoading =false;
    });
  }
}
