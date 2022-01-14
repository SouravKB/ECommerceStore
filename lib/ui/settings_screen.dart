import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';



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
            title: 'Common',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: const Icon(Icons.language),
                onTap: () {

                },
              ),

            ],
          ),
          SettingsSection(
            title: 'Account',
            tiles: [
              SettingsTile(title: 'Phone number', leading: Icon(Icons.phone),onTap: () {

              },),
              SettingsTile(title: 'Email', leading: Icon(Icons.email),onTap: () {

              },),
              SettingsTile(title: 'Sign out', leading: Icon(Icons.exit_to_app),onTap: () {

              },),
            ],
          ),
          SettingsSection(
            title: 'Secutiry',
            tiles: [

              SettingsTile.switchTile(
                title: 'Change password',
                leading: Icon(Icons.lock),
                switchValue: lockInBackground,
                onToggle: (bool value) {
                     setState(() {
                      lockInBackground = value;
                  }
      );
    }

              ),
            ],
          ),

        ],
      ),
    );
  }
}