import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/edit_employee_details.dart';
import 'package:crud_app/employee_page.dart';
import 'package:crud_app/services/database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameHome=TextEditingController();
  TextEditingController ageHome=TextEditingController();
  TextEditingController locationHome=TextEditingController();

  Stream? employeeStream;

  getemployeestream() async{
    employeeStream=await DatabaseFunctions().getemployee();
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getemployeestream();
    super.initState();
  }

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
            Text("Info ",style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),),

          ],
        ),
        backgroundColor: Colors.white,
      ),
      body:StreamBuilder(
        stream: employeeStream,
        builder: (context,AsyncSnapshot snapshot){
          return snapshot.hasData?
          ListView.builder(
            itemCount: snapshot.data.docs.length,
              itemBuilder:(context,index){

              DocumentSnapshot ds= snapshot.data.docs[index];
              print(ds.id);
              print(index);
              return ListTile(
                leading:  IconButton(onPressed: () {
                  nameHome.text=ds["Name"];
                  ageHome.text=ds["Age"];
                  locationHome.text=ds["Location"];
                  EditEmployeeDetails2(ds.id.toString());

                }, icon: Icon(Icons.edit),

                ),
                trailing:
                    IconButton(onPressed: (){
                      DatabaseFunctions().deleteEmployee(ds.id.toString());
                    }, icon: Icon(Icons.delete)),

                title:Column(
                  children: [
                    Text("Name:"+ds["Name"]),
                    Text("age"+ds["Age"]),
                    Text("location:"+ds["Location"])
                  ],
                )
              );
              }):
          Container();

        },
      )
        // Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10)
        //   ),
        //   width:MediaQuery.of(context).size.width,
        //   child:Column(
        //     children: [
        //       Text("Name:"),
        //       Text("Age:"),
        //       Text("Location:")
        //     ],
        //   ),
        // )


    );
  }
  Future EditEmployeeDetails2(String id)=>showDialog(context: context, builder: (context)=>AlertDialog(
      content: Container(
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
                controller:nameHome,
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
                controller:ageHome,
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
                controller:locationHome,
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
              Map<String,dynamic> updateEmployee={
                "Name":nameHome.text,
                "Age":ageHome.text,
                "Location":locationHome.text
              };
              DatabaseFunctions().updateEmployee(updateEmployee, id);

            }, child: Text("update employee"))

          ],

        ),
      )

  )
  );

}
