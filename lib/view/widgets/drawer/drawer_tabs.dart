import 'package:flutter/material.dart';



class DrawerTab extends StatelessWidget {
  const DrawerTab({
    super.key, required this.icon, required this.tabName, required this.onTap,
  });

  final IconData icon;
  final String tabName;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(

      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,color: Colors.black,),
          SizedBox(
            width: 10,
          ),
          Text(tabName,

            style: TextStyle(
              fontSize: 18
            ),)
        ],

      ),

      onTap: onTap,
    );
  }
}