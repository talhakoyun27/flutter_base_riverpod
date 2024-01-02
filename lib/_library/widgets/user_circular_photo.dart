// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// class UserCirclePhoto extends StatelessWidget {
//   const UserCirclePhoto(
//       {super.key, required this.size, this.border, required this.url});
//   final double size;
//   final String? url;
//   final BoxBorder? border;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: size,
//       width: size,
//       child: url != null
//           ? CachedNetworkImage(
//               imageUrl: url ?? "",
//               placeholder: (context, url) => const CircleAvatar(
//                 radius: 10,
//               ),
//               imageBuilder: (context, imageProvider) => Container(
//                 // height: sizeConfig.widthSize(context, size),
//                 // width: sizeConfig.widthSize(context, size),
//                 decoration: BoxDecoration(
//                   border: border,
//                   shape: BoxShape.circle,
//                   image:
//                       DecorationImage(image: imageProvider, fit: BoxFit.cover),
//                 ),
//               ),
//             )
//           : Container(
//               // height: sizeConfig.widthSize(context, size),
//               // width: sizeConfig.widthSize(context, size),
//               decoration: BoxDecoration(
//                 border: border,
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                     image: AssetImage(appImages.userPng), fit: BoxFit.cover),
//               ),
//             ),
//     );
//   }
// }
