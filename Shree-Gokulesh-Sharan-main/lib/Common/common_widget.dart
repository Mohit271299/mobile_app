import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonWidget{

  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }
  final List locale =[
    {'name':'ENGLISH','locale': Locale('en','US')},
    {'name':'हिंदी','locale': Locale('hi','IN')},
    {'name':'ગુજરાતી','locale': Locale('gu','IN')},
  ];
  changeLanguage(BuildContext context)=> showDialog(context: context,
      builder: (builder){
        return AlertDialog(
          title: const Text('Choose Your Language'),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(child: Text(locale[index]['name']),onTap: (){
                      print(locale[index]['name']);
                      updateLanguage(locale[index]['locale']);
                      // Get.back();
                      // Get.updateLocale(locale);
                    },),
                  );
                }, separatorBuilder: (context,index){
              return Divider(
                color: Colors.blue,
              );
            }, itemCount: locale.length
            ),
          ),
        );
      }
  );
}