import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AddTodo extends StatefulWidget {
  AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {


  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 49, 49, 49),
        centerTitle: true,
        title: const Text(
          'AddTodo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Discription'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(
            height: mediaQuery.height * 0.02,
          ),
          ElevatedButton(
            onPressed: () {
              submitData(context);
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void submitData(BuildContext context) async {
    final title = titleController.text;
    final discription = descriptionController.text;
    final body = {
      "title": title,
      "description": discription,
      "is_completed": false,
    };

    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': ' application/json'});
    if (response.statusCode == 201) {
      titleController.text = "";
      descriptionController.text = "";

      successMessage(context);
    } else {
      print('connection failed ');
      print(response.body);

      failedMessage(context);
    }
  }

  void successMessage(context) {
    final snackBar = SnackBar(
      content: Text(
        'Creation success',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blueAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void failedMessage(context) {
    final snackBar = SnackBar(
      content: Text(
        'Creation failed ',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 141, 13, 4),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

 
}
