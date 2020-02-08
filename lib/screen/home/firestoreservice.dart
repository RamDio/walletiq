import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:walletiq/screen/home/model/brmodel.dart';
import 'package:walletiq/screen/home/model/budmodel.dart';
import 'package:walletiq/screen/home/model/expmodel.dart';
// import 'package:flutter/foundation.dart';

class FirestoreService {
  static final FirestoreService _firestoreService = FirestoreService._internal();
  Firestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Stream<List<ExpModel>> getExpModel() {
    return _db.collection("expense").snapshots().map(
          (snapshot) => snapshot.documents.map(
            (doc) => ExpModel.fromMap(doc.data, doc.documentID),
          ).toList(),
        );
  }

  Future<void> addExpense(ExpModel expmodel) {
    return _db.collection("expense").add(expmodel.toMap());
  }

  Future<void> deleteExpense(String id) {
    return _db.collection("expense").document(id).delete();
  }

  Future<void> updateExpense(ExpModel expmodel) {
    return _db
        .collection("expense")
        .document(expmodel.id)
        .updateData(expmodel.toMap());
  }

  Stream<List<BudModel>> getBudModel() {
    return _db.collection("budgets").snapshots().map(
          (snapshot) => snapshot.documents.map(
            (doc) => BudModel.fromMap(doc.data, doc.documentID),
          ).toList(),
        );
  }

  Future<void> addBudget(BudModel budmodel) {
    return _db.collection("budgets").add(budmodel.toMap());
  }

  Future<void> deleteBudget(String id) {
    return _db.collection("budgets").document(id).delete();
  }

  Future<void> updateBudget(BudModel budmodel) {
    return _db
        .collection("budgets")
        .document(budmodel.id)
        .updateData(budmodel.toMap());
  }

  Stream<List<BrModel>> getBrModel() {
    return _db.collection("billreminder").snapshots().map(
          (snapshot) => snapshot.documents.map(
            (doc) => BrModel.fromMap(doc.data, doc.documentID),
          ).toList(),
        );
  }

  Future<void> addBillReminder(BrModel brmodel) {
    return _db.collection("billreminder").add(brmodel.toMap());
  }

  Future<void> deleteBillReminder(String id) {
    return _db.collection("billreminder").document(id).delete();
  }

  Future<void> updateBillReminder(BrModel brmodel) {
    return _db
        .collection("billreminder")
        .document(brmodel.id)
        .updateData(brmodel.toMap());
  }


}
