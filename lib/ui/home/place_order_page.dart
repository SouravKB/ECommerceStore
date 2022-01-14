import 'package:ecommercestore/models/ui/user.dart';
import 'package:ecommercestore/models/ui/order.dart';
import 'package:ecommercestore/repositories/order_repo.dart';
import 'package:ecommercestore/repositories/user_repo.dart';
import 'package:ecommercestore/ui/home/user_edit.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

class PlaceOrderPage extends StatefulWidget {
  PlaceOrderPage({Key? key, required this.shopId, required this.orderMap})
      : super(key: key);

  String shopId;
  Map<String, int> orderMap;

  @override
  _PlaceOrderPageState createState() => _PlaceOrderPageState();
}

class _PlaceOrderPageState extends State<PlaceOrderPage> {
  String? address;
  String? phoneNo;
  PaymentMethod? paymentMethod;

  static const valAddPhoneNo = '**add phone no**';
  static const valAddAddress = '**add address**';

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Place the order',
      ),
      body: StreamBuilder<User>(
          stream: UserRepo.instance
              .getUserStream(auth.FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if(snapshot.data == null){
              return const SizedBox.shrink();
            }
            return Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: DropdownButton<String>(
                      items: snapshot.data!.phoneNos
                              .map((phoneNo) => DropdownMenuItem(
                                    value: phoneNo,
                                    child: Text(phoneNo),
                                  ))
                              .toList() +
                          [
                            const DropdownMenuItem(
                                value: valAddPhoneNo,
                                child: Text('+Add PhoneNo...')),
                          ],
                      onChanged: (value) => setState(() {
                        if (value == valAddPhoneNo) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UserEdit(user: snapshot.data!);
                          }));
                        } else {
                          phoneNo = value;
                        }
                      }),
                      value: phoneNo,
                      hint: const Text('phone no'),
                      isExpanded: true,
                      iconSize: 36,
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: DropdownButton<String>(
                      items: snapshot.data!.addresses
                              .map((address) => DropdownMenuItem(
                                    value: address,
                                    child: Text(address),
                                  ))
                              .toList() +
                          [
                            const DropdownMenuItem(
                                value: valAddAddress,
                                child: Text('+Add address')),
                          ],
                      onChanged: (value) => setState(() {
                        if (value == valAddAddress) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UserEdit(user: snapshot.data!);
                          }));
                        } else {
                          address = value;
                        }
                      }),
                      value: address,
                      hint: const Text('address'),
                      isExpanded: true,
                      iconSize: 36,
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: DropdownButton<PaymentMethod>(
                      items: PaymentMethod.values
                          .map((paymentMethod) => DropdownMenuItem(
                                value: paymentMethod,
                                child: Text(paymentMethod.toString()),
                              ))
                          .toList(),
                      onChanged: (value) => setState(() {
                        paymentMethod = value;
                      }),
                      value: paymentMethod,
                      hint: const Text('payment method'),
                      isExpanded: true,
                      iconSize: 36,
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.black,
                      ),
                    ),
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
                            "Send",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (phoneNo != null &&
                                address != null &&
                                paymentMethod != null) {
                              Order order = Order(
                                  orderId: '',
                                  userId: snapshot.data!.userId,
                                  shopId: widget.shopId,
                                  price: widget.orderMap['price']!,
                                  productIdsWithCount: widget.orderMap..remove('price'),
                                  orderDateTime: DateTime.now(),
                                  phoneNo: phoneNo!,
                                  address: address!,
                                  payMethod: paymentMethod!);
                              OrderRepo.instance.addOrder(order);
                              Navigator.pop(context);
                            } else {
                              _showToast(
                                  context, 'enter all the items correctly');
                            }
                          })),
                ],
              ),
            );
          }),
    );
  }
}
