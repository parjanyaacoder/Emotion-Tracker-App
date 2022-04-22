import 'package:supabase/supabase.dart';

const supabaseUrl = 'https://nisuxxonlqwkllponxos.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5pc3V4eG9ubHF3a2xscG9ueG9zIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTA1MzQxMTAsImV4cCI6MTk2NjExMDExMH0.IBLk15xwWaUu0WiDfdO0H8j1-KbWwrAkcPlwHMcI2Fc';

class SupabaseManager {
 final client = SupabaseClient(supabaseUrl, supabaseKey);

 signUpUser(String email, String password) async {
   await client.auth.signUp(email, password);
 }

 getData() async {
   var response = await client.from('DataTable').select().execute();
   if(response.error == null)
     print('response data ${response.data}');
 }

 addData(String friendName) async {
   await client.from('DataTable').insert([{'name':friendName}]).execute();

 }



}
