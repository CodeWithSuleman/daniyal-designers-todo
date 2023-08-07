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
              return Text('Error: ${snapshot.error}');
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${snapshot.data![index].name}"),
                          Text(
                              "PhoneNumber: ${snapshot.data![index].phoneNumber}"),
                          Text("waist: ${snapshot.data![index].waist}"),
                          Text("Height: ${snapshot.data![index].height}"),
                          Text(
                              "CollarNumber: ${snapshot.data![index].collarNumber}"),
                          Text(
                              "Delivery Date: ${snapshot.data![index].deliveryDate}"),
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
                                            snapshot.data![index].phoneNumber,
                                        selectedDate:
                                            snapshot.data![index].deliveryDate,
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
