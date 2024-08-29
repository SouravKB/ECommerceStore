import 'dart:developer';

import 'package:ecommercestore/models/ui/shop.dart';
import 'package:ecommercestore/repositories/shop_repo.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/input_decoration.dart';
import 'package:ecommercestore/widgets/text_form_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ShopRegister extends StatefulWidget {
  const ShopRegister({Key? key}) : super(key: key);

  @override
  _ShopRegisterState createState() => _ShopRegisterState();
}

class _ShopRegisterState extends State<ShopRegister> {
  String? name;
  String? email;
  String? phoneNo;
  String? gstId;
  TimeOfDay closeTime = const TimeOfDay(hour: 21, minute: 0);
  TimeOfDay openTime = const TimeOfDay(hour: 9, minute: 0);
  String? address;

  final _formKey = GlobalKey<FormState>();
  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: const MyAppBar(
          title: 'register shop',
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Register a new shop",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                      decoration: const MyInputDecoration(
                        prefixIcon: Icon(
                          Icons.shop,
                          size: 30,
                        ),
                        labelText: "Shop",
                      ),
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                      maxLength: 40,
                      validator: (name) {
                        if (name.toString().isEmpty) {
                          return 'enter the name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    MyTextFormField(
                      decoration: const MyInputDecoration(
                        prefixIcon: Icon(
                          Icons.shopping_cart,
                          size: 30,
                        ),
                        labelText: "GST Number",
                      ),
                      maxLength: 15,
                      onChanged: (val) {
                        setState(() {
                          gstId = val;
                        });
                      },
                      validator: (gstId) {
                        String pattern =
                            r'^([0][1-9]|[1-2][0-9]|[3][0-7])([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$';
                        RegExp regExp = RegExp(pattern);
                        if (gstId.toString().isEmpty) {
                          return 'enter the gstId';
                        } else if (regExp.hasMatch(gstId)) {
                          return 'invalid gstId';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      decoration: const MyInputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          size: 30,
                        ),
                        labelText: "PHONE NUMBER",
                      ),
                      onChanged: (val) {
                        setState(() {
                          phoneNo = val;
                        });
                      },
                      validator: (value) {
                        String pattern = r'^(?:[+0]9)?[0-9]{10}$';
                        RegExp regExp = RegExp(pattern);
                        if (value.length == 0) {
                          return 'Please enter mobile number';
                        } else if (!regExp.hasMatch(value)) {
                          return 'Please enter valid mobile number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      controller: fieldText,
                      autofillHints: const [AutofillHints.email],
                      decoration: MyInputDecoration(
                        prefixIcon: const Icon(
                          Icons.mail,
                          size: 30,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            clearText();
                          },
                        ),
                        labelText: "EMAIL",
                      ),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (email) {
                        if (email.length == 0) {
                          return 'Please enter the email id';
                        } else if (!EmailValidator.validate(email)) {
                          return 'Please enter a valid email id';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                      decoration: const MyInputDecoration(
                        prefixIcon: Icon(
                          Icons.location_city,
                          size: 30,
                        ),
                        labelText: "address",
                      ),
                      onChanged: (val) {
                        setState(() {
                          address = val;
                        });
                      },
                      maxLength: 70,
                      validator: (address) {
                        if (name.toString().isEmpty) {
                          return 'address';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              final pickTime = await showTimePicker(
                                context: context,
                                initialTime: openTime,
                                initialEntryMode: TimePickerEntryMode.dial,
                              );
                              setState(() async {
                                openTime = pickTime ?? openTime;
                              });
                            },
                            child: InputDecorator(
                              decoration:
                                  const InputDecoration(labelText: 'open Time'),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(openTime.format(context)),
                                  Icon(Icons.arrow_drop_down,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.grey.shade700
                                          : Colors.white70),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: closeTime,
                                initialEntryMode: TimePickerEntryMode.dial,
                              );
                              log(pickedTime?.format(context) ?? 'null');
                              setState(() {
                                closeTime = pickedTime ?? closeTime;
                              });
                            },
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                  labelText: 'close Time'),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(closeTime.format(context)),
                                  Icon(Icons.arrow_drop_down,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.grey.shade700
                                          : Colors.white70),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                          child: const Text(
                            "Register Shop",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            final res = await locationFromAddress(address!);
                            final location = res.first;
                            if (_formKey.currentState!.validate()) {
                              Shop shop = Shop(
                                  shopId: gstId!,
                                  name: name!,
                                  type: '',
                                  phoneNos: [phoneNo!],
                                  emailIds: [email!],
                                  address: address!,
                                  location: location,
                                  openTime: openTime,
                                  closeTime: closeTime,
                                  isOpenNow: true,
                                  shopPicUrl: null,
                                  ownerIds: [
                                    auth.FirebaseAuth.instance.currentUser!.uid
                                  ]);
                              ShopRepo.instance.addShop(shop);
                              Navigator.pop(context);
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
