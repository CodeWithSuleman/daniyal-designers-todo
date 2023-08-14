import 'package:daniyal_designers_todo/models/todo_model.dart';
import 'package:daniyal_designers_todo/services/firebase_crud.dart';
import 'package:daniyal_designers_todo/shared/text_styles.dart';
import 'package:daniyal_designers_todo/utils/validataion.dart';
import 'package:daniyal_designers_todo/views/all_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final List<String> collarNum = ['One', 'Two', 'Three', 'Four'];
  String _currentState = 'One';
  DateTime? selectedDate;
  final TextEditingController heightController = TextEditingController();
  final TextEditingController waistController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final DateTime date = DateTime.now();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: deviceHeight * 0.09),
              Row(
                children: [
                  Text(
                    "Daniyal Designers",
                    style: TextStyles.largeHeadingStyles,
                  ),
                  const Spacer(),
                  Text('Date: ${DateFormat('dd-MMMM-yyyy').format(date)}'),
                ],
              ),
              const Divider(),
              SizedBox(height: deviceHeight * 0.02),
              Row(
                children: [
                  Column(
                    children: [
                      const Text("Height"),
                      SizedBox(height: deviceHeight * 0.02),
                      SizedBox(
                        width: deviceWidth * 0.4,
                        child: TextFormField(
                          controller: heightController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            hintText: "Enter Height",
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          validator: Validator.validateHeight,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      SizedBox(width: deviceWidth * 0.09),
                      const Text("waist"),
                      SizedBox(height: deviceHeight * 0.02),
                      SizedBox(
                        width: deviceWidth * 0.4,
                        child: TextFormField(
                          controller: waistController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            hintText: "Enter waist",
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          validator: Validator.validateWaist,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: deviceHeight * 0.05),
              const Text("Collar Number"),
              SizedBox(height: deviceHeight * 0.01),
              Container(
                width: deviceWidth,
                height: deviceHeight * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: DropdownButton<String>(
                underline: const SizedBox(),
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
              SizedBox(height: deviceHeight * 0.02),
              const Text("Your Name"),
              SizedBox(height: deviceHeight * 0.01),
              SizedBox(
                width: deviceWidth * 0.9,
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: Validator.validateName,
                ),
              ),
              SizedBox(height: deviceHeight * 0.02),
              const Text("Your Number"),
              SizedBox(height: deviceHeight * 0.01),
              SizedBox(
                width: deviceWidth * 0.9,
                child: TextFormField(
                  controller: phoneNumController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: Validator.validatePhoneNumber,
                ),
              ),
              SizedBox(height: deviceHeight * 0.01),
              SizedBox(width: deviceWidth * 0.09),
              const Text("Delivery Date"),
              SizedBox(
                width: deviceWidth * 0.9,
                child: TextFormField(
                  validator: Validator.validateDate,
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Select Date",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onTap: () async {
                    final DateTime? datePicked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101));
                    if (datePicked != null) {
                      setState(() {
                        dateController.text =
                            DateFormat('dd-MMMM-yyyy').format(datePicked);
                        selectedDate = datePicked;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: deviceHeight * 0.01),
              Container(

                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseCRUD().createUser(
                        User(
                            id: const Uuid().v1(),
                            deliveryDate:
                            DateFormat('dd-MMMM-yyyy').format(selectedDate!),
                            phoneNumber:
                            int.tryParse(phoneNumController.text) ?? 0,
                            name: nameController.text,
                            collarNumber: _currentState,
                            waist: int.tryParse(waistController.text) ?? 0,
                            height: int.tryParse(heightController.text) ?? 0),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllTodoScreen(),
                        ),
                            (route) => false,
                      );
                    }
                  },
                  child: const Text("Add User"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
