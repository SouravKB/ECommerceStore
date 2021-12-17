import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
   const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: 200,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
               Center(
                 child: Stack(
                   children: <Widget>[ CircleAvatar(
                      radius: 70,
                     child: ClipOval(child:Image.asset("assets/imgs/test.jpeg",height: 150,width: 150, fit: BoxFit.cover,),),
              ),
              Positioned(
                  right: 1,
                  bottom: 1,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white),
                        ),
                        primary: Colors.white,
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: () {},
                      child: Icon(Icons.camera_alt,color: Colors.black,),

                    ),
                  ),
              )
  ]
                 ),
               ),
            ],
          ),
        ),
        Text('profile name',style: TextStyle(fontSize:20,color: Colors.black),)
      ],
    );
  }

}