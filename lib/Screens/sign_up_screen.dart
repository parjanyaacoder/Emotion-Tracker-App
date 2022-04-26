// import 'package:flutter/material.dart';
// import 'package:flutter_supa_app/Screens/login_screen.dart';
// import 'package:flutter_supa_app/supabase_manager.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);
//
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//
//   SupabaseManager supabaseManager = SupabaseManager();
//   final signUpFormKey = GlobalKey<FormState>();
//   TextEditingController _phoneEditingController = TextEditingController();
//   TextEditingController _emailEditingController = TextEditingController();
//   TextEditingController _passwordEditingController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return  SafeArea(
//       child:
//       Scaffold(
//         body: Container(
//           padding: const EdgeInsets.all(20),
//           child: Align(
//             alignment: Alignment.center,
//             child: Container(
//               child: Column(
//                 children:[
//                   Form(
//                     key: signUpFormKey,
//                     child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 8.0, horizontal: 30),
//                         child: Column(
//                           children: [
//                             TextFormField(
//                               controller: _emailEditingController,
//                               onChanged: (value){
//                                 value = _emailEditingController.value.text;
//                                 setState(() {
//                                 });
//                               },
//                             ),
//                             TextFormField(
//                               keyboardType: TextInputType.number,
//                               onChanged: (value){
//                                 value = _phoneEditingController.value.text;
//                                 setState(() {
//                                 });
//                               },
//                               controller: _phoneEditingController,
//                             ),
//                             TextFormField(
//                               controller: _passwordEditingController,
//                               obscureText: true,
//                               onChanged: (value){
//                                 value = _passwordEditingController.value.text;
//
//                                 setState(() {
//                                 });
//                               },
//                             ),
//                           ],
//                         )
//
//
//
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
//                     },
//                     child: Text('Log In'),
//                   ),
//                   Container(
//                     margin:
//                     const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
//                     decoration: BoxDecoration(
//                         color: Colors.green.shade300,
//                         borderRadius: BorderRadius.circular(5),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.green.shade200,
//                               offset: const Offset(1, -2),
//                               blurRadius: 5),
//                           BoxShadow(
//                               color: Colors.green.shade200,
//                               offset: const Offset(-1, 2),
//                               blurRadius: 5)
//                         ]),
//                     child: ButtonTheme(
//                       height: 50,
//                       child: TextButton(
//                         onPressed: () {
//                           supabaseManager.signUpEmail(_emailEditingController.value.text,_passwordEditingController.value.text,_phoneEditingController.value.text);
//                           print("HERE");
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
//                         },
//                         child: Center(
//                             child: Text(
//                               "SIGN_UP".toUpperCase(),
//                               style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold),
//                             )),
//                       ),
//                     ),
//                   ),
//
//                 ]
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
