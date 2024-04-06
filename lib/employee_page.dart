import 'package:crud_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  TextEditingController name=TextEditingController();
  TextEditingController age=TextEditingController();
  TextEditingController location=TextEditingController();
  int id=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>EmployeePage()));
          }, icon: Icon(Icons.add,color: Colors.deepPurple,))
        ],
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center
          ,
          children: [
            Text("Employee ",style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),),
            Text("Form",style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),),

          ],
        ),
        backgroundColor: Colors.white,
      ),
      body:
        Container(
          child: Column(
            children: [
              Text(
                "Name",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller:name,
                  decoration: InputDecoration(
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width:10,

                      )
                    )
                  ),
                ),
              ),
              Text(
                "Age",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller:age,
                  decoration: InputDecoration(
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width:10,

                          )
                      )
                  ),
                ),
              ),
              Text(
                "Location",

                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller:location,
                  decoration: InputDecoration(
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width:10,

                          )
                      )
                  ),
                ),
              ),
              ElevatedButton(onPressed: (){
                Map<String,dynamic> employee={
                  "Name":name.text,
                  "Age":age.text,
                  "Location":location.text
                };
                setState(() {
                  DatabaseFunctions().addEmployee(employee).then((val){
                    Fluttertoast.showToast(
                        msg: "Employee has been added",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );

                  });

                });


              }, child: Text("Add Employee")
              ),
            ],

          ),
        )


    );
  }
}
