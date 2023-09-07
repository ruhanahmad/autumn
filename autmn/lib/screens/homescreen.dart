// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   final String fname;
//   final String lname;
//   final String email;
//   final String facility;
//   final String role;
//   final String position;
//   final String employeeKey;
//   final String playerID;

//   HomeScreen({
//     required this.fname,
//     required this.lname,
//     required this.email,
//     required this.facility,
//     required this.role,
//     required this.position,
//     required this.employeeKey,
//     required this.playerID,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Next Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text('First Name: $fname'),
//             Text('Last Name: $lname'),
//             Text('Email: $email'),
//             // ... Other data fields
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:autmn/screens/news.dart';
import 'package:autmn/screens/pendingScreen.dart';
import 'package:autmn/screens/schedule.dart';
import 'package:autmn/screens/successScreen.dart';
import 'package:autmn/screens/userController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class NextScreen extends StatefulWidget {

  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  DateTime selectedDate = DateTime.now();
   String formatDateVar = DateFormat('yyyy-MM-dd').format(DateTime.now()); // Default value
 List<dynamic> openShiftDates = [];


 @override
  void initState() {
    super.initState();
    // fetchOpenShiftss();
  }

    Future<void> fetchOpenShifts() async {
    final apiKey = 'YOUR_API_KEY';
    final email = 'demo@autumnhc.net';
    final date = DateFormat('yyyy-MM-dd').format(selectedDate);

    final apiUrl = Uri.parse('https://sandbox1.autumntrack.com/api/v2/week-open-shifts/?apikey=$apiKey&email=$email&date=$date');

    try {
      final response = await http.get(apiUrl);
     print("aasd ${response.statusCode}" );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['data'] != null) {
          final openShifts = List<String>.from(data['data'].map((shift) => shift['date']));
          setState(() {
            openShiftDates = openShifts;
          });
        }
      }
    } catch (error) {
      print('Error fetching open shifts: $error');
    }
  }
 Future<void>  fetchOpenShiftss() async {
  //  await Future.delayed(Duration(seconds: 5));
  final apiKey = 'MYhsie8n4';
  final email = 'demo@autumnhc.net';
  final date = DateFormat('yyyy-MM-dd').format(selectedDate);

  final apiUrl = Uri.parse('https://sandbox1.autumntrack.com/api/v2/week-open-shifts/?apikey=MYhsie8n4&email=demo@autumnhc.net&date=$date');
try {
    final response = await http.post(apiUrl);
   
    if (response.statusCode == 200) {
       final  responseData =
            json.decode(response.body) ;

  // Print the response data for inspection
  print(responseData);
        // final List<dynamic> responseData =
        //     json.decode(response.body) as List<dynamic>;
      // final openShifts = responseData
      //     .where((shift) => shift['error'] == null)
      //     .map<String>((shift) => shift['date'])
      //     .toList();
        setState(() {
          // Extract dates from the response data
         openShiftDates = responseData
          .where((shift) => shift['data'] != "No Open Shifts")
          .map<dynamic>((shift) => shift['date'])
          .toList();

          print("sadasDsssss $openShiftDates");
        });

  // setState(() {
  //         // Extract dates from the response data
  //         openShiftDates = responseData
  //             .map((data) => data['date'] as String)
  //             .toList();
  //       });

        print(openShiftDates);
    }
  } catch (error) {
    print('Error fetching open shifts: $error');
  }
}


  void _selectDate(DateTime date) {
    print("select date${date.weekday}");
    setState(() {
      selectedDate = date;
      formatDateVar = DateFormat('yyyy-MM-dd').format(selectedDate);
    });
  }
List<Map<String, dynamic>>? apiData; // List of Map to store API response data

  // API URL
  

  // Function to fetch data from the API
//  Future<List<Map<String, dynamic>>> fetchShifts() async {
//    final String apiUrl =
//       'https://sandbox1.autumntrack.com/api/v2/user-open-shifts/?apikey=MYhsie8n4&email=demo@autumnhc.net&date=$formatDateVar';
//     try {
//       final response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         // Parse the JSON response
//         final List<dynamic> responseData = json.decode(response.body);

//         // Cast the data to the expected type
//         // final List<Map<String, dynamic>> data =
//         //     responseData.cast<Map<String, dynamic>>();
//       return List<Map<String, dynamic>>.from(responseData);
//       } else {
//         // Handle API error here
//         throw Exception('Failed to load data');
//       }
//     } catch (error) {
//       // Handle network or other errors here
//       throw Exception('Failed to load data');
//     }
//   }
 UserContoller userContoller = Get.put(UserContoller()); 
 Future<List<Map<String, dynamic>>> fetchShifts() async {
  print(userContoller.email);
    final apiUrl = 'https://sandbox1.autumntrack.com/api/v2/user-open-shifts/?apikey=MYhsie8n4&email=${userContoller.email}&date=$formatDateVar';
 try {
    final response = await http.post(Uri.parse(apiUrl));
 print(response.statusCode);
    if (response.statusCode == 200) {

      final List<dynamic> jsonResponse = json.decode(response.body);
     jsonResponse.isEmpty ?
        Get.snackbar("title", "message"):

   
     
 
    
      print(response.body);
      print(jsonResponse);
      return List<Map<String, dynamic>>.from(jsonResponse);
    
    
    } else {
      // Get.snackbar("sd", "message");
      throw Exception('Failed to fetch shifts');
    }
 }
   catch (error) {
    return
      // Handle network or other errors here
     [
    
    ];
    }
    
    
  }

Future<Map<String, dynamic>> acceptInvitation(String id, String userInstantAccept) async {

    final apiUrl = 'https://sandbox1.autumntrack.com/api/v2/accept/?apikey=MYhsie8n4&id=$id&user_instant_accept=$userInstantAccept&empkey=13110';

    final response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final  Map<String,dynamic>jsonResponse = json.decode(response.body);
    
      return jsonResponse;
    } else {
      throw Exception('Failed to accept invitation');
    }
  }

  acceptInvitations() async {

    final apiUrl = 'https://sandbox1.autumntrack.com/api/v2/accept/?apikey=MYhsie8n4&id=1734&user_instant_accept=0&empkey=13110';
    

    final response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String,dynamic> jsonResponse = json.decode(response.body);
      print( jsonResponse);
    
    } else {
      throw Exception('Failed to accept invitation');
    }
  }
   void updateMainWidget() {
    setState(() {
      // Update your main widget's state here
    });
  }

  @override
  Widget build(BuildContext context) {

      DateTime startOfWeek;
      if(selectedDate.weekday == 7)
      {
        startOfWeek  = selectedDate.subtract(Duration(days:0));

      }
      else
      {
         startOfWeek = selectedDate.subtract(Duration(days:selectedDate.weekday ));

      }
// g meri jan or koi masla ?
// kya kahu ab,ap hero ho hero,lots of love
//loooooooooooooooooooooooooots of love
 //mjy thra sa smjha b do kya ho rha tha
 // dekho weeday jab ham selected date ka dekhte hain na linkdin per aajao main office se bahir jaraha clok
      //DateTime startOfWeek = selectedDate.subtract(Duration(days:0 ));
    List<DateTime> days = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
    return WillPopScope(
        onWillPop: () async {
   
         return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: (){
              // acceptInvitations();
    fetchOpenShiftss();
              //  Get.to(()=>NewsScreen ());
            },
            child: Text('Open Shifts',style: TextStyle(fontWeight: FontWeight.bold),)),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body:
        // GetBuilder<UserContoller> (builder:(context,) ,)
        
        
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  // ' ${DateFormat('MMMM d, y').format(selectedDate)}',
                    ' ${DateFormat('MMMM ').format(selectedDate)}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            //----------------
            Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: ()async{
                  DateTime prevWeek = selectedDate.subtract(Duration(days: 7 ));
                  _selectDate(prevWeek);
                   await fetchOpenShiftss();
            //  widget.fetchData;
                },
              ),
              Row(
                children: [
                  for (int i = 0; i < 7; i++)
                    GestureDetector(
                      // onTap: () => onSelectDate(days[i]),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          // color: days[i].day == selectedDate.day ? Colors.orange : null,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          DateFormat('E').format(days[i]),
                          style: TextStyle(
                            fontWeight: days[i].day == selectedDate.day ? FontWeight.bold : FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: ()async {
                  DateTime nextWeek = selectedDate.add(Duration(days: 7));
                  _selectDate(nextWeek);
                 await fetchOpenShiftss();
                // await  fetchOpenShiftss();
            //  await  widget.futureFunction;
            //  widget.updateMainWidget();
                },
              ),
            ],
          ),
          SizedBox(height: 10.0),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: [
          //       for (int i = 0; i < 7; i++)
          //         GestureDetector(
          //           onTap: () => onSelectDate(days[i]),
          //           child: Container(
          //             margin: EdgeInsets.symmetric(horizontal: 10.0),
          //             padding: EdgeInsets.all(8.0),
          //             decoration: BoxDecoration(
          //               color: days[i].day == selectedDate.day ? Colors.orange : null,
          //               borderRadius: BorderRadius.circular(8.0),
          //             ),
          //             child: Text(
          //               DateFormat('d').format(days[i]),
          //               style: TextStyle(
          //                 fontWeight: days[i].day == selectedDate.day ? FontWeight.bold : FontWeight.normal,
          //               ),
          //             ),
                   
    
                      
          //           ),
                    
          //         ),
                  
          //     ],
          //   ),
          // ),
    
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Row(
                children: [
                  for (int i = 0; i < 7; i++)
                    GestureDetector(
                      onTap: () async{
                      // await  widget.fetchData;
                      //yaha sy vo select kr rha
                        _selectDate(days[i]);
                        //ya vala ?
                        print("asdasdasdsdasdasdasddddddddddddddddd ${days[i]}");
                        print("Sasdasdasdasdas");
                  //woh na aik masla hay meri ex rabta kar rahi hai ab mere saath
                  //ya bht bra msla h,q kr rhi h ab, kehti hay shadi karni hay mene kaha men shadi k liye tyar nai
                  // ab usko nzar aaraha hay na k men abu dhabi men settle ho raha hun
                  //ja/b /g ya to koi bt na hui k settle h to shadi ya to pyr na hua
                  // han na woh sirf apna faida dekh rahi hay usko mene chora bhi isi selfish attitude k liye tha
                  //Allah e bhtr jantab but my suggestion is k ap us sy kro jo apko like kry vrna pysy bd mai bht mushkil hta aysy logou sth guzara krna
                  //woh itni ajeeb hay usne mujhe saaaf kaha kehti agar tum mujhe ghar pesa gari de sakte ho to shadi kar lo
                  // koi or larka bhi de ga to main kar loon gi koi pyar wyar nai hay mene kaha men pagal hun kya
                  // yr talha ap na pro aysy logou k pngy mai ap or nature k ho,aysy selfishness etc ya aysy log suit nh krtty apko
                  //baat ye hay k agar pyar hota to ye mere dubai anay se pehle hami bharti shadi ki
                  // k vohi na aik person saf zahir hselfiehs h to q us sy bt krni to jo hay na faida kya ? agar koi waqai mujhe chahti hay to woh har haal men rahay gi
                  /// ye paisa job ghar gari iska kya hay aaj job hay mere pass kal mujjhe fire kar dein ? men zero 
                  /// yahe to bt h k ap k sth jo rhna chahy us k sth rhty h,materilistic logou sy bhhhhhhhht dor rhna chahy
                  /// i hate materialism and things,honesty pyr insaniyat maishow hta,remaioning are robots i am already very door 
                  /// wo morroco main hay,yani pakistani nh h ?aapko to mene pehle hi btaya k zindagi main kabhi pakistani friend tak nai bani
                  /// na mene koshish ki ksi larki se baat karne ki , kabhi bhi ye morocco wali bhi khud hi mari thi keht
                  /// kehti you are very handsom is se pehle china wali bhi 
                  /// sch btau to kisi morocoo vali sy na krna,es sy acha chinese ko muslim kr k krlo vo log bht loyal hty kam k sth b insan k sth b
                  /// sach btaon to hamesha na mujhe zindagi men pehle larki ka hi message aaya hay mene kabhi nai kia ksi larki ko message
                  /// aapko bhi mera number ksi ne dia tha mujhe usne btaya tha k aap student hain
                  /// or kya ap legend apko ave to nh na khti
                  /// acha facebook per larkion ki aapko trick btata hun pehle woh message karti hain 
                  /// uske baad jab larka jwab deta hay saath hi voice bhej dein gi 
                  /// world is full of faaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaknesss woh fake nai hoti 
                  /// woh an parh larkian hoti hain jinke pass koi kaam nai hota ghar mein mobile mila hua hay bas
                  /// larkon se lagi rehti hain 
                  /// vo lrky b ave hty h phr jo bs physical hny k liyay reltion mai aty h ot lrkiya b bas aisa hi hay na
                  /// dil ko dil se rah jesi woh hoti hain wesa agay se facebook per dhoond leti hain 
                  /// pichle aik hafte main do larkion se baat hui aik larki ka meehna pehle message aaya tha mene usko maheny baad jwab ida
                  /// dia messenger khola to requests men tha unka bhi mene mama ko btaya k aise hamaray city ki larki k message aay
                  /// or woh kehti k woh aalima thi chlooooooooooooooooooo g
                  /// ssahe h bae saeh h
                  /// or usne snapchat per add kia 
                  /// or tahajud or fajar ko streak bhejti thi 
                  /// hahah islamic nibbi aho men uskko snapchat se remove kar dia pehle usne mujhe facebook re remove kia do din baad mene snapchat se kar dia
                  /// uske baad uska messag eaya kehti tumne snachat se remove kia mene kahan yes kehti acha badla lia 
                  /// mene kaha ofcourse phir woh block kar gai 
                  /// mai sch btau according to your nature,apko bs professional lrki jo kam careero or ho9nest ho vo suit krti
                  /// decent ho,kam b krti ho or professional, ya jo lrkiya hti jn ko sara din eshq k elava kam nh hta y bs
                  /// i think khumar h,asliyat bd mai vaziya hti h larkion ko apne larki hone per proud hota hay 
                  /// or attitude dikhati hain k ham larkian hain pta nai larke marte hain hamaray liye 
                  /// is liye attitude dikhati hain or men ksi ka attitude nai dekhta gender based attitude 
                  /// mai jtna judge kia h lrki hna koi produ ki bt nh,its just a gender,lrka zyada Allah ny mzboot or haseen bnaya h
                  /// hmary ulta hisab h society mai hr ulti chz ko hm ny bs hype create ki h js sy etna nuqsan hora
                  /// ye jo facebook se aati hain na inka experience in jese larkon k saath hota hay q k woh larkon k pallay kuch nai hota 
                  /// thuray hotay hain phir jab ye ham jeson takrti hain zaleel ho k bhaag jati hain hamary pass atitude dekhne ka time nai hay
                  /// koi mere level ki ho kaam aata ho mujse zyada 
                  /// to main uske nakhre bhi dekhun ga attitude bhi k bai professional larki hay skills hain education hay 
                  /// koi to baat ho na attitude dikhanay ki k nai ?
                  /// ary vohi na kam chahy zyada na ata ho lakin apny kam mai professional decent and good girl ho jo
                  /// fzzol chezaou mai na pry,phr hr chz ka apna mza hta h insan acha mlna chahy
                  /// chalo chado g sanu ki asi ty apne ghar walyan lai kama ray wan filhaal 
                  /// i beleive you find pretiest soul
                  /// meri dadi aman mere papa ko keh rahin thin k meri shadi phupho ki beti se kar dein jo 6th class se bhagi hui hay 
                  /// ap ya news sun k or agy bhaag jao kbhi ap[ni chocies py compromise na krna,ya hq lrkou k pas
                  /// es society mai phr b h ,lrkiou ki to aksr sunin nh jati jysy merty ghr h
                  /// lakin i suggest you hmysha dykh bal k insan dhndhna js sy k sth zndgi gzarni
                  /// phr yahe dadi or parents hty jo khty koi bt nh sbr krlo hm sy glti hgae
                  /// ap koi glti na krny dena] ye baat 3 4 saal purani hay to papa ne bahana bna dia k degree kar raha hay
                  /// bs ap khd choose krna ya agr parents choose kry to uski fullverification krlena
                  /// parents hi karein gay mere pass itna akhtyar nai hay ab
                  /// ajy ga ekhtyar  ap thra sa jb hjhao gy
                  /// mujhe ye pta hay k mujhe mere jesi mil jay gi Allah ne bnai hogi 
                  /// mene aaj tak ksi larki ko touch bhi nai kia 
                  /// han online thori boti thark karte rehte hain haha
                  /// hyeeee kya tb h apkli
                  /// ye bas emojis or bas or kuch nai 
                  /// aik larki idhar ki thi dubai men meri colleague punjabi woh bhi mari pari thi mere uper 
                  /// lekin mene kabhi gor nai kia usne saal baad mujhe btaya haha k tumne mujhe woh shadi k chakar main thi
                  /// uske saath dubai office main dhai maheeny kam kia halanke men usko aisa koi sign nai dia apne kaam se kaam
                  /// bas phir bhi saal baad mene poocha k tumhein aisa kya nzar aaya kehti you are very caring w
                  /// to yani ap caring ho
                  /// pta nai ye caring kya hota hay
                  /// care krna ehsas krna ye to insaniat hy apne ghar se banda seekhta hay k doosron ka khyal rakhna chahiye
                  /// aj kkll vbo insiyat km h na lgoou mai es liyay jah sy mily vo khty h youna are caring hla k ya chz aam hni chahy
                  /// bilkul men khud yhi kehta hun ye to sunnat hay hamein mili hui k doosron ka khyal rakhien madad karein etc..
                  /// baki larkon mein thark is natural haha
                  /// agar aap ye kahein k larka bilkul bhi larki ki traf mayl hi na ho gender attraction hi na ho 
                  /// to woh larka nai usko doctor se chek karwana parega ye mufti tariq masood ne kaha hay haha
                  /// yar mein idhar very lonely hun pehle aap kabh onlihne hoti thin koi batein shatein ho jati thin aaj kal to bas
                  /// bilkul hi khtm ab mai online any kikoshsibh krti hu zyada tr abhi na safai ho rai hay main sim on karun ga 
                  /// dubai wali to aap whatsapp bna lena to vo extra sim h? yes
                  /// acha thk h
                  /// ya vala ui ka issue ? woh dikhao kahan hay 
                      } ,
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: days[i].day ==selectedDate.day ? Colors.orange : null,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              DateFormat('d').format(days[i]),
                              style: TextStyle(
                                fontWeight: days[i].day ==selectedDate.day ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                          if (openShiftDates.contains(DateFormat('yyyy-MM-dd').format(days[i])))
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 8.0,
                                height: 8.0,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
        //    WeeklyCalendar(selectedDate: selectedDate, onSelectDate: _selectDate,openShiftDates: openShiftDates,futureFunction:fetchOpenShiftss ,updateMainWidget:updateMainWidget),
            Container(
              height: MediaQuery.of(context).size.height /2-400,
              width: MediaQuery.of(context).size.width,
              // flex: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                                        Text(
                        ' ${DateFormat('EEEE, MMMM d, y').format(selectedDate)}',
                        style: TextStyle(color: Colors.white),
                      ),
                    // Container(
                    //   padding: EdgeInsets.all(10.0),
                    //   decoration: BoxDecoration(
                    //     color: Colors.orange,
                    //     borderRadius: BorderRadius.circular(8.0),
                    //   ),
                    //   child:
                    //    Text(
                    //     ' ${DateFormat('EEEE, MMMM d, y').format(selectedDate)}',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
    SizedBox(height: 24,),
                 Expanded(
                  // flex: 1,
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchShifts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } 
             else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No shifts available'));
              } 
               else {
                return ListView.builder(
                itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                   var shift = snapshot.data![index];
    
                  final inputFormat = DateFormat('HH:mm'); // 'HH:mm' represents 24-hour format
      final outputFormat = DateFormat('h:mm a'); // 'h:mm a' represents 12-hour format with AM/PM
     String? strt ;
      String? ebd ;
      try {
      final DateTime dateTime = inputFormat.parse(shift['shift_start']);
      final DateTime dateTimeebd = inputFormat.parse(shift['shift_end']);
      
     strt  =  outputFormat.format(dateTime);
      ebd =  outputFormat.format(dateTimeebd);
      } catch (e) {
      // Handle parsing errors here
       'Invalid Time';
      }
      String? formattedDate ;
    try {
    DateTime inputDate = DateTime.parse(shift['date_of_shift']);
    formattedDate = DateFormat('EEEE, MM /dd').format(inputDate);
    print(formattedDate);
    }
    
    catch (e) {
      // Handle parsing errors here
       'Invalid Time';
      }
    
                    return 
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
                      child: 
                      Material(
                        borderRadius: BorderRadius.circular(15),
                        elevation: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            
                            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            
                            child:
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
    Text('${shift['position']}',style: TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold),),
    Text(" ${strt} -  ${ebd!}",style: TextStyle(fontSize: 14),),
      
    
                                  ],),
    
                                     Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
     shift["approved"] == "1" || shift["user_instant_accept"] == "1" ?
     Column(
                                        children: [
                                          GestureDetector(
                                            onTap: ()
                                          async {
                                                  try {
                                                    Map<String, dynamic> acceptResponse = await acceptInvitation(shift['id'], shift['user_instant_accept']);
                                                    // You can store the accept response data in variables here if needed
                                                    print('Accept Response: $acceptResponse');
                                                    acceptResponse["message"]== "Success" ?  
                                                   
                                                    Get.to(()=>SuccessScreen(shiftDate:formattedDate!,shiftTime:strt!,shiftTimeEnd:ebd!,approved:shift["approved"],userInstant:shift["user_instant_accept"] ))
                                                    :
                                                    null
                                                    ;
                                                     
                                                  } catch (error) {
                                                    print('Error accepting invitation: $error');
                                                  }
                                                },
                                            child: Container(
                                              height: 36,
                                              width: 111,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Color(0xFFFF9800)
                                              ),
                                              child: Center(child: Text("Accept",style: TextStyle(fontSize: 15,color: Colors.white),)),
                                            ),
                                          ),
    SizedBox(height: 4,),
                                            Row(
                                          children: [
                                             Icon(Icons.electric_bolt_sharp,color: Colors.green,size: 14,),
                                            Text("Instant Accept",style: TextStyle(fontSize: 14,color: Colors.green),)
                                          ],
    
                                        ) 
                                        ],
                                      )
                                      
                                      :
                                       GestureDetector(
                                        onTap: ()
                                      async {
                                              try {
                                                Map<String, dynamic> acceptResponse = await acceptInvitation(shift['id'], shift['user_instant_accept']);
                                                // You can store the accept response data in variables here if needed
                                                print('Accept Response: $acceptResponse');
                                                acceptResponse["message"]== "Success" ?  
                                               
                                                Get.to(()=>SuccessScreen(shiftDate:formattedDate!,shiftTime:strt!,shiftTimeEnd:ebd!,approved:shift["approved"],userInstant:shift["user_instant_accept"] ))
                                                :
                                                null
                                                ;
                                                 
                                              } catch (error) {
                                                print('Error accepting invitation: $error');
                                              }
                                            },
                                        child: Container(
                                          height: 36,
                                          width: 111,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Color(0xFFFF9800)
                                          ),
                                          child: Center(child: Text("Accept",style: TextStyle(fontSize: 15,color: Colors.white),)),
                                        ),
                                      ),
                                      
                                     
                                      
      //  ElevatedButton(
      //                                  style: ElevatedButton.styleFrom(
      //               primary: Colors.orange,
      //               foregroundColor: Colors.white,
      //           // Adjust padding as neede
                 
                  
      //               ),
       
      //                                     onPressed: () 
      //                                     async {
      //                                       try {
      //                                         Map<String, dynamic> acceptResponse = await acceptInvitation(shift['id'], shift['user_instant_accept']);
      //                                         // You can store the accept response data in variables here if needed
      //                                         print('Accept Response: $acceptResponse');
      //                                         acceptResponse["message"]== "Success" ?  
                                               
      //                                         Get.to(()=>SuccessScreen(shiftDate:formattedDate!,shiftTime:strt!,shiftTimeEnd:ebd!,approved:shift["approved"],userInstant:shift["user_instant_accept"] ))
      //                                         :
      //                                         null
      //                                         ;
                                                 
      //                                       } catch (error) {
      //                                         print('Error accepting invitation: $error');
      //                                       }
      //                                     },
      //                                     child: Text('Accept Shift'),
      //                                   ),
                                        //    shift["approved"] == "1" || shift["user_instant_accept"] == "1" ?
                                        // Row(
                                        //   children: [
                                        //     IconButton(onPressed: (){}, icon: Icon(Icons.electric_bolt_sharp,color: Colors.green,)),
                                        //     Text("Instant Accept",style: TextStyle(fontSize: 12,color: Colors.green),)
                                        //   ],
    
                                        // ) 
                                        // :
                                        // Container()
                                        
                                  ],),
                                ],),
                                shift["bonus"] == "0" ? Center(child: Text("")):Center(child: Text(" Bonus: \$${shift['bonus']} ",style: TextStyle(color: Colors.red,fontSize: 14,fontWeight: FontWeight.bold),)),
                              ],
                            )
                            
                            
                            //  ListTile(
                            //              title: 
                            //   // subtitle: Text('S ${shift['shift_start']} - ${shift['shift_end']}'),
                            //   subtitle: 
                            //    trailing: 
                            //    Column(
                            //      children: [
                                
    
                                
    
                                    
                                    
                                      
                            //      ],
                            //    ),
                            // ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      
          ],
        ),
      ),
    );
  }
}
// ya vala widget nh avbe lkha h code sara es su upr h
class WeeklyCalendar extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onSelectDate;
  final List<dynamic> openShiftDates;
   final Future<void> Function() futureFunction;
  //  final Future<void>  fetchData;
   final VoidCallback updateMainWidget;

  WeeklyCalendar({required this.selectedDate, required this.onSelectDate,required this.openShiftDates,required this.futureFunction,required this.updateMainWidget});

  @override
  State<WeeklyCalendar> createState() => _WeeklyCalendarState();
}

class _WeeklyCalendarState extends State<WeeklyCalendar> {
 List<dynamic> openShiftDates = [];
   Future<void>  fetchOpenShif() async {
  //  await Future.delayed(Duration(seconds: 5));
  final apiKey = 'MYhsie8n4';
  final email = 'demo@autumnhc.net';
  final date = DateFormat('yyyy-MM-dd').format(widget.selectedDate);

  final apiUrl = Uri.parse('https://sandbox1.autumntrack.com/api/v2/week-open-shifts/?apikey=MYhsie8n4&email=demo@autumnhc.net&date=$date');
try {
    final response = await http.post(apiUrl);
   
    if (response.statusCode == 200) {
       final  responseData =
            json.decode(response.body) ;

  // Print the response data for inspection
  print(responseData);
        // final List<dynamic> responseData =
        //     json.decode(response.body) as List<dynamic>;
      // final openShifts = responseData
      //     .where((shift) => shift['error'] == null)
      //     .map<String>((shift) => shift['date'])
      //     .toList();
        setState(() {
          // Extract dates from the response data
         openShiftDates = responseData
          .where((shift) => shift['data'] != "No Open Shifts")
          .map<dynamic>((shift) => shift['date'])
          .toList();

          print("sadasDsssss $openShiftDates");
        });

  // setState(() {
  //         // Extract dates from the response data
  //         openShiftDates = responseData
  //             .map((data) => data['date'] as String)
  //             .toList();
  //       });

        print(openShiftDates);
    }
  } catch (error) {
    print('Error fetching open shifts: $error');
  }
}

  @override
  //ya sara code repeated h usko upr lkha hua h vohi chl rha h tya vala nh
  // wo function kholo 

  Widget build(BuildContext context) {
    DateTime startOfWeek = widget.selectedDate.subtract(Duration(days: widget.selectedDate.weekday ));
    List<DateTime> days = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    return 
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (){
                DateTime prevWeek = widget.selectedDate.subtract(Duration(days: 7));
                widget.onSelectDate(prevWeek);
          //  widget.fetchData;
              },
            ),
            Row(
              children: [
                for (int i = 0; i < 7; i++)
                  GestureDetector(
                    // onTap: () => onSelectDate(days[i]),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        // color: days[i].day == selectedDate.day ? Colors.orange : null,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        DateFormat('E').format(days[i]),
                        style: TextStyle(
                          fontWeight: days[i].day == widget.selectedDate.day ? FontWeight.bold : FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: ()async {
                DateTime nextWeek = widget.selectedDate.add(Duration(days: 7));
                widget.onSelectDate(nextWeek);
              // await  fetchOpenShiftss();
           await  widget.futureFunction;
           widget.updateMainWidget();
              },
            ),
          ],
        ),
        SizedBox(height: 10.0),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: [
        //       for (int i = 0; i < 7; i++)
        //         GestureDetector(
        //           onTap: () => onSelectDate(days[i]),
        //           child: Container(
        //             margin: EdgeInsets.symmetric(horizontal: 10.0),
        //             padding: EdgeInsets.all(8.0),
        //             decoration: BoxDecoration(
        //               color: days[i].day == selectedDate.day ? Colors.orange : null,
        //               borderRadius: BorderRadius.circular(8.0),
        //             ),
        //             child: Text(
        //               DateFormat('d').format(days[i]),
        //               style: TextStyle(
        //                 fontWeight: days[i].day == selectedDate.day ? FontWeight.bold : FontWeight.normal,
        //               ),
        //             ),
                 

                    
        //           ),
                  
        //         ),
                
        //     ],
        //   ),
        // ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < 7; i++)
                GestureDetector(
                  onTap: () async{
                  // await  widget.fetchData;
                    widget.onSelectDate(days[i]);
                  
                  } ,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: days[i].day == widget.selectedDate.day ? Colors.orange : null,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          DateFormat('d').format(days[i]),
                          style: TextStyle(
                            fontWeight: days[i].day == widget.selectedDate.day ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (widget.openShiftDates.contains(DateFormat('yyyy-MM-dd').format(days[i])))
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

