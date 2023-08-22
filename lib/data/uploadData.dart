import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../utils/utils.dart';

class Upload {
  void uploadData(id, name, product, model, lot_no, cat_no, expiry, medium,
      distributor_name, image, context) {
    CollectionReference chatsCollection =
        FirebaseFirestore.instance.collection('qrData');

    DocumentReference newMessageRef = chatsCollection.doc();
    Map<String, dynamic> messageData = {
      'id': id,
      'name': name,
      'product': product,
      'analyzer': model,
      'lot_no': lot_no,
      'cat_no': cat_no,
      'expiry': expiry,
      'medium': medium,
      'distributor_name': distributor_name,
      'image': image,
      'timestamp': DateTime.now(),
    };

    newMessageRef.set(messageData).then((value) {
      Utils.toastMessage('Data Enterd Successfully');
    }).catchError((error) {
      Utils.flushBarErrorMessage(error, context);
    });
  }

  Future<String?> uploadImageToFirebaseStorage(Uint8List imageData) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child('qr_images/${DateTime.now()}.png');
    final storageUploadTask = storageRef.putData(imageData);
    await storageUploadTask;
    final downloadUrl = await storageRef.getDownloadURL();
    return downloadUrl;
  }
Future<void> deleteUser(id) async {
 try {
      await FirebaseFirestore.instance.collection('users').doc(id).delete();
      Utils.toastMessage('Document deleted successfully');
    } catch (e) {
      Utils.toastMessage('Error deleting document: $e');
    }
}
  void addUsertoDatabase(String username, String password, context) {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    DocumentReference newMessageRef = usersCollection.doc();
    Map<String, dynamic> messageData = {
      'username': username,
      'password': password,
      'timestamp': DateTime.now(),
    };

    newMessageRef.set(messageData).then((value) {
      Utils.toastMessage('User Added Successfully');
    }).catchError((error) {
      Utils.flushBarErrorMessage(error, context);
    });
  }
}
