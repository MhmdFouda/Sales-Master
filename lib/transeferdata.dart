// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> moveCollectionsToUser(String userId) async {
//   // Step 1: Retrieve data from existing collections
//   final productQuerySnapshot =
//       await FirebaseFirestore.instance.collection('products').get();
//   final clientQuerySnapshot =
//       await FirebaseFirestore.instance.collection('clients').get();
//   final orderQuerySnapshot =
//       await FirebaseFirestore.instance.collection('orders').get();

//   // Step 2: Restructure the data
//   final productData = {
//     'products': _getDocumentsAsMap(productQuerySnapshot),
//   };
//   final clientData = {
//     'clients': _getDocumentsAsMap(clientQuerySnapshot),
//   };
//   final orderData = {
//     'orders': _getDocumentsAsMap(orderQuerySnapshot),
//   };

//   // Step 3: Update the user document
//   final userDocRef = FirebaseFirestore.instance.collection('users').doc(userId);
//   await userDocRef.update({
//     'products': productData,
//     'clients': clientData,
//     'orders': orderData,
//   });

//   // Step 4: Verify the data
//   final updatedUserDocSnapshot = await userDocRef.get();
//   print('Updated User Data: ${updatedUserDocSnapshot.data()}');
// }

// Map<String, dynamic> _getDocumentsAsMap(QuerySnapshot snapshot) {
//   final dataMap = <String, dynamic>{};
//   for (final docSnapshot in snapshot.docs) {
//     dataMap[docSnapshot.id] = docSnapshot.data;
//   }
//   return dataMap;
// }
