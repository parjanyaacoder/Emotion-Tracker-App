import 'dart:convert';

import 'package:http/http.dart' as http;

class SymblApi {
  String apiId = '3774333943694374764177454874797846414f4255734857333654715552664a';
  String appSecret = '47714a555175747037306f5a4c746b5370685435626135685131666b44647a4a744c35716c796848544738344c634f56457374475f4a356773524f4155466a67';

  var conversationId = '';


  getAccessToken() async
  {
    Uri uri = Uri.parse('https://api.symbl.ai/oauth2/token:generate');
   var response = await http.post(uri,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json"
        },
        body: json.encode({
          "appId": apiId,
          "appSecret": appSecret,
          "type": "application",
        })
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['accessToken'];
    }
  }

  getConversationId(String authToken, String message) async {
    Uri uri = Uri.parse('https://api.symbl.ai/v1/process/text');
  var  response = await http.post(uri,
        headers: {
          "Authorization": "Bearer $authToken",
          "Content-Type": "application/json"
        },
        body: json.encode({
          'enableSummary':true,
          "messages": [{
            "payload": {"content":message}
            }
          ]
        })
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    }
  }


  getSentiments(String conversationId,String authToken) async {
    Uri uri = Uri.parse('https://api.symbl.ai/v1/conversations/$conversationId/messages?sentiment=true');
  var  response = await http.get(uri,
    headers: {
      "Authorization": "Bearer $authToken",
      "Content-Type": "application/json",
    },

    );
    print(json.decode(response.body)['messages']);
    return json.decode(response.body)['messages'];


  }

  getJobStatus(String jobId,String authToken)
  async {
    Uri uri = Uri.parse('https://api.symbl.ai/v1/job/$jobId');
    var  response = await http.get(uri,
      headers: {
        "Authorization": "Bearer $authToken",
        "Content-Type": "application/json",
      },

    );
    return json.decode(response.body)['status'];
  }

}



