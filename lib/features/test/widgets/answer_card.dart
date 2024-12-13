// import 'package:flutter/material.dart';

// class AnswerCard extends StatelessWidget {
//   final String text;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const AnswerCard({
//     super.key,  
//     required this.text,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.green.withOpacity(0.7) : Colors.white.withOpacity(0.8),
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: isSelected ? Colors.green : Colors.transparent,
//             width: 2,
//           ),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 16,
//             color: isSelected ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
