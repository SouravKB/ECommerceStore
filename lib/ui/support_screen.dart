import 'package:flutter/material.dart';
class Support extends StatefulWidget {
  const Support({Key? key}) : super(key: key);

  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Support'),
        ),
        body:ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                color: Colors.amber[600],
                child: const Center(child: Text('What issue are you facing?')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                color: Colors.amber[100],
                child: Material(
                  child: ListTile(
                    title: const Text('I want to track my order'),
                    subtitle: Text('Check order status '),

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                color: Colors.amber[100],
                child: Material(
                  child: ListTile(
                    title: const Text('I want help with returns & refunds'),
                    subtitle: Text('Manage and track returns'),

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                color: Colors.amber[100],
                child: Material(
                  child: ListTile(
                    title: const Text('I want to manage my security issue'),
                    subtitle: Text('Signin ,logout etc..'),

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                color: Colors.amber[100],
                child: Material(
                  child: ListTile(
                    title: const Text('I want help with other issues'),
                    subtitle: Text('offers, payment & all other issues'),

                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
