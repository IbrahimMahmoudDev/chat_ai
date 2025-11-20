
import 'package:cloud_firestore/cloud_firestore.dart';

import 'backend_point.dart';
import 'data_base_services.dart';

class FireStoreServices implements DataBaseServices {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  

  @override


  @override
  Future<bool> checkIfDataExit({
    required String path,
    required String documentId,
  }) async {
    var data = await fireStore
        .collection(BackEndEndPoint.kIfDataExit)
        .doc(documentId)
        .get();
    return data.exists;
  }

  @override
  Future getData({required String path, String? documentId, Map<String, dynamic>? query}) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<void> addData({required String path, required Map<String, dynamic> data, String? documentId}) {
    // TODO: implement addData
    throw UnimplementedError();
  }
}
