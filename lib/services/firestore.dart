import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task.dart';

class FirestoreService {
  static final FirestoreService _firestoreService = FirestoreService._();
  static final Firestore _db = Firestore.instance;

  FirestoreService._();
  factory FirestoreService() => _firestoreService;

  CollectionReference collection = _db.collection('task');

  Stream<List<Task>> getTaskByUser(String userId) {
    return collection.where("userId", isEqualTo: userId).snapshots().map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Task.fromSnapshot(doc),
              )
              .toList(),
        );
  }

  Future<void> createTask(Task task) async => collection.add(
        task.toDocument(),
      );
}