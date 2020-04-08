import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:isudgu_app/storage.dart';

class Parser {

  Future<String> getHtml() async {
    String out;
    try {

      
      Map<String, String> dataSend = {
        "__EVENTTARGET": "EnterBtn",
        "__EVENTARGUMENT": "",
        "__VIEWSTATE":
            "/wEPDwUKMTQ2MTA3ODA0MWRkyOsDv65TrLlbM6ga+uWJhfOVqmQ/RihVftbFpTmB4LM=",
        "__EVENTVALIDATION":
            "/wEWBgL9ipniDwK4jZRCAqaKlEICypChgggCl/KPlQYCm4zxugS2cJ5mgqC3JnZrasIRZK0eTzcFQlpGIuQakAR5i48crw==",
        "LNameTxt": curentAccaunt['fName'],
        "FNameTxt": curentAccaunt['sName'],
        "PatrTxt" : curentAccaunt['lName'],
        "NZachKnTxt": curentAccaunt['password']
      };

      Map<String, String> headersSend = {
        'Host': 'studstat.dgu.ru',
        'Accept':
            'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Language': 'ru-RU,ru;q=0.8,en-US;q=0.5,en;q=0.3',
        'Accept-Encoding': 'gzip, deflate',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Origin': 'http://studstat.dgu.ru',
        'DNT': '1',
        'Connection': 'keep-alive',
        'Referer':
            'http://studstat.dgu.ru/login.aspx?ReturnUrl=%2fstat.aspx&cookieCheck=true',
        'Upgrade-Insecure-Requests': '1',
      };

      String url =
          "http://studstat.dgu.ru/login.aspx?ReturnUrl=%2f&cookieCheck=true";
      String url2 = "http://studstat.dgu.ru/stat.aspx";

      Client client = http.Client();

      Response uriResponse =
          await client.post(url, body: dataSend, headers: headersSend);

      String setCookie = 'SupportCookies=true; ' +
          uriResponse.headers['set-cookie'].replaceAll("path=/; HttpOnly,", "");

      Response response2 =
          await client.get(url2, headers: {'Cookie': setCookie});

      Document document = parse(response2.body);


      List<Element> inputs = document.querySelectorAll('input');

      List<Map<String, String>> linkMap = [];

      for (Element link in inputs) {
        linkMap.add({
          'id': link.attributes['id'],
          'value': link.attributes['value'],
        });
      }

      if ( dropdownValue == ''){

        List<Element> dropdownMax = document.querySelectorAll('option');
        
        dropdownValue = dropdownMax[dropdownMax.length-1].text[0];
        for(int i = 1; i<= int.parse(dropdownValue); i++ )
        {dropdownValueList.add( i.toString());}
        
      }

      Map<String, String> dataSendSession = {
        '__EVENTTARGET': 'ctl00%24ContentPlaceHolder1%24SessDropDownList',
        "__EVENTARGUMENT": "",
        "__LASTFOCUS": "",
        '__VIEWSTATE': linkMap[0]["value"],
        '__VIEWSTATEENCRYPTED': linkMap[1]["value"],
        '__EVENTVALIDATION': linkMap[2]["value"],
        'ctl00\$ContentPlaceHolder1\$SessDropDownList': dropdownValue
      };

      Map<String, String> headersSend2 = {
        'Host': 'studstat.dgu.ru',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Language': 'ru-RU,ru;q=0.8,en-US;q=0.5,en;q=0.3',
        'Accept-Encoding': 'gzip, deflate',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Origin': 'http://studstat.dgu.ru',
        'DNT': '1',
        'Connection': 'keep-alive',
        'Referer': 'http://studstat.dgu.ru/stat.aspx',
        'Upgrade-Insecure-Requests': '1',
        'Cookie': setCookie
      };

      Response response =
          await client.post(url2, body: dataSendSession, headers: headersSend2);

      client.close();


      
      out = response.body;
       
 

    } catch (e) {
      print(e);
    }

    return out;
  }

  Future<List<Map<String, String>>> parseHtml() async{

    String html = await getHtml();
    
    List<Element> tableList = parse(html).querySelectorAll('tr');

    List<String> textInTable = [];

    for (int i = 1; i < (tableList.length-2)/2; i++) {
      textInTable.add(tableList[i].text);
    }

    List<List<String>> splitedTextInTable = [];

    for (String link in textInTable) {
      splitedTextInTable.add(link.split("\n").toList());
    }

    List<Map<String,String>> rowMap = [];

    for (List<String> link in splitedTextInTable) {
      rowMap.add({
        'discipline': link[1].trim(),
        'mod1'      : link[2].trim()==""  ? "–" : link[2].trim(),
        'mod2'      : link[4].trim()==""  ? "–" : link[4].trim(),
        'mod3'      : link[6].trim()==""  ? "–" : link[6].trim(),
        'mod4'      : link[9].trim()==""  ? "–" : link[9].trim(),
        'kurs'      : link[11].trim()=="" ? "–" : link[11].trim(),
        'zachet'    : link[12].trim()=="" ? "–" : link[12].trim().replaceFirst(" ", ""),
        'exam'      : link[14].trim()=="" ? "–" : link[14].trim().replaceFirst(" ", ""),
      });
    }

    return rowMap;
  }

}