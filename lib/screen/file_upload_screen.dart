import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class FileUpload extends StatefulWidget {
  const FileUpload({Key? key}) : super(key: key);

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  File? image;
  final _picker=ImagePicker();
  bool showSpinner=false;
  Future getImage()async{
    final pickedFile=await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    if(pickedFile!=null){
    image=File(pickedFile!.path);
    setState(() {

    });
    }else{

    }
  }
  Future<void> uploadImage()async{
    setState(() {
      showSpinner=true;
    });
    var stream= await http.ByteStream(image!.openRead());
    stream.cast();
    var length=await image!.length();
    var uri=Uri.parse("https://fakestoreapi.com/products");
    var request=await http.MultipartRequest('POST',uri);
    request.fields['title']="static title";
    var multiPart=await http.MultipartFile('image',stream,length);
    request.files.add(multiPart);
    var response=await request.send();
    if(response.statusCode==200){
      setState(() {
        showSpinner=false;
      });
        print("succeed");
    }else{
      setState(() {
        showSpinner=false;
      });
      print("failed");
    }
  }
  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(title: Text("File Upload"),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: getImage,
              child: Container(
                child: image == null
                    ? Center(child: Text("Pick Up Image"))
                    : Container(
                  child: Center(
                    child: Image.file(
                      image!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 150,),
            GestureDetector(
              onTap: uploadImage,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child:Text("Sign Up")),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
