import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ramadany/storage.dart';
class Masbaha extends StatefulWidget {
  @override
  _MasbahaState createState() => _MasbahaState();
}

class _MasbahaState extends State<Masbaha> {
 List<String> tasbih = ['سبحان الله','والحمد لله','ولا إله إلا الله','ولاحول ولا قوة إلا بالله','والله أكبر'];
 String userinput = 'تسبيح متنوع';  
 bool userInputBool = false;
int count = 0;
Storage storage = Storage();
//tasbih series counter
int recounting(){
  int counting;
 if (count>0) {
    if (count%5==0) {
    counting = 4;
  }
  if (count%5==1) {
    counting = 0;
  }
  if (count%5==2) {
    counting = 1;
  }
  if (count%5==3) {
    counting = 2;
  }
  if (count%5==4) {
    counting = 3;
  }
 }
  else{
    //case count = 0
    counting = 0;
  }
  return counting;
}
@override
  void initState() {
    super.initState();
   storage.getInt('count').then((value) {
     if (value!=null) {
        setState(() {
       count = value;
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
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/masbahabackground.png'),fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height*.1,
                width: width,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: width*.27,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                         decoration: BoxDecoration(
                           shape: BoxShape.rectangle,
                           borderRadius: BorderRadius.circular(15),
                           color: Colors.blueAccent
                         ),
                         child: 
                         //add tasbih from user input
                        DropdownButton(items: [
                          DropdownMenuItem(child: Text('تسبيح متنوع'),value: 'تسبيح متنوع',),
                          DropdownMenuItem(child: Text('أستغفر الله'),value: 'أستغفر الله',),
                          // DropdownMenuItem(child: Text('لاإله إلا أنت سبحانك \nإنى كنت من الظالمين'),value: 'لاإله إلا أنت سبحانك \nإنى كنت من الظالمين',),
                          DropdownMenuItem(child: Text('سبحان الله'),value: 'سبحان الله',),
                          DropdownMenuItem(child: Text('الحمد لله'),value: 'الحمد لله',),
                          DropdownMenuItem(child: Text('لا إله إلا الله'),value: 'لا إله إلا الله',),
                          DropdownMenuItem(child: Text('لاحول ولا قوة إلا بالله'),value: 'لاحول ولا قوة إلا بالله',),
                          DropdownMenuItem(child: Text('الله أكبر'),value: 'الله أكبر',),
                        ].toList(),
                        dropdownColor: Colors.blueAccent[400],
                        underline:Divider(color: Colors.transparent,),
                        style: TextStyle( color:Colors.white,fontWeight: FontWeight.bold,),
                        iconSize: 35,iconEnabledColor: Colors.white,
                        hint: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10,),
                            Text(userinput,textAlign: TextAlign.end,style: TextStyle(color: Colors.white),),
                          ],
                        ), onChanged: (String value){
                           setState(() {
                             if (value!= null || value.toString()!='' || value.toString()!='تسبيح متنوع') {
                             userinput = value;  
                             userInputBool = true;
                             }
                             if (value!= null && value.toString()!='' && value=='تسبيح متنوع' ) {
                               userInputBool = false;
                               userinput = value;
                               
                             }

                        }); },)
                   ),
                   SizedBox(width: width*.10,),
                    Row(
                      children: [
                        Container(
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           border: Border.all(color: Colors.red[900],width:5),
                           color: Colors.grey[800]
                         ),
                         //restart counter
                         child: MaterialButton(child:
                         Icon(Icons.replay,color: Colors.white,size: 25,),
                         minWidth: .1,
                          onPressed: (){
                            setState(() {
                              count=0;
                            });
                            storage.setInt('count', count);
                            Fluttertoast.showToast(msg: 'تمت اعادة الضبط');
                          },),
                   ),
                      ],
                    )]
                      ,
                    )]
                  ),
                ),
              ),
              Center(
                //masbaha view
                child: Container(
                  height:height*.3 ,
                  width:width*.5 ,
                  decoration: BoxDecoration(image:DecorationImage(image: AssetImage('images/masbaha.png'),fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       SizedBox(height: height*.022,),
                       //tasbih type
                       userInputBool==false? Text(tasbih[recounting()],
                       style: TextStyle(color: Colors.white,
                       fontSize: 14,fontWeight: FontWeight.w900),):
                       //user input
                       Text(userinput,style: TextStyle(color: Colors.white,
                       fontSize: 14,fontWeight: FontWeight.w900)),
                       SizedBox(height: height*.015,),
                      Text(count.toString(),style: TextStyle(fontFamily:'kkjk',fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white)
                      ,textAlign: TextAlign.center,)],
                     ),
                ),
              ),
              SizedBox(height:height*.05),
              Container(
              decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.black54,width:10)),
              height:height*.5 ,
              width: width*.95, 
              child: 
              Material( color:Colors.blueAccent[400] ,
              type: MaterialType.circle,
               child:MaterialButton(
                 highlightColor: Colors.transparent,
                 child:Center(child:
                 Icon(Icons.touch_app,color: Colors.white,size: 75,),) ,
                 onPressed:(){
               setState(() {
                 count ++;
                 if (count==1000000) {
                   Fluttertoast.showToast(msg: 'لقد اتممت مليون تسبيحة , تقبل الله',
                   textColor:Colors.white,backgroundColor: HexColor('#FFD700'),toastLength: Toast.LENGTH_LONG);
                   count = 0;
                 }
               });
               storage.setInt('count', count);
              }) ,) 
              ,)
            ],
          ),
        ),
      ),
    );
  }
}