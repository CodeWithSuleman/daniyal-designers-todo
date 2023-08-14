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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: deviceHeight * 0.09),
              Row(
                children: [
                  Text("Daniyal Designers",
                      style: TextStyles.largeHeadingStyles),
                  const Spacer(),
                  Text(
                    'Date: ${DateFormat('dd-MMMM-yyyy').format(date)}',
                  ),
                ],
              ),
              const Divider(),
              SizedBox(height: deviceHeight * 0.02),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Height"),
                            SizedBox(height: deviceHeight * 0.02),
                            TextFormField(
                              controller: heightController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                constraints:
                                    BoxConstraints(maxWidth: deviceWidth * 0.4),
                                border: const OutlineInputBorder(),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                hintText: "Enter Height",
                                hintStyle: const TextStyle(fontSize: 12),
                              ),
                              validator: Validator.validateHeight,
                            ),
                          ],
                        ),
                        SizedBox(width: deviceWidth * 0.09),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("waist"),
                            SizedBox(height: deviceHeight * 0.02),
                            TextFormField(
                              controller: waistController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                constraints:
                                    BoxConstraints(maxWidth: deviceWidth * 0.4),
                                hintText: "Enter waist",
                                hintStyle: const TextStyle(fontSize: 12),
                              ),
                              validator: Validator.validateWaist,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text("Collar Number"),
                        SizedBox(height: deviceHeight * 0.01),
                        SizedBox(
                          width: deviceWidth * 0.2,
                          height: deviceHeight * 0.08,
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
                    SizedBox(height: deviceHeight * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text("Your Name"),
                        SizedBox(height: deviceHeight * 0.01),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: "Enter Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: Validator.validateName,
                        ),
                        SizedBox(height: deviceHeight * 0.02),
                        const Text("your Number"),
                        SizedBox(height: deviceHeight * 0.01),
                        TextFormField(
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
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.01),
                    Column(
                      children: [
                        SizedBox(width: deviceWidth * 0.09),
                        const Text("Delivery Date:"),
                        TextFormField(
                          validator: Validator.validateDate,
                          controller: dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: selectedDate != null
                                ? DateFormat('dd-MMMM-yyyy')
                                    .format(selectedDate!)
                                : 'Select Date',
                          ),
                          onTap: () async {
                            final DateTime? datePicked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101));
                            if (datePicked != null) {
                              setState(() {
                                selectedDate = datePicked;
                              });
                            }
                            dateController.text;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: deviceHeight * 0.01),
              ElevatedButton(
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
            ],
          ),
        ),
      ),
    );
  }
}
