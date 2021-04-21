// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:ramadany/storage.dart';
class Moshaf extends StatefulWidget {
  final File file;
  final int page;
  Moshaf({this.file,this.page});
  @override
  _MoshafState createState() => _MoshafState();
}

class _MoshafState extends State<Moshaf> {
  int page = 0;
  PDFViewController controller;
  TextEditingController editcontroller = TextEditingController();
  Storage storage = Storage();
  String key = 'page';
  String markedPageKey = 'markedpage';
  int markedPage = 1;
  bool markedPageBool = false;
  @override
  void initState() {
    super.initState();
    // first get int must be Added as a super constructor to go along with widget.file in initial speed
  //  storage.getInt(key).then((value) 
  setState(() {
    page = Moshaf().page;
  });
  //marked page int 
   storage.getInt(markedPageKey).then((value) {
   setState(() {
     if (value!=null) {
      markedPage = value; 
     }
   });
   });
  //if current page is marked
    if (markedPage==page) {
    setState(() {
     markedPageBool = true;
        });
        }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(centerTitle: true,title: Text('القُرآن الكَريم',
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
        backgroundColor: Colors.blueAccent[700],
        actions: [
          InkWell(child: Center(child: Text('إلى العلامة',style: TextStyle(color: Colors.white),)),
          onTap: (){
            if (markedPage!=null||markedPage!=0) {
              setState(() {
                page = markedPage;
              });
              controller.setPage(markedPage+1);
              storage.setInt(key,page);
            }
            else{
              Fluttertoast.showToast(msg: 'لم يتم وضع علامة على أى صفحة');
            }
          },
          ),
          IconButton(icon: Icon(Icons.arrow_drop_down_circle), onPressed: (){
            if (markedPage!=null||markedPage!=0) {
              setState(() {
                page = markedPage;
              });
              controller.setPage(markedPage+1);
              storage.setInt(key,page);
            }
            else{
              Fluttertoast.showToast(msg: 'لم يتم وضع علامة على أى صفحة');
            }
          }),
        ],
        ),
        body:
        // full body container
         Container(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 2,),
              //controllercontainer
              Container(
                width: width,
                height: height*.05,
                color: Colors.white,
                child:Row (
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //marked page
                    markedPageBool == true?
                    //page is marked
                    Container(
                      child: Row (mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(icon:Icon(Icons.bookmark,color: Colors.red[600],size: 35,),
                        onPressed: (){
                  Fluttertoast.showToast(msg: 'تم وضع علامة على الصفحة بالفعل',textColor: Colors.white ,backgroundColor: Colors.redAccent[400]);},),        
                    ],),):
                    //page not marked
                    Container(
                      child: IconButton(
                       icon: Icon(Icons.bookmark_border,size: 35,color: Colors.blueAccent[700],),
                       onPressed: (){
                       setState(() {
                         markedPage = page;
                         markedPageBool= true;
                       });
                       storage.setInt(markedPageKey,markedPage);
                  Fluttertoast.showToast(msg: 'تم وضع علامة على الصفحة',textColor: Colors.white ,backgroundColor: Colors.redAccent[400]);
                   }),
                    ),
                   SizedBox(width:width*.235 ,),
                    //to fehrest
                  Container(decoration:BoxDecoration(color: Colors.blueAccent[700],borderRadius: BorderRadius.circular(20)) ,
                   child: MaterialButton(
                     child: Text('الفهرست',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                     onPressed: (){
                       // -1 cause index start by 0 so for example page 5 index = 4
                     setState(() {
                       page = 619-1;
                     });
                     controller.setPage(page);
                     storage.setInt(key,page);
                   })),
                   SizedBox(width:width*.135 ,),
                   //go to page
                   Container(
                     width: width*.25,
                     child: TextField(
                       cursorColor: Colors.blueAccent[700],
                       style: TextStyle(color: Colors.blueAccent[700],fontWeight: FontWeight.bold),
                       keyboardType: TextInputType.number,
                       controller: editcontroller,
                       decoration: InputDecoration(
                       hintText: 'إذهب لصفحة رقم ...',
                       hintStyle: TextStyle(color: Colors.blueAccent[700],fontWeight: FontWeight.bold),
                       ),autofocus: false,
                       onEditingComplete: (){
                        //Sring to int
                       var goToPage = int.parse(editcontroller.text,).toInt();
                       // print('$goToPage');
                        setState(() {
                         page = goToPage-1; 
                        });
                      controller.setPage(page);
                      storage.setInt(key, page);

                 if (markedPage==page) {
                   setState(() {
                     markedPageBool = true;
                   });
                 }
                 if (markedPage!=page) {
                   setState(() {
                     markedPageBool = false;
                   });
                 }
                      editcontroller.clear();
                       },)),
                       SizedBox(width: width*.01,)
                  ],)),
                  SizedBox(height: 2,),
              //pdf viewer container
              Container(
                width: width,
                height: height*.83,
                child:
                 PDFView(filePath: widget.file.path,
                 //at start
                 defaultPage: widget.page+1,
                 // rendring
                 onRender: (lastpage){
                   //if current page is marked
                   if (markedPage==page) {
                     setState(() {
                       markedPageBool = true;
                     });
                   }
                 },
                 onPageChanged: (index,_){
                   // -1 caus index start by 0 for example page 5 index = 4
                 setState(() {
                   page = index-1;          
                 });
                 storage.setInt(key, page);
                 //marking
                 //if page is marked
                 if (markedPage==page) {
                   setState(() {
                     markedPageBool = true;
                   });
                 }
                 if (markedPage!=page) {
                   setState(() {
                     markedPageBool = false;
                   });
                 }
                 },
                 onViewCreated: (controller){
                  this.controller = controller;
                 },),

                 ),
            ],
          ),
        ),
        ),
    );
    
  }
}