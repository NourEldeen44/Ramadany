import 'dart:convert';

import 'package:flutter/material.dart';
class Azkar extends StatefulWidget {

  @override
  _AzkarState createState() => _AzkarState();
}

class _AzkarState extends State<Azkar> {
  bool allZekr = true;
  bool sabahZekr = false;
  bool masaaZekr = false;
  bool otherZekr = false;
  Color activeButtonColor = Colors.brown.withGreen(50);
//Color buttonColor = Colors.black38.withBlue(20);
 
//  Future<List<AzkarStorage>> dsd ;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title:sabahZekr==true?Text('أذكار الصَّباح'):masaaZekr==true?Text('أذكار المساء'):
        otherZekr==true? Text(' أذكار متنوعة'):Text('كل الأذكار'),
        backgroundColor:Colors.black38.withBlue(50),),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
            fit: BoxFit.cover,
            image:AssetImage('images/daydetails.jpg',),
           colorFilter: ColorFilter.mode(Colors.black38,BlendMode.multiply)
            )
          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: width,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Button 1 all
                     Container(
                      decoration: BoxDecoration(color: allZekr==true? activeButtonColor:null,borderRadius: BorderRadius.circular(20)),
                     child: MaterialButton(child:Text('كل الأذكار',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)) , onPressed: (){
                     setState(() {
                       allZekr = true;
                       masaaZekr = false;
                       sabahZekr = false;
                       otherZekr = false;
                     });
                   }),),
                   //Button2 sabah
                   Container(
                     decoration: BoxDecoration(color: sabahZekr==true? activeButtonColor:null,borderRadius: BorderRadius.circular(20)),
                   child: MaterialButton(child:Text('أذكار الصَّباح',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                    onPressed: (){
                     setState(() {
                       sabahZekr = true;
                       masaaZekr = false;
                       otherZekr = false;
                       allZekr = false;
                     });
                   }),),
                   //Button3 masaa 
                   Container(
                      decoration: BoxDecoration(color: masaaZekr==true? activeButtonColor:null,borderRadius: BorderRadius.circular(20)),
                     child: MaterialButton(child:Text('أذكار المساء',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                      onPressed: (){
                     setState(() {
                       masaaZekr = true;
                       sabahZekr = false;
                       otherZekr = false;
                       allZekr = false;
                     });
                   }),),
                   //Button4 other
                   Container(
                      decoration: BoxDecoration(color: otherZekr==true? activeButtonColor:null,borderRadius: BorderRadius.circular(20)),
                     child: MaterialButton(child:Text('منوعات',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                      onPressed: (){
                     setState(() {
                       otherZekr = true;
                       sabahZekr = false;
                       masaaZekr = false;
                       allZekr = false;
                     });
                   }),),
                  
                  ],
                  ),
                ),
                Container(
                  height: height-130,
                  width: width,
                  child: FutureBuilder(builder: (context,snapshot){
                    var data = json.decode(snapshot.data.toString());
                    return ListView.builder(
                      addAutomaticKeepAlives: false,
                      itemBuilder: (context,index){
                      var category = data[index]['category'];
                      var zekr = data[index]['zekr'];
                      var discription = data[index]['description'];
                      return sabahZekr==true && category == 'أذكار الصباح'? 
                       Padding(
                         padding:  EdgeInsets.only(bottom:8.0,left: 5,right: 5),
                         child: Container(
                           padding: EdgeInsets.all(5),
                           decoration: BoxDecoration(border: Border.all(color: Colors.black45,width: 4,),
                           borderRadius:BorderRadius.circular(15) ),
                           //main sabah zekr
                          child: ListTile(
                          title: Text(zekr,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                          subtitle:Text(discription,style: TextStyle(color: Colors.white,fontSize: 15),) ,
                          ),
                      ),
                       ):masaaZekr==true && category == 'أذكار المساء' ?
                       Padding(
                         padding:  EdgeInsets.only(bottom:8.0,left: 5,right: 5),
                         child: Container(
                           padding: EdgeInsets.all(5),
                           decoration: BoxDecoration(border: Border.all(color: Colors.black45,width: 4,),
                           borderRadius:BorderRadius.circular(15) ),
                           //main masaa zekr
                          child: ListTile(
                          title: Text(zekr,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                          subtitle:Text(discription,style: TextStyle(color: Colors.white,fontSize: 15),) ,
                          ),
                      ),
                       ):
                       otherZekr==true && category != 'أذكار المساء' && category != 'أذكار الصباح' ?
                        Padding(
                         padding:  EdgeInsets.only(bottom:8.0,left: 5,right: 5),
                         child: Container(
                           padding: EdgeInsets.all(5),
                           decoration: BoxDecoration(border: Border.all(color: Colors.black45,width: 4,),
                           borderRadius:BorderRadius.circular(15) ),
                           //main other zekr
                          child: ListTile(
                          title: Text(zekr,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                          subtitle:Text(category,style: TextStyle(color: Colors.white,fontSize: 15),) ,
                          ),
                      ),
                       ):
                       sabahZekr==false && masaaZekr==false && otherZekr==false?
                         Padding(
                         padding:  EdgeInsets.only(bottom:8.0,left: 5,right: 5),
                         child: Container(
                           padding: EdgeInsets.all(5),
                           decoration: BoxDecoration(border: Border.all(color: Colors.black45,width: 4,),
                           borderRadius:BorderRadius.circular(15) ),
                           //main full zekr
                          child: ListTile(
                          title: Text(zekr,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                          subtitle:Text(discription,style: TextStyle(color: Colors.white,fontSize: 15),) ,
                          ),
                      ),
                       ):
                        SizedBox(height: 0,); 
                    },itemCount: snapshot.hasData? data.length:0,);
                  },
                  future: DefaultAssetBundle.of(context).loadString('assetjson/azkar.json') ,
          ),
                ),
              ],
            ),
      ),
        )
    );
  }
}