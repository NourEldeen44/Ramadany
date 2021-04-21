
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:ramadany/Days%20Details/day22details.dart';
import 'package:ramadany/storage.dart';
class Day22 extends StatefulWidget {
  @override
  _Day22State createState() => _Day22State();
}

class _Day22State extends State<Day22> {
  // bool siam = false;
  // bool quraan = false;
  // bool qiam = false;
 int missionsResult = 0;
  int index = 22; 
  String day22 = ArabicNumbers().convert(22);
  Storage storage = Storage();

@override
  void initState() {
  super.initState();
  storage.getBool('siam$index').then((value) {
    if(value == true){
      setState(() {
        missionsResult = missionsResult+1;
      });
    }
  });
  storage.getBool('qiam$index').then((value) {
    if(value == true){
      setState(() {
        missionsResult = missionsResult+1;
      });
    }
  });
  storage.getBool('quraan$index').then((value) {
    if(value == true){
      setState(() {
        missionsResult = missionsResult+1;
      });
    }
  });
  }
  @override
  Widget build(BuildContext context) {
    
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
    return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
        height: 200,
        width: width*.30,
        child: Card( color:Colors.greenAccent[400],
          child: Container(
             decoration: BoxDecoration(image: DecorationImage(
          fit: BoxFit.cover,
          image:AssetImage('images/day.png'))),
            child: InkWell(
              onTap: 
              HijriCalendar.now().isBefore(1442, 9, index)?()
              {Fluttertoast.showToast(msg: 'لم يبدأ اليوم بعد , جرب الأدوات' ,backgroundColor:Colors.greenAccent[700].withAlpha(255),textColor:Colors.white);}:
              (){
                return 
             Navigator.push(context, MaterialPageRoute(builder: (context)=> showhero(index,)));
              },
              child: Hero(
                tag:'day1',
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$day22',style: TextStyle(fontSize: 30,decorationThickness: 3,color: Colors.white,
                  fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,),
                  Text('رَمَضَانْ',style: TextStyle(fontSize: 25,decorationThickness: 3,color: Colors.white,
                  fontFamily: ArabicFonts.Cairo,
                  fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,),
                  // siam == true?
                  // Text('siam is true'):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('المهام ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontFamily: ArabicFonts.Cairo),),
                      missionsResult==0? // 0 missions comleted
                       Row(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.star,color: Colors.black54,size: 20,),Icon(Icons.star,color: Colors.black54,size: 20,),Icon(Icons.star,color: Colors.black54,size: 20,),],):
                       missionsResult==1? //1 mission completed
                       Row(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.star,color: Colors.amber,size: 20,),Icon(Icons.star,color: Colors.black54,size: 20,),Icon(Icons.star,color: Colors.black54,size: 20,),],):
                       missionsResult==2? //2 missions completed
                       Row(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.star,color: Colors.amber,size: 20,),Icon(Icons.star,color: Colors.amber,size: 20,),Icon(Icons.star,color: Colors.black54,size: 20,),],):
                       //else if 3 missions completed
                       Row(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.star,color: Colors.amber,size: 20,),Icon(Icons.star,color: Colors.amber,size: 20,),Icon(Icons.star,color: Colors.amber,size: 20,),],)
              
                    ],
                  )
                ],
        ),
              ),
            ),
          ) ,),
      ),
    );
  }
 showhero(int index){
   return Day22Details(index: index,);
 }
  
}