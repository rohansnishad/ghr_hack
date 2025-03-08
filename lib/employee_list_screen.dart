// import 'package:flutter/material.dart';
// import 'alert_screen.dart';
//
// class EmployeeListScreen extends StatefulWidget {
//   @override
//   _EmployeeListScreenState createState() => _EmployeeListScreenState();
// }
//
// class _EmployeeListScreenState extends State<EmployeeListScreen> {
//   final List<String> employeeNames = ['Vedant', 'Rohan', 'Harshita', 'Raghav'];
//   final TextEditingController _nameController = TextEditingController();
//
//   bool jacketAssigned = false;
//   bool helmetAssigned = false;
//   bool shoesAssigned = false;
//
//   void _showAddEmployeeDialog() {
//     // Reset the form state
//     _nameController.clear();
//     jacketAssigned = false;
//     helmetAssigned = false;
//     shoesAssigned = false;
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//             builder: (context, setState) {
//               return AlertDialog(
//                 title: Text('Add Employee'),
//                 content: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TextField(
//                         controller: _nameController,
//                         decoration: InputDecoration(
//                           labelText: 'Employee Name',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       Text(
//                         'PPE Assign:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       CheckboxListTile(
//                         title: Text('Jacket'),
//                         value: jacketAssigned,
//                         onChanged: (bool? value) {
//                           setState(() {
//                             jacketAssigned = value ?? false;
//                           });
//                         },
//                       ),
//                       CheckboxListTile(
//                         title: Text('Helmet'),
//                         value: helmetAssigned,
//                         onChanged: (bool? value) {
//                           setState(() {
//                             helmetAssigned = value ?? false;
//                           });
//                         },
//                       ),
//                       CheckboxListTile(
//                         title: Text('Shoes'),
//                         value: shoesAssigned,
//                         onChanged: (bool? value) {
//                           setState(() {
//                             shoesAssigned = value ?? false;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 actions: [
//                   TextButton(
//                     child: Text('Cancel'),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                     ),
//                     child: Text('Add'),
//                     onPressed: () {
//                       if (_nameController.text.isNotEmpty) {
//                         setState(() {
//                           employeeNames.add(_nameController.text);
//                         });
//                         Navigator.of(context).pop();
//                       }
//                     },
//                   ),
//                 ],
//               );
//             }
//         );
//       },
//     ).then((_) {
//       // Update the UI after dialog is dismissed
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             // No back navigation needed on the first screen
//           },
//         ),
//         centerTitle: true,
//         title: Text(
//           'LifeLine',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Employee list',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: 16),
//             Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Color(0xFFF5E6FF),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 children: [
//                   SizedBox(width: 10),
//                   Icon(Icons.search, color: Colors.grey),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Search',
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(right: 10),
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: IconButton(
//                       icon: Icon(Icons.add, color: Colors.white),
//                       onPressed: _showAddEmployeeDialog,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: employeeNames.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     leading: CircleAvatar(
//                       radius: 25,
//                       backgroundColor: Color(0xFFF5E6FF),
//                       child: Icon(Icons.person, color: Colors.blue),
//                     ),
//                     title: Text(
//                       employeeNames[index],
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {
//                       // Navigate to the AlertScreen with the selected employee name
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AlertScreen(
//                             employeeName: employeeNames[index],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'alert_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<String> employeeNames = ['Vedant', 'Rohan'];
  List<String> filteredEmployees = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  bool jacketAssigned = false;
  bool helmetAssigned = false;
  bool shoesAssigned = false;

  @override
  void initState() {
    super.initState();
    filteredEmployees = List.from(employeeNames);
    _searchController.addListener(_filterEmployees);
  }

  void _filterEmployees() {
    setState(() {
      filteredEmployees = employeeNames
          .where((name) => name.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _showAddEmployeeDialog() {
    _nameController.clear();
    jacketAssigned = false;
    helmetAssigned = false;
    shoesAssigned = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Add Employee'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Employee Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'PPE Assign:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  CheckboxListTile(
                    title: Text('Jacket'),
                    value: jacketAssigned,
                    onChanged: (bool? value) {
                      setState(() => jacketAssigned = value ?? false);
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Helmet'),
                    value: helmetAssigned,
                    onChanged: (bool? value) {
                      setState(() => helmetAssigned = value ?? false);
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Shoes'),
                    value: shoesAssigned,
                    onChanged: (bool? value) {
                      setState(() => shoesAssigned = value ?? false);
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text('Add'),
                onPressed: () {
                  if (_nameController.text.isNotEmpty) {
                    setState(() {
                      employeeNames.insert(0, _nameController.text);
                      _filterEmployees();
                    });
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
      },
    );
  }

  void _deleteEmployee(String name) {
    setState(() {
      employeeNames.remove(name);
      _filterEmployees();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'LifeLine',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Employee list',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredEmployees.length,
                itemBuilder: (context, index) {
                  String name = filteredEmployees[index];
                  bool isHighlighted = name.toLowerCase().contains(_searchController.text.toLowerCase());

                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xFFF5E6FF),
                      child: Icon(Icons.person, color: Colors.blue),
                    ),
                    title: Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isHighlighted ? Colors.blue : Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlertScreen(
                            employeeName: name,
                          ),
                        ),
                      );
                    },
                    onLongPress: () {
                      _deleteEmployee(name);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: _showAddEmployeeDialog,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
