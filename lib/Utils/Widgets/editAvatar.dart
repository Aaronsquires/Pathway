// import 'package:flutter/material.dart';
// import 'package:pathwayv1/values/values.dart';

// class EditAvatar extends StatelessWidget {
//   const EditAvatar({@required this.photoUrl, this.onPressed});
//   final String photoUrl;
//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: <Widget>[
//       CircleAvatar(
//         radius: 70,
//         backgroundColor: AppColors.secondaryColor,
//         child: CircleAvatar(
//           radius: 67,
//           backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : AssetImage('assets/images/UserImage.png'),
//         ),
//       ),
//       //Button
//       Positioned(
//         left: 78,
//         top: 85,
//         child: RaisedButton(
//           onPressed: onPressed,
//           shape: CircleBorder(),
//           color: AppColors.secondaryColor,
//           child: Icon(
//             Icons.camera_alt,
//             color: AppColors.primaryTextColor,
//           ),
//         ),
//       )
//     ]);
//   }
// }
