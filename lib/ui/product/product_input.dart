import 'dart:developer';
import 'dart:io';

import 'package:ecommercestore/models/ui/product.dart';
import 'package:ecommercestore/repositories/product_repo.dart';
import 'package:ecommercestore/util/image_picker.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/input_decoration.dart';
import 'package:ecommercestore/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class ProductInput extends StatefulWidget {
  const ProductInput({
    Key? key,
    required this.shopId,
    this.product,
    this.category,
  }) : super(key: key);

  final String shopId;
  final Product? product;
  final String? category;

  @override
  _ProductInputState createState() => _ProductInputState();
}

class _ProductInputState extends State<ProductInput> {
  final productRepo = ProductRepo.instance;

  final _formKey = GlobalKey<FormState>();
  String? name;
  String? imageUrl;
  String? shortDesc;
  int? price;
  String? desc;
  File? image;
  String? category;
  final _imageInput = ImageChooser.instance;

  @override
  void initState() {
    super.initState();
    name = (widget.product != null) ? widget.product!.name : null;
    imageUrl = (widget.product != null) ? widget.product!.imageUrl : null;
    shortDesc = (widget.product != null) ? widget.product!.shortDesc : null;
    price = (widget.product != null) ? widget.product!.price : null;
    desc = (widget.product != null) ? widget.product!.desc : null;
    category =
        widget.product != null ? widget.product!.category : widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Product Input',
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
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
                  const SizedBox(
                    height: 10,
                  ),
                  if (name == null)
                    MyTextFormField(
                      decoration: const MyInputDecoration(
                        labelText: "Name",
                      ),
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
                    )
                  else
                    MyTextFormField(
                      initialValue: name,
                      decoration: const MyInputDecoration(
                        labelText: "Name",
                      ),
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                      validator: (name) {
                        if (name.length == 0) {
                          return 'enter the Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (price == null)
                    MyTextFormField(
                      decoration: const MyInputDecoration(
                        labelText: "Cost",
                      ),
                      onChanged: (val) {
                        setState(() {
                          price = int.parse(val);
                        });
                      },
                      keyboardType: TextInputType.number,
                      validator: (name) {
                        log(name);
                        if (name.length == 0) {
                          return 'enter the cost';
                        } else {
                          return null;
                        }
                      },
                    )
                  else
                    MyTextFormField(
                      initialValue: price.toString(),
                      decoration: const MyInputDecoration(
                        labelText: "Category Name",
                      ),
                      onChanged: (val) {
                        setState(() {
                          price = int.parse(val);
                        });
                      },
                      keyboardType: TextInputType.number,
                      validator: (cost) {
                        if (cost.length == 0) {
                          return 'enter the cost';
                        } else {
                          return null;
                        }
                      },
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (shortDesc == null)
                    MyTextFormField(
                      decoration: const MyInputDecoration(
                        labelText: "Quantity and count",
                      ),
                      onChanged: (val) {
                        setState(() {
                          shortDesc = val;
                        });
                      },
                      validator: (shortDesc) {
                        log(shortDesc);
                        if (shortDesc.length == 0) {
                          return 'enter the shortDesc';
                        } else {
                          return null;
                        }
                      },
                    )
                  else
                    MyTextFormField(
                      initialValue: shortDesc,
                      decoration: const MyInputDecoration(
                        labelText: "Quantity and Count",
                      ),
                      onChanged: (val) {
                        setState(() {
                          shortDesc = val;
                        });
                      },
                      validator: (shortDesc) {
                        if (shortDesc.length == 0) {
                          return 'enter the Short Description';
                        } else {
                          return null;
                        }
                      },
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (category == null)
                    MyTextFormField(
                      decoration: const MyInputDecoration(
                        labelText: "Category",
                      ),
                      onChanged: (val) {
                        setState(() {
                          category = val;
                        });
                      },
                      validator: (category) {
                        log(category);
                        if (category.length == 0) {
                          return 'enter the category';
                        } else {
                          return null;
                        }
                      },
                    )
                  else
                    MyTextFormField(
                      initialValue: category,
                      decoration: const MyInputDecoration(
                        labelText: "Category",
                      ),
                      onChanged: (val) {
                        setState(() {
                          category = val;
                        });
                      },
                      validator: (category) {
                        if (category.length == 0) {
                          return 'enter the category';
                        } else {
                          return null;
                        }
                      },
                    ),
                  if (desc == null)
                    TextField(
                      decoration: const MyInputDecoration(
                        labelText: 'Description',
                      ),
                      autofocus: false,
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                      autocorrect: true,
                      onChanged: (val) {
                        setState(() {
                          desc = val;
                        });
                      },
                    )
                  else
                    TextField(
                      controller: TextEditingController(text: desc),
                      decoration: const MyInputDecoration(
                        labelText: 'Description',
                      ),
                      autofocus: false,
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                      autocorrect: true,
                      onChanged: (val) {
                        setState(() {
                          desc = val;
                        });
                      },
                    ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )),
                            child: const Text(
                              "save",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              log('save');
                              if (_formKey.currentState!.validate()) {
                                log('saved');
                                final newProduct = Product(
                                    productId: (widget.product != null)
                                        ? widget.product!.productId
                                        : '',
                                    name: name!,
                                    price: price!,
                                    imageUrl: imageUrl,
                                    desc: desc ?? '',
                                    shortDesc: shortDesc!,
                                    category: category!);
                                if (widget.product == null) {
                                  productRepo.addProduct(
                                      widget.shopId, newProduct);
                                } else {
                                  productRepo.updateProduct(
                                      widget.shopId, newProduct);
                                }
                                Navigator.pop(context);
                              }
                            })),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
}
