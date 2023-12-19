import 'package:cafe_management_system_for_camalti_kahvesi/utils/styles.dart';
import 'package:flutter/material.dart';
import '../pages/settings_page.dart';


class SettingsButton extends StatefulWidget {
  SettingsButton({super.key});
  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
          border: Border.all(width: 3.0),
          // Set border width as needed
          //borderRadius: BorderRadius.circular(30.0), // Set border radius as needed
          color: Colors.amber),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (_, __, ___) =>
                  const SettingsPage(),
              transitionsBuilder: (_, anim, __, child) {
                return ScaleTransition(
                  scale: anim,
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 300),
            ),
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child:Text("Ayarlar",style: CustomStyles.menuTextStyle,),
      ),
    );
  }
}
