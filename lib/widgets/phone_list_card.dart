import 'dart:developer';


import 'package:ecommercestore/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class PhoneListCard extends StatefulWidget {
  const PhoneListCard({Key? key, required this.list}) : super(key: key);

  final List<String> list;

  @override
  _PhoneListCardState createState() => _PhoneListCardState();
}

class _PhoneListCardState extends State<PhoneListCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:widget.list.length,
                itemBuilder: (context,index) {
                  return ListTile(
                    leading: const Icon(Icons.phone),
                    title: MyTextFormField(
                      initialValue: widget.list[index].toString(),
                      validator: (value) {
                        String pattern = r'^(?:[+0]9)?[0-9]{10}$';
                        RegExp regExp = RegExp(pattern);
                        if (value.length == 0) {
                          return 'Please enter mobile number';
                        }
                        else if (!regExp.hasMatch(value)) {
                          return 'Please enter valid mobile number';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        widget.list[index] = text;
                      },
                    ),
                    trailing: (index!=0) ?  InkWell(
                        onTap: () {
                          setState(() {
                            widget.list.removeAt(index);
                          });
                        },
                        child: const Icon(Icons.remove_circle)
                    ) : null,
                  );
                }
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    widget.list.add('');
                  });
                },
                child: const Text('+Add phone no'))
          ],
        )
    );
  }
}


/*class PhoneListCard extends StatelessWidget {
  const PhoneListCard({Key? key, required this.list}) : super(key: key);

  final List<String> list;
  @override
  Widget build(BuildContext context) {
    log('listCard');
    return Card(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
            itemCount:list.length,
            itemBuilder: (context,index) {
              return ListTile(
                leading: const Icon(Icons.phone),
                title: MyTextFormField(
                  initialValue: list[index].toString(),
                ),
                trailing: (index!=0) ?  InkWell(
                  onTap: () {
                    set
                  },
                    child: Icon(Icons.remove_circle)
                ) : null,
              );
            }
        )
    );
  }
}*/
