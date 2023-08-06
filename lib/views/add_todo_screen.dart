
import 'package:daniyal_designers_todo/models/todo_model.dart';
import 'package:daniyal_designers_todo/services/firebase_crud.dart';
import 'package:daniyal_designers_todo/views/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  List<String> collarNum = ['One', 'Two', 'Three', 'Four'];
  String _currentState = 'One';
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    TextEditingController heightController = TextEditingController();
    TextEditingController waistController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneNumController = TextEditingController();
    DateTime date = DateTime.now();
    final double deviceHight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: deviceHight * 0.09),
              Row(
                children: [
                  const Text(
                    "Afridi Designers",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(width: deviceWidth * 0.11),
                  Text(
                    'Date:"${DateFormat('dd-MMMM-yyyy').format(date)}"',
                  ),
                ],
              ),
              SizedBox(height: deviceHight * 0.02),
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text("Your Height:"),
                        SizedBox(width: deviceWidth * 0.07),
                        TextFormField(
                          controller: heightController,
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            constraints:
                                BoxConstraints(maxWidth: deviceWidth * 0.3),
                            hintText: "Enter Hight",
                            hintStyle: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Your waist:"),
                        SizedBox(width: deviceWidth * 0.10),
                        TextFormField(
                          controller: waistController,
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            constraints:
                                BoxConstraints(maxWidth: deviceWidth * 0.3),
                            hintText: "Enter waist",
                            hintStyle: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHight * 0.02),
                    Row(
                      children: [
                        const Text("Your Collar Number:"),
                        SizedBox(width: deviceWidth * 0.1),
                        SizedBox(
                          width: deviceWidth * 0.3,
                          height: deviceHight * 0.08,
                          child: DropdownButton<String>(
                            items: collarNum.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem));
                            }).toList(),
                            onChanged: (String? newValueSelected) {
                              setState(() {
                                _currentState = newValueSelected ?? "";
                              });
                            },
                            value: _currentState,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHight * 0.05),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: "Enter Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    SizedBox(height: deviceHight * 0.02),
                    TextFormField(
                      controller: phoneNumController,
                      maxLength: 11,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter Phone Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text("Delivery Date:"),
                        TextButton(
                          onPressed: () async {
                            final DateTime? datePicked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2101));
                            if (datePicked != null ) {
                              setState(() {
                                selectedDate = datePicked;
                              });
                            }
                          },
                          child: const Text("Enter a date"),
                        ),
                        Text("${DateTime.parse(DateFormat('dd-MM-yy').format(selectedDate??DateTime.now()))}"),
                      ],
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseCRUD().createUser(
                    User(
                        selectedDate: DateTime.parse(DateFormat('dd-MM-yy').format(selectedDate??DateTime.now())),
                        phoneNum: int.tryParse(phoneNumController.text) ?? 0,
                        name: nameController.text,
                        collarNumber: _currentState,
                        waist: int.tryParse(waistController.text) ?? 0,
                        height: int.tryParse(heightController.text) ?? 0),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserScreen(),
                    ),
                  );
                },
                child: const Text("Add User"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
