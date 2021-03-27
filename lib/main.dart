import 'package:anuvad/constants/file_state.dart';
import 'package:anuvad/constants/styles.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:anuvad/repository/upload_download.dart';
import 'package:anuvad/widgets/appbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'package:timer_count_down/timer_count_down.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'BrandFont',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade800,
          ),
          bodyText1: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade800,
          ),
        ),
        primaryColor: Colors.white,
        accentColor: BrandColors.secondaryBlue,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UploadDownloadFile _uploadDownloadFile = new UploadDownloadFile();
  FileState fileState;
  String _fileName;
  @override
  void initState() {
    super.initState();
    fileState = FileState.uploading;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.getAppBar(),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
              child: Text(
            fileState == FileState.uploading
                ? 'Upload Your Video'
                : fileState == FileState.processsing
                    ? 'Processing your Video'
                    : 'Download Your Video',
            style: Theme.of(context).textTheme.headline1,
          )),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: BrandColors.lightBlue,
            ),
            width: 250,
            height: 250,
            child: fileState == FileState.uploading
                ? uploadFile(_uploadDownloadFile, context)
                : downloadFile(_uploadDownloadFile, context),
          )
        ],
      ),
    );
  }

  Widget downloadFile(
      UploadDownloadFile _uploadDownloadFile, BuildContext context) {
    return fileState == FileState.processsing
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Processing Time left: '),
              Countdown(
                seconds: 150,
                build: (BuildContext context, double time) =>
                    Text(time.toInt().toString()),
                interval: Duration(milliseconds: 100),
                onFinished: () {
                  setState(() {
                    fileState = FileState.downloading;
                  });
                },
              ),
            ],
          )
        : Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Container(
                height: 35,
                width: 130,
                child: MaterialButton(
                  onPressed: () async {
                    _showMyDialog('Downloading video...');
                    if (await Permission.storage.request().isGranted) {
                      var response =
                          await _uploadDownloadFile.downloadFile(_fileName);
                      Navigator.of(context).pop();
                      var message = response == FileState.downloaded
                          ? 'Your video has been Translated 😎'
                          : ' Oops! something went wrong 😐';
                      Toast.show(message, context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    }
                  },
                  child: Text(
                    'Download',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color: BrandColors.secondaryBlue,
              ),
            ),
          );
  }

  Widget uploadFile(
      UploadDownloadFile _uploadDownloadFile, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            FilePickerResult filePickerResult =
                await FilePicker.platform.pickFiles(
              type: FileType.custom,
              withData: true,
              allowedExtensions: ['mp4', 'mkv', '3gp'],
            );
            if (filePickerResult != null) {
              _showMyDialog('Uploading your video...');
              _fileName = filePickerResult.files.single.name;
              var file = filePickerResult.files.single.bytes;
              var currentFileState =
                  await _uploadDownloadFile.uploadFile(_fileName, file);
              Navigator.of(context).pop();
              setState(() {
                fileState = currentFileState;
              });
            }
          },
          child: Center(
            child: Image.asset(
              'images/folder.png',
              width: 70,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Click here to upload',
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }

  Future<void> _showMyDialog(String title) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(title),
        );
      },
    );
  }
}
