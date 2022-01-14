import 'package:ecommercestore/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class AddressListCard extends StatefulWidget {
  AddressListCard({Key? key, required this.list}) : super(key: key);

  List<String> list;

  @override
  _AddressListCardState createState() => _AddressListCardState();
}

class _AddressListCardState extends State<AddressListCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.list.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.home),
                title: MyTextFormField(
                  initialValue: widget.list[index].toString(),
                  validator: (address) {
                    if (address.length == 0) {
                      return ('enter the address');
                    } else {
                      return (null);
                    }
                  },
                  onChanged: (text) {
                    widget.list[index] = text;
                  },
                ),
                trailing: InkWell(
                    onTap: () {
                      setState(() {
                        widget.list.removeAt(index);
                      });
                    },
                    child: const Icon(Icons.remove_circle)),
              );
            }),
        TextButton(
            onPressed: () {
              setState(() {
                widget.list.add('');
              });
            },
            child: const Text('+Add address here'))
      ],
    ));
  }
}
