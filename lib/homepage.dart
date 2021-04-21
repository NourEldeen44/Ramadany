import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ramadany/Days/day1.dart';
import 'package:ramadany/Days/day10.dart';
import 'package:ramadany/Days/day11.dart';
import 'package:ramadany/Days/day12.dart';
import 'package:ramadany/Days/day13.dart';
import 'package:ramadany/Days/day14.dart';
import 'package:ramadany/Days/day15.dart';
import 'package:ramadany/Days/day16.dart';
import 'package:ramadany/Days/day17.dart';
import 'package:ramadany/Days/day18.dart';
import 'package:ramadany/Days/day19.dart';
import 'package:ramadany/Days/day2.dart';
import 'package:ramadany/Days/day20.dart';
import 'package:ramadany/Days/day21.dart';
import 'package:ramadany/Days/day22.dart';
import 'package:ramadany/Days/day23.dart';
import 'package:ramadany/Days/day24.dart';
import 'package:ramadany/Days/day25.dart';
import 'package:ramadany/Days/day26.dart';
import 'package:ramadany/Days/day27.dart';
import 'package:ramadany/Days/day28.dart';
import 'package:ramadany/Days/day29.dart';
import 'package:ramadany/Days/day3.dart';
import 'package:ramadany/Days/day30.dart';
import 'package:ramadany/Days/day4.dart';
import 'package:ramadany/Days/day5.dart';
import 'package:ramadany/Days/day6.dart';
import 'package:ramadany/Days/day7.dart';
import 'package:ramadany/Days/day8.dart';
import 'package:ramadany/Days/day9.dart';
import 'package:ramadany/azkar.dart';
import 'package:ramadany/masbaha.dart';
import 'package:ramadany/moshaf.dart';
import 'package:ramadany/storage.dart';
import 'package:url_launcher/url_launcher.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 final GlobalKey<ScaffoldState> scaffoldGlobalKey = GlobalKey<ScaffoldState>();
 bool isLoading ;
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldGlobalKey,
        //tools
      drawer: Drawer(
        child: Container(decoration: BoxDecoration(gradient:
         LinearGradient(colors: [HexColor('#128C7E'),HexColor('#075E54'),],
         end: Alignment.topCenter,begin: Alignment.bottomCenter))
          ,child:Column( mainAxisAlignment: MainAxisAlignment.center,
        children: [ 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Divider(color: Colors.white,thickness: 2,),
              Icon(Icons.home,color: Colors.grey[300],size: 30,),
              // Divider(color: Colors.white,thickness: 2,)
            ],
          ),
          Divider(color: Colors.white,thickness: 1,indent: width*.1,endIndent: width*.1,),
          SizedBox(height: height*.05,),
          //moshaf
          ListTile(title:isLoading==true? Center(child: CircularProgressIndicator(),):
          isLoading==false?
          Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' المُصحف ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.grey[300]),),
            Container(height: height*.052,width: width*.14, child: Image.asset('images/moshaf.png',fit: BoxFit.contain,))
            // Icon(Icons.menu_book_rounded,color: Colors.grey[300],size: 30,)
          ],): Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' المُصحف ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.grey[300]),),
            Container(height: height*.052,width: width*.14, child: Image.asset('images/moshaf.png',fit: BoxFit.contain,))        
            // Icon(Icons.menu_book_rounded,color: Colors.grey[300],size: 30,)
          ],),onTap: ()async{
            String moshafPath = 'assetpdf/moshaf.pdf';
            Storage storage = Storage();
            //note : isLoading = null at intial
            //make it loading till data is bufferd and file is written
            setState(() {
              isLoading = true;
            });
            File file = await storage.loadFile(moshafPath);
            //stop loading after file is ready
            setState(() {
              isLoading = false;
            });
            int page;
             storage.getInt('page').then((value) {
               if (value!=null) {
                 page= value;
               }
               else{
                 page = 0;
               }
             });
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Moshaf(file: file,page: page,)));} ,),
           SizedBox(height: height*.05,),
           //azkar
          ListTile(title:Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' الأذكَار ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.grey[300]),),
            Container(height: height*.06,width: width*.2, child: Image.asset('images/azkar.png' ,color: Colors.white,fit: BoxFit.contain,))
            // Icon(Icons.favorite,color: Colors.red,size: 30,),
            // Icon(Icons.campaign,color: Colors.grey[300],size: 30,),
          ],),onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Azkar()));} ,),
          //masbaha
          SizedBox(height: height*.05,),
          ListTile(title:Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' المسبّحة ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.grey[300]),),
            Container(height: height*.052,width: width*.14, child: Image.asset('images/masbaha.png',fit: BoxFit.contain,))
            // Icon(Icons.touch_app_rounded,color: Colors.grey[300],size: 30,),
          ],),onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Masbaha()));} ,),
            SizedBox(height: height*.05,),
            //more
          Center(child: Text('المزيد',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey[300])),),
          Divider(color: Colors.white,thickness: 1,indent: width*.1,endIndent: width*.1,),
           ListTile(title:Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' مَواقيت الصّلاة ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.grey[300]),), 
            Icon(Icons.calendar_today,color: Colors.grey[300],)
          //launch url مواقيت الصلاة 
          ],),onTap: ()async {if (await canLaunch('https://goo.gl/CJhtxe')) {
            await launch('https://goo.gl/CJhtxe',forceWebView:false ,forceSafariVC:true ,headers:<String,String>{'headerkey':'headervalue'} );
          } else {
            Fluttertoast.showToast(msg: 'الإتصال بالإنترنت مقطوع'); 
          } } ,),
          SizedBox(height: height*.05,),
           ListTile(
             title:Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' حول ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey[300]),),
             Icon(Icons.info_outline,color: Colors.grey[300]), 
          ],)
           ,),
          Divider(color: Colors.white,thickness: 1,indent: width*.1,endIndent: width*.1,),
          SizedBox(height: height*.02,),
          Center(child: Text('App: V 1.0.0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey[300])),),
          Center(child: Text('\n',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 2,color: Colors.grey[300])),),
          Center(child: Text(' نور الدين :Dev',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey[300])),),
          Center(child: Text('للتواصل : nourtech2021@gmail.com ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey[300])),)
        
        ], ) )
      ),  
      body: 
      CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.greenAccent[700].withAlpha(255),
          pinned: true,
          primary: true,
          expandedHeight: 120,
          leading: InkWell(child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(' الأدوات ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
          Icon(Icons.menu,color: Colors.white,size: 35,)],),onTap: (){
            //open drawer
            scaffoldGlobalKey.currentState.openDrawer();},),
          flexibleSpace: FlexibleSpaceBar(stretchModes: [
            //refresh
          ],
          title: Text('رمضاني',style: TextStyle(
            fontFamily: ArabicFonts.Rakkas,
           fontWeight: FontWeight.bold,
          ),),
        background: GestureDetector(child: Image.asset('images/appbar.jpg',fit: BoxFit.cover,),onTap: (){
          //open drawer
          scaffoldGlobalKey.currentState.openDrawer();
        },),)
       ,),SliverGrid(delegate: SliverChildListDelegate([
         Day1(),
         Day2(),
         Day3(),
         Day4(),
         Day5(),
         Day6(),
         Day7(),
         Day8(),
         Day9(),
         Day10(),
         Day11(),
         Day12(),
         Day13(),
         Day14(),
         Day15(),
         Day16(),
         Day17(),
         Day18(),
         Day19(),
         Day20(),
         Day21(),
         Day22(),
         Day23(),
         Day24(),
         Day25(),
         Day26(),
         Day27(),
         Day28(),
         Day29(),
         Day30(),
       ]), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3))
      ],)
      ),
    );
  }
}