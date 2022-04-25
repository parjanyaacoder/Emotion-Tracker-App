import 'dart:convert';

import 'package:supabase/supabase.dart';
import 'package:http/http.dart' as http;
const supabaseUrl ='https://lraxpelmqfgvfawmxnoc.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxyYXhwZWxtcWZndmZhd214bm9jIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTA1NTI3MTgsImV4cCI6MTk2NjEyODcxOH0.AlHk9asNQFN66_mtSFtcx2nDOHlrzYKztXhXaUn6CWw';
class SupabaseManager {
 final client = SupabaseClient(supabaseUrl, supabaseKey);



 verifyPhoneOtp(String phone,String otp)
 async {
   var url = Uri.parse(supabaseUrl+"/auth/v1/verify");
   var response = await http.post(url,
       headers: {
         "apiKey":supabaseKey,
         "Content-Type":"application/json"
       },
       body: json.encode({
         "phone":phone,
         "type":"sms",
         "token":otp
       }));

   print(response.body);
   print(response.statusCode);
 }


 signUpPhone(String phone) async
 {
   var url = Uri.parse(supabaseUrl+"/auth/v1/otp");
   var response = await http.post(url,
       headers: {
     "apiKey":supabaseKey,
     "Content-Type":"application/json"
       },
       body: json.encode({
      "phone":phone
   }));

   print(response.body);
   print(response.statusCode);
 }

 signUpEmail(String email,String password,String phone,)
 async {
   await client.auth.signUp(
      email,
      password,
     userMetadata: {
        "Phone":phone
     }
    );
 }

}
