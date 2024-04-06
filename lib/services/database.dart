import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseFunctions{
  Future addEmployee(Map<String,dynamic> employee) async{
    return await FirebaseFirestore.instance.collection("Employee").add(employee);


}

Future<Stream<QuerySnapshot>> getemployee() async{
    return await FirebaseFirestore.instance.collection("Employee").snapshots();

}

Future updateEmployee(Map<String,dynamic> employee,String id) async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).update(employee);
}

  Future deleteEmployee(String id) async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).delete();
  }



}