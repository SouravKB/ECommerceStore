import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Common'),
            tiles: [
              SettingsTile(
                title: Text('Language'),
                value: Text('English'),
                leading: Icon(Icons.language),
                onPressed: (context) {},
              ),
            ],
          ),
          SettingsSection(
            title: Text('Account'),
            tiles: [
              SettingsTile(
                title: Text('Phone number'),
                leading: Icon(Icons.phone),
                onPressed: (context) {},
              ),
              SettingsTile(
                title: Text('Email'),
                leading: Icon(Icons.email),
                onPressed: (context) {},
              ),
              SettingsTile(
                title: Text('Sign out'),
                leading: Icon(Icons.exit_to_app),
                onPressed: (context) {},
              ),
            ],
          ),
          SettingsSection(
            title: Text('Secutiry'),
            tiles: [
              SettingsTile.switchTile(
                  title: Text('Change password'),
                  leading: Icon(Icons.lock),
                  initialValue: lockInBackground,
                  onToggle: (bool value) {
                    setState(() {
                      lockInBackground = value;
                    });
                  }),
            ],
          ),

        ],
      ),
    );
  }
}
