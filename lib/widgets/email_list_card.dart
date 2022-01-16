import 'package:ecommercestore/widgets/text_form_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailListCard extends StatefulWidget {
  EmailListCard({Key? key,required this.list}) : super(key: key);

  List<String> list;

  @override
  _EmailListCardState createState() => _EmailListCardState();
}

class _EmailListCardState extends State<EmailListCard> {
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
                    leading: const Icon(Icons.email),
                    title: MyTextFormField(
                      initialValue: widget.list[index].toString(),
                      validator: (email){
                        if(email.length==0){
                          return 'Please enter the email id';
                        }
                        else if(!EmailValidator.validate(email)){
                          return 'Please enter a valid email id';
                        }
                        else {
                          return null;
                        }
                      },
                      onChanged: (text) {
                        widget.list[index] = text;
                      },
                    ),
                    trailing: (index!=0) ? InkWell(
                      onTap: () {
                        setState(() {
                          widget.list.removeAt(index);
                        });
                      },
                        child: const Icon(Icons.remove_circle)
                    ): null,
                  );
                }
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    widget.list.add('');
                  });
                },
                child: const Text('+Add email Id')),
          ],
        )
    );
  }
}
