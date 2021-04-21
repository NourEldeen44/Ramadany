
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ramadany/hadithstorage.dart';
import 'package:ramadany/homepage.dart';
import 'package:ramadany/storage.dart';
class Day19Details extends StatefulWidget {
 final int index;
  Day19Details({this.index});
  @override
  _Day19DetailsState createState() => _Day19DetailsState();
}

class _Day19DetailsState extends State<Day19Details> {

  String _hadithSource = HadithStorage().hadith19['an']; 
  // 'عن عن عن عن عن ع نعن عن عن عن عن عن عن عن عن عن عن عن ع نع نع ن عن عن عنع'+'\n'+'\n'+'\n'+'ن عن عن عن عن ع نعن عن عن عن عن عن عن عن عن عن عن عن ع نع نع ن عن عن عنع';
  String _hadithHeart = HadithStorage().hadith19['heart']; 
  // 'قال رسول الله صلى الله عليه وسلم';
  String day19 = ArabicNumbers().convert(19);
  String fulltasks =  ArabicNumbers().convert(3);
  Storage storage = new Storage();
    bool siam = false;
    bool quraan = false;
    bool qiam = false;
    int tasksResult = 0;
    int index = 19;
  
    Color _taskTextUnDoneColor = HexColor('#FFD700'); //gold
    Color _taskTextDoneColor = Colors.grey[700].withOpacity(.8);
    Color _taskCheckBoxUndone = Colors.blueAccent[400];
    Color _taskCheckBoxDone = HexColor('#FFD700'); //gold
    
    
  @override
  void initState() {
    super.initState();
    // get bools state from external file to app in initial
    storage.getBool('siam$index').then((value) {
      if (value!=null) {
        setState(() {
        siam = value;
      });
      }
      
    });
    storage.getBool('quraan$index').then((value) {
       if (value!=null) {
        setState(() {
        quraan = value;
      });
      }
      
    });
    storage.getBool('qiam$index').then((value) {
       if (value!=null) {
        setState(() {
        qiam = value;
      });
      }
    storage.getInt('tasksresult$index').then((value){
      if (value!=null) {
        setState(() {
          tasksResult = value;
        });
      }
    });  
      
    });
  }
  
    @override
    Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
        body: Container(
          decoration: BoxDecoration(image: DecorationImage(
            fit: BoxFit.cover,
            image:AssetImage('images/daydetailsbackground.png'),
          //  colorFilter: ColorFilter.mode(Colors.g, BlendMode.colorBurn)
            )),
          child: Hero(tag: 'day$widget.index', child:Center(
            child: Container(
            height:height*.60,
            width: width*.9,
              child: Card(
                color: Colors.greenAccent[400],
                child: Container(
                  decoration: BoxDecoration(image:DecorationImage(
                 fit: BoxFit.cover,
                 repeat: ImageRepeat.repeatX,
                 image:AssetImage('images/daydetails.jpg'),
                // colorFilter: ColorFilter.mode(Colors.white, BlendMode.colorBurn)
                 )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: height*.03,),
                          Container(
                            padding: EdgeInsets.only(left: 2,right: 3),
                            decoration: BoxDecoration(border:Border.all(color: Colors.white,
                            width: 2),borderRadius: BorderRadius.circular(10)),
                            child: Text('$day19 '+'رمضان',style: TextStyle(fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: ArabicFonts.Cairo,
                            color: Colors.white),textAlign: TextAlign.center,),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5,right: 5),
                            height: height*.33,
                            width: width*.9,
                            child: ListView(
                              shrinkWrap: true,
                              children:<Widget> [
                                Text(_hadithSource,style: TextStyle(color: Colors.white,fontSize:30,
                                fontFamily: ArabicFonts.Cairo ),
                                textAlign: TextAlign.center,),
                                Text(_hadithHeart,style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold,
                                fontFamily: ArabicFonts.Cairo)
                                , textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                          
                        ]),
                          
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Center(child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                                child: Text('مهام اليوم '+'($fulltasks/${ArabicNumbers().convert(tasksResult)})',style: TextStyle(
                                  fontFamily:ArabicFonts.Cairo,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent[400]
                                ),),
                              ),),
                              SizedBox(height: 5,),
                              Container(  
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  
                                ),
                                // Tasks main row
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                 
                                 //siam little row
                                 Row(mainAxisAlignment: MainAxisAlignment.center,
                                 children: [Text('صيام اليوم',style:TextStyle(
                                   color:siam==false? _taskTextUnDoneColor:_taskTextDoneColor,
                                   fontWeight: FontWeight.bold,
                                   fontFamily: ArabicFonts.Cairo,
                                   decoration:siam==true?TextDecoration.lineThrough:TextDecoration.none)
                                  ,),IconButton(icon: siam==true?Icon(Icons.check_box,color: _taskCheckBoxDone,):
                                 Icon(Icons.check_box_outline_blank,color: Colors.red[600],), onPressed: (){
                                   setState(() {
                                     if(siam==false){
                                     siam=true;
                                     tasksResult = tasksResult+1;
                                     }
                                     //write Data To File After setting its state
                                     storage.saveBool('siam$index', siam);
                                     storage.setInt('tasksresult$index', tasksResult);
                                     print('$siam');
                                     Fluttertoast.showToast(msg: 'تقبَّل اللَّه',textColor: Colors.white,backgroundColor: HexColor('#FFD700')); //gold
                                   });
                                 })],),
                                
                                // quraan little row
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                 children: [Text('قراءة القرآن',style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontFamily: ArabicFonts.Cairo,
                                   color:quraan==false? _taskTextUnDoneColor:_taskTextDoneColor,
                                   decoration:quraan==true? TextDecoration.lineThrough:TextDecoration.none),),
                                   IconButton(icon: quraan==true?Icon(Icons.check_box_rounded,color: _taskCheckBoxDone,):
                                 Icon(Icons.check_box_outline_blank,color: _taskCheckBoxUndone,), onPressed: (){
                                   setState(() {
                                     if(quraan==false){
                                     quraan=true;
                                     tasksResult = tasksResult+1;
                                     }
                                     //write Data to File After setting its state
                                     storage.saveBool('quraan$index', quraan);
                                     storage.setInt('tasksresult$index', tasksResult);
                                     Fluttertoast.showToast(msg: 'تقبَّل اللَّه',textColor: Colors.white,backgroundColor: HexColor('#FFD700')); //gold
                                     
                                   });
                                 })],),
                                 
                                 // qiam little row
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                 children: [Text('صلاة القيام',style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontFamily: ArabicFonts.Cairo,
                                   color: qiam==false?_taskTextUnDoneColor:_taskTextDoneColor,
                                   decoration:qiam==true? TextDecoration.lineThrough:TextDecoration.none),),
                                   IconButton(icon: qiam==true?Icon(Icons.check_box,color: _taskCheckBoxDone,):
                                 Icon(Icons.check_box_outline_blank,color: _taskCheckBoxUndone,), onPressed: (){
                                   setState(() {
                                     if(qiam==false){
                                       qiam=true;
                                     tasksResult = tasksResult+1;
                                     }
                                     //Write data after setting its state
                                     storage.saveBool('qiam$index', qiam);
                                     storage.setInt('tasksresult$index', tasksResult);
                                     Fluttertoast.showToast(msg: 'تقبَّل اللَّه',textColor: Colors.white,backgroundColor: HexColor('#FFD700')); //gold
                                   });
                                 })],),
                                 
                                ],),
                              ),
                            ],
                          ),
                        
                    ],
                  ),
                ),
              ),
            ),
          )),
        ),
        floatingActionButton: FloatingActionButton(backgroundColor: Colors.greenAccent[700],
         child: Icon(Icons.reply_outlined,color: Colors.white,),
       onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));}),
      ),
      );
    }
  }
  
