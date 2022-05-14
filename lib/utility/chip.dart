import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String? title;
  final String? image;
  final IconData? icon;
  const CustomChip({
    this.title,
    this.image,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      elevation: 8.0,
      padding: const EdgeInsets.all(2.0),
      avatar: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            icon,
            color: Colors.red,
            size: 20,
          )
          // Icon(
          //   Icons.mode_comment,

          // ),
          ),
      label: Text('$title'),
      onPressed: () {
        // _key.currentState.showSnackBar(SnackBar(
        //   content: Text('Message...'),
        // ));
      },
      backgroundColor: Colors.grey[200],
      shape: const StadiumBorder(
          side: BorderSide(
        width: 1,
        color: Colors.white,
      )),
    );
  }
}
