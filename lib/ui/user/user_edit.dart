import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:ecommercestore/models/ui/user.dart';
import 'package:ecommercestore/repositories/user_repo.dart';
import 'package:ecommercestore/services/storage_service.dart';
import 'package:ecommercestore/util/image_picker.dart';
import 'package:ecommercestore/widgets/address_list_card.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/email_list_card.dart';
import 'package:ecommercestore/widgets/phone_list_card.dart';
import 'package:ecommercestore/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

class UserEdit extends StatefulWidget {
  UserEdit({Key? key, required this.user}) : super(key: key);

  final User user;

  final userStream = UserRepo.instance
      .getUserStream(auth.FirebaseAuth.instance.currentUser!.uid);

  @override
  _UserEditState createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  final _formKey = GlobalKey<FormState>();
  File? image;
  String? imageUrl;
  String? name;
  List<String>? emailIds;
  List<String>? phoneNos;
  List<String>? addresses;
  final _imageInput = ImageChooser.instance;

  @override
  void initState() {
    super.initState();
    name = widget.user.name;
    imageUrl = widget.user.profilePicUrl;
    emailIds = List.from(widget.user.emailIds);
    phoneNos = widget.user.phoneNos.toList();
    addresses = List.from(widget.user.addresses);
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

  @override
  Widget build(BuildContext context) {
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

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: const MyAppBar(
          title: 'User edit',
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
                    height: 10,
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.account_circle),
                      title: MyTextFormField(
                        initialValue: name,
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                        validator: (name) {
                          log(name);
                          if (name.length == 0) {
                            return 'enter the Name';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
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
                  AddressListCard(
                    list: addresses!,
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (image != null) {
                imageUrl =
                    await StorageService.instance.uploadFile(image!, 'users');
              }
              UserRepo.instance.updateUser(User(
                  userId: widget.user.userId,
                  name: name!,
                  profilePicUrl: imageUrl,
                  phoneNos: phoneNos!,
                  emailIds: emailIds!,
                  addresses: addresses!));
              Navigator.pop(context);
            }
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
