
import 'package:daniyal_designers_todo/services/firebase_crud.dart';
import 'package:daniyal_designers_todo/views/update_todo_screen.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Afridi Designer",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: FutureBuilder(
          future: FirebaseCRUD().getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.lime.shade50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Name: ${snapshot.data![index].name}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  "PhoneNumber: ${snapshot.data![index].phoneNum}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("waist: ${snapshot.data![index].waist}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Height: ${snapshot.data![index].height}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  "CollarNumber: ${snapshot.data![index].collarNumber}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Delivery Date: ${snapshot.data![index].selectedDate.toString()}",
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  FirebaseCRUD()
                                      .deleteUser(snapshot.data![index]);
                                },
                                child: const Text("Delete"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateTodoScreen(
                                        id: snapshot.data![index].id!,
                                        name: snapshot.data![index].name,
                                        waist: snapshot.data![index].waist,
                                        height: snapshot.data![index].height,
                                        phoneNum:
                                            snapshot.data![index].phoneNum,
                                        selectedDate:
                                            snapshot.data![index].selectedDate,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Update"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const Text("Data Not Found");
          },
        ),
      ),
    );
  }
}