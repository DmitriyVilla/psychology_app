import 'package:flutter/material.dart';
import '../domain/category.dart';


class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: colorScheme.primary,
      child: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(category.icon, size: 40, color: Colors.deepPurple),
            // const SizedBox(height: 8.0),            
            Text(
              category.showName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class CategoryCard extends StatelessWidget {
//   final Category category;

//   const CategoryCard({super.key, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     var colorScheme = Theme.of(context).colorScheme;

//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       color: colorScheme.primary,
//       child: SizedBox(
//         width: 150,
//         height: 150,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Icon(category.icon, size: 40, color: Colors.deepPurple),
//             // const SizedBox(height: 8.0),
//             Text(
//               category.showName,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.bold,
//                 color: colorScheme.onPrimary,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }