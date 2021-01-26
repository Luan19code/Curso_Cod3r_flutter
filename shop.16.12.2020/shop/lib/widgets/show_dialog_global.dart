// import 'package:flutter/material.dart';
// import 'package:shop/utils/screen_size.dart';

// Future<bool> showDialogGlobal(
//   BuildContext context,
//   String textTitle,
//   String textContent,
//   List<Widget> textActions,
// ) {
//   return showDialog(
//     barrierDismissible: true,
//     context: context,
//     builder: (BuildContext context) {
//       // retorna um objeto do tipo Dialog
//       return AlertDialog(
//         title: Text(
//           textTitle,
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: screenHeight(context) * 0.03),
//         ),
//         content: Container(
//           height: screenHeight(context) * 0.15,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 textContent,
//                 style: TextStyle(fontSize: 25),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: textActions,
//           ),
//         ],
//         elevation: 24.0,
//       );
//     },
//   );
// }
