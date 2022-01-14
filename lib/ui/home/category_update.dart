import 'package:ecommercestore/repositories/product_repo.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/input_decoration.dart';
import 'package:ecommercestore/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class CategoryUpdate extends StatefulWidget {
  CategoryUpdate({Key? key,required this.category,required this.shopId}) : super(key: key);

  String category;
  String shopId;

  @override
  _CategoryUpdateState createState() => _CategoryUpdateState();
}

class _CategoryUpdateState extends State<CategoryUpdate> {

  final _formKey = GlobalKey<FormState>();

  late String newCategory;


  @override
  void initState() {
    super.initState();
    newCategory=widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Category Update',
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  MyTextFormField(
                    initialValue: newCategory,
                    decoration: const MyInputDecoration(
                      prefixIcon: Icon(
                        Icons.category,
                        size: 30,
                      ),
                      labelText: "Category",
                    ),
                    onChanged: (val) {
                      setState(() {
                        newCategory = val;
                      });
                    },
                    validator: (category) {
                      if(category.toString().isEmpty) {
                        return 'Enter the category';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Theme
                                  .of(context)
                                  .primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                          child: const Text(
                            "Update",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              ProductRepo.instance.updateProductCategoryForCategory(widget.shopId,widget.category,newCategory);
                              Navigator.pop(context);
                            }
                          }
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}










/*import 'dart:developer';
import 'dart:io';

import 'package:ecommercestore/repositories/product_repo.dart';
import 'package:ecommercestore/util/image_storing.dart';
import 'package:ecommercestore/ui/home/category_page.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/input_decoration.dart';
import 'package:ecommercestore/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class CategoryInput extends StatefulWidget {
   CategoryInput({Key? key,this.categoryId,required this.shopId}) : super(key: key);

  String? categoryId;
  String shopId;

  @override
  _CategoryInputState createState() => _CategoryInputState();


}

class _CategoryInputState extends State<CategoryInput> {

  final _formKey = GlobalKey<FormState>();
  String? name;
  String? imageUrl;
  File? image;
  final _imageInput=ImageStoring.instance;
  late final categoriesStream = ProductRepo.instance.getCategoriesStream(widget.shopId);

  @override
  void initState(){
    getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log((ModalRoute.of(context)?.settings.name.toString() ?? 'null')+'cat_in');
    log('building');
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Category Input',
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children:<Widget> [
                    Stack(
                      children: <Widget>[
                        if(imageUrl!=null)
                          GestureDetector(
                            onTap: () async {
                              _showPicker(context);
                            },
                            child: CircleAvatar(
                              radius: 70,
                              child: ClipOval(child: Image.network(imageUrl!, height: 150, width: 150, fit: BoxFit.cover,),),
                            ),
                          )
                        else
                          GestureDetector(
                            onTap: () async {
                              _showPicker(context);
                            },
                            child: CircleAvatar(
                              radius: 70,
                              child: ClipOval(child: Image.asset('assets/images/flower.webp', height: 150, width: 150, fit: BoxFit.cover,),),
                            ),
                          ),
                        Positioned(bottom: 1, right: 1 ,child: Container(
                          height: 40, width: 40,
                          child: const Icon(Icons.add_a_photo, color: Colors.white,),
                          decoration: const BoxDecoration(
                              color: Colors.pinkAccent,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if(name==null)
                      MyTextFormField(
                        decoration: const MyInputDecoration(
                          labelText: "Category Name",
                        ),
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                        validator: (name) {
                          log(name);
                          if(name.length==0){
                            return 'enter the name';
                          }
                          else{
                            return null;
                          }
                        },
                      )
                    else
                      MyTextFormField(
                        initialValue: name,
                        decoration: const MyInputDecoration(
                          labelText: "Category Name",
                        ),
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                        validator: (name) {
                          if(name.length==0){
                            return 'enter the name';
                          }
                          else{
                            return null;
                          }
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
                                  final category=Category(categoryId: widget.categoryId ?? '', name:name!, imageUrl: imageUrl);
                                  categoryInstance.addCategory(widget.shopId, category);
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) => CategoryPage(shopId: widget.shopId),
                                  )
                                  );
                                }
                              })),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
  Future<void> getCategory() async {
    if(widget.categoryId!=null){
      Category category=categoryInstance.getCategoryStream(widget.shopId, widget.categoryId!) as Category;
      name=category.name;
      imageUrl=category.imageUrl;
      setState(() {

      });
    }
  }
  void _showPicker(context) {
    showModalBottomSheet(
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
                      Navigator.of(context).pop();
                      log('image input taken');
                      image = await _imageInput.getImage(true);
                      if(image != null) {
                        imageUrl=await _imageInput.uploadFile(image!,'categories');
                      }

                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    image= await _imageInput.getImage(false);
                    if(image != null) {
                      imageUrl=await _imageInput.uploadFile(image!,'categories');
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
    );
  }
}*/
