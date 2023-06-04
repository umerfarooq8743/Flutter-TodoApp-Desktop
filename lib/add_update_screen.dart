import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newtodoapp/db_handler.dart';
import 'package:newtodoapp/model.dart';
import 'package:newtodoapp/todo.dart';

class AddUpdateTask extends StatefulWidget {
  // int? todoId;
  // String? todoTitle;
  // String? todoDesc;
  // String? todoDT;
  // bool? update;
  // AddUpdateTask({
  //   this.todoId,
  //   this.todoTitle,
  //   this.todoDesc,
  //   this.todoDT,
  //   this.update,
  // });

  @override
  State<AddUpdateTask> createState() => _AddUpdateTaskState();
}

class _AddUpdateTaskState extends State<AddUpdateTask> {
  final _fromKey = GlobalKey<FormState>();
  DBHelper? dbHelper;
  final titleControlller = TextEditingController();
  final descController = TextEditingController();
  // String appTitle;
  // if(widget.update ==true){
  //   appTitle="update task"; 
  // }
  late Future<List<TodoModel>> dataList;
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    dataList = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add/Update Task",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 1),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _fromKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        controller: titleControlller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Note  Title"),
                        validator: (Value) {
                          if (Value!.isEmpty) {
                            return "Enter Some Text";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 5,
                        controller: descController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Note Task "),
                        validator: (Value) {
                          if (Value!.isEmpty) {
                            return "Enter Some Text";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Material(
                        color: Colors.green[400],
                        child: InkWell(
                          onTap: () {
                            if (_fromKey.currentState!.validate()) {
                              dbHelper!.insert(TodoModel(
                                  title: titleControlller.text,
                                  desc: descController.text,
                                  dateandtime: DateFormat('yMd')
                                      .add_jm()
                                      .format(DateTime.now())
                                      .toString()));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => todo()));
                              titleControlller.clear();
                              descController.clear();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 55,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              // boxShadow: [
                              //   BoxShadow(
                              //       color: Colors.black12,
                              //       blurRadius: 5,
                              //       spreadRadius: 1)
                              // ]
                            ),
                            child: Text("Submit"),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.red[400],
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              titleControlller.clear();
                              descController.clear();
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 55,
                            width: 120,
                            //  color: Colors.red,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),
                              // boxShadow: [
                              //   BoxShadow(
                              //       color: Colors.black12,
                              //       blurRadius: 5,
                              //       spreadRadius: 1)
                              // ]
                            ),
                            child: Text("clear"),
                          ),
                        ),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
