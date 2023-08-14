import 'package:daniyal_designers_todo/models/todo_model.dart';
import 'package:daniyal_designers_todo/services/firebase_crud.dart';
import 'package:daniyal_designers_todo/shared/text_styles.dart';
import 'package:daniyal_designers_todo/utils/validataion.dart';
import 'package:daniyal_designers_todo/views/all_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UpdateTodoScreen extends StatefulWidget {
  final User user;

  const UpdateTodoScreen({
    super.key,
    required this.user,
  });

  @override
  State<UpdateTodoScreen> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodoScreen> {
  List<String> collarNum = ['One', 'Two', 'Three', 'Four'];
  String _currentState = 'One';
  DateTime? selectedDate;

  final TextEditingController heightController = TextEditingController();
  final TextEditingController waistController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateFormat inputFormat = DateFormat('dd-MMMM-yyyy');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name;
    heightController.text = widget.user.userHeight;
    waistController.text = widget.user.userWaist;
    phoneNumController.text = widget.user.userPhoneNumber;
    phoneNumController.text = widget.user.userPhoneNumber;
    selectedDate = inputFormat.parse(widget.user.deliveryDate);
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: deviceHeight * 0.09),
              Row(
                children: [
                  Text("Daniyal Designers",
                      style: TextStyles.largeHeadingStyles),
                  SizedBox(width: deviceWidth * 0.2),
                  Text(
                    'Date: ${DateFormat('dd-MM-yy').format(date)}',
                  ),
                ],
              ),
              const Divider(),
              SizedBox(height: deviceHeight * 0.05),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Your Height:"),
                            SizedBox(height: deviceHeight * 0.01),
                            TextFormField(
                              controller: heightController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                isDense: true,
                                constraints:
                                    BoxConstraints(maxWidth: deviceWidth * 0.4),
                                hintText: "Enter Hight",
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
                            const Text("Your waist:"),
                            SizedBox(height: deviceHeight * 0.01),
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
                        const Text("Your Collar Number:"),
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
                                _currentState = newValueSelected!;
                              });
                            },
                            value: _currentState,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text("Your Name"),
                        SizedBox(height: deviceHeight * 0.01),
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            hintText: "Enter Name",
                            border: OutlineInputBorder(),
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
                          decoration: const InputDecoration(
                            hintText: "Enter Phone Number",
                            border: OutlineInputBorder(),
                          ),
                          validator: Validator.validatePhoneNumber,
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.01),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: deviceWidth * 0.09),
                        const Text("Delivery Date:"),
                        TextFormField(
                          validator: Validator.validateDate,
                          readOnly: true,
                          controller: dateController,
                          decoration: InputDecoration(
                              hintText: selectedDate != null
                                  ? DateFormat('dd-MMMM-yyyy')
                                      .format(selectedDate!)
                                  : 'Select Date'),
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
                    FirebaseCRUD().updateUser(
                      User(
                          id: widget.user.id,
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
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
