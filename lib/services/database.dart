import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseFunctions{
  //add employee function
  Future addEmployee(Map<String,dynamic> employee) async{
    return await FirebaseFirestore.instance.collection("Employee").add(employee);


}
 //get employee function
Future<Stream<QuerySnapshot>> getemployee() async{
    return await FirebaseFirestore.instance.collection("Employee").snapshots();

}
 //update employee function
Future updateEmployee(Map<String,dynamic> employee,String id) async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).update(employee);
}
 //delete employee function
  Future deleteEmployee(String id) async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).delete();
  }



}