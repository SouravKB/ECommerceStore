import 'dart:developer';
import 'dart:io';

import 'package:ecommercestore/models/ui/shop.dart';
import 'package:ecommercestore/repositories/shop_repo.dart';
import 'package:ecommercestore/services/storage_service.dart';
import 'package:ecommercestore/util/image_picker.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/email_list_card.dart';
import 'package:ecommercestore/widgets/input_decoration.dart';
import 'package:ecommercestore/widgets/phone_list_card.dart';
import 'package:ecommercestore/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ShopEdit extends StatefulWidget {
  ShopEdit({Key? key, required this.shop}) : super(key: key);

  Shop shop;

  @override
  _ShopEditState createState() => _ShopEditState();
}

class _ShopEditState extends State<ShopEdit> {
  final _formKey = GlobalKey<FormState>();
  File? image;
  String? name;
  String? address;
  List<String>? phoneNos;
  List<String>? emailIds;
  TimeOfDay? closeTime;
  TimeOfDay? openTime;
  String? imageUrl;
  bool? isOpenNow;
  final _imageInput = ImageChooser.instance;

  @override
  void initState() {
    super.initState();
    name = widget.shop.name;
    address = widget.shop.address;
    phoneNos = List.from(widget.shop.phoneNos);
    emailIds = List.from(widget.shop.emailIds);
    closeTime = widget.shop.closeTime;
    openTime = widget.shop.openTime;
    imageUrl = widget.shop.shopPicUrl;
    isOpenNow = widget.shop.isOpenNow;
  }

  Future<bool> _onBackPressed() async {
    final res = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        log("builder");
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Save your changes or discard them'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: const Text('Discard'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: const Text('save'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
    return res;
  }

  Future<File?> _showPicker(context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () async {
                  log('image input');
                  log('image input taken');
                  final image = await _imageInput.getImage(true);
                  Navigator.pop(context, image);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  final image = await _imageInput.getImage(false);
                  Navigator.pop(context, image);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: const MyAppBar(
          title: 'Shop edit',
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            final pickedImage = await _showPicker(context);
                            setState(() {
                              image = pickedImage ?? image;
                            });
                          },
                          child: CircleAvatar(
                            radius: 70,
                            child: ClipOval(
                              child: image == null
                                  ? imageUrl == null
                                  ? Image.asset(
                                'assets/images/flower.webp',
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              )
                                  : Image.network(
                                imageUrl!,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              )
                                  : Image.file(
                                image!,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 1,
                            right: 1,
                            child: Container(
                              height: 40,
                              width: 40,
                              child: const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              ),
                              decoration: const BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextFormField(
                    initialValue: name,
                    decoration: const MyInputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        size: 30,
                      ),
                      labelText: "NAME",
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
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextFormField(
                    initialValue: address,
                    decoration: const MyInputDecoration(
                      prefixIcon: Icon(
                        Icons.location_city,
                        size: 30,
                      ),
                      labelText: "ADDRESS",
                    ),
                    onChanged: (val) {
                      setState(() {
                        address = val;
                      });
                    },
                    maxLength: 40,
                    validator: (address) {
                      if (address.toString().isEmpty) {
                        return 'Enter the address';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PhoneListCard(
                    list: phoneNos!,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  EmailListCard(
                    list: emailIds!,
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
                              initialTime: openTime!,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(openTime != null
                                    ? openTime!.format(context)
                                    : TimeOfDay.now().format(context)),
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
                              initialTime: closeTime!,
                              initialEntryMode: TimePickerEntryMode.dial,
                            );
                            log(pickedTime?.format(context) ?? 'null');
                            setState(() {
                              closeTime = pickedTime ?? closeTime;
                            });
                          },
                          child: InputDecorator(
                            decoration:
                                const InputDecoration(labelText: 'close Time'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(closeTime != null
                                    ? closeTime!.format(context)
                                    : TimeOfDay.now().format(context)),
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
                  Card(
                    child: Row(
                      children: [
                        const Expanded(child: Text('Is shop Open')),
                        Expanded(
                          child: Switch(
                            value: isOpenNow!,
                            onChanged: (value) {
                              setState(() {
                                isOpenNow = value;
                              });
                            },
                            activeColor: Colors.white,
                            activeTrackColor: Colors.pinkAccent,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final res = await locationFromAddress(address!);
            final location = res.first;
            if (_formKey.currentState!.validate()) {
              if (image != null) {
                imageUrl =
                await StorageService.instance.uploadFile(image!, 'shops');
              }
              ShopRepo.instance.updateShop(Shop(
                  shopPicUrl: imageUrl,
                  name: name!,
                  type: widget.shop.type,
                  phoneNos: phoneNos!,
                  emailIds: emailIds!,
                  address: address!,
                  location: location,
                  shopId: widget.shop.shopId,
                  isOpenNow: isOpenNow!,
                  openTime: openTime!,
                  ownerIds: widget.shop.ownerIds,
                  closeTime: closeTime!));
              Navigator.pop(context);
            }
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
