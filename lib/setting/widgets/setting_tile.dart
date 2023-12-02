import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/setting/models/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingTile extends StatefulWidget {
  final Setting setting;

  const SettingTile({
    Key? key,
    required this.setting,
  }) : super(key: key);

  @override
  _SettingTileState createState() => _SettingTileState();
}

class _SettingTileState extends State<SettingTile> {

  List<String> languages = ['English', 'Bahasa Indonesia', 'Français', 'Japanese', 'German'];
  late String selectedLanguage;
  late String tempSelectedLanguage;

  @override
  void initState() {
    super.initState();
    loadLanguage(); 
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('language') ?? 'English';
      tempSelectedLanguage = selectedLanguage;
    });
  }

  GlobalKey dropdownKey = GlobalKey();

  Future<void> saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.setting.title == 'Help') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Help'),
                content: Text('You are going to be forwarded to customer service. Click confirm if you need help.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Confirm'),
                  ),
                ],
              );
            },
          );
        } else if (widget.setting.title == 'Log-Out') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Log-Out'),
                content: Text('Are you sure you want to log-out from your account?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, '/logout');
                    },
                    child: Text('Confirm'),
                  ),
                ],
              );
            },
          );
        } else if (widget.setting.title == 'Sync') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Sync'),
                content: Text('Sync your massage?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Confirm'),
                  ),
                ],
              );
            },
          );
        } else if (widget.setting.title == 'Language') {
          showDialogForLanguage(context);
        } else {
          Navigator.pushNamed(context, widget.setting.routes);
        }
      },
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: klightContentColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(widget.setting.icon, color: kprimaryColor),
          ),
          const SizedBox(width: 10),
          Text(
            widget.setting.title,
            style: const TextStyle(
              color: kprimaryColor,
              fontSize: ksmallFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Icon(
            CupertinoIcons.chevron_forward,
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }

  void showDialogForLanguage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Container(
            height: 80,
            child: Column(
              children: <Widget>[
                Text('Choose your preferred language:'),
                SizedBox(height: 10),
                DropdownButton<String>(
                  key: dropdownKey,
                  value: tempSelectedLanguage,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        tempSelectedLanguage = newValue;
                      });
                    }
                  },
                  items: languages.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  tempSelectedLanguage = selectedLanguage;
                });
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                saveLanguage(tempSelectedLanguage);
                setState(() {
                  selectedLanguage = tempSelectedLanguage;
                });

                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}