import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Demo')),
        // body: Center(child: FolderPicker()),
        body: Center(child: MyListView()),
      ),
    );
  }
}

// 一个按钮，点击选择文件夹
class FolderPicker extends StatefulWidget {
  const FolderPicker({super.key});

  @override
  State<FolderPicker> createState() => _FolderPickerState();
}

class _FolderPickerState extends State<FolderPicker> {
  String? _directoryPath;
  List<FileSystemEntity>? fileList;

  void _selectFolder() async {
    // try{
    String? path = await FilePicker.platform.getDirectoryPath(
      dialogTitle: "选择文件夹",
      lockParentWindow: true,
    );
    setState(() {
      _directoryPath = path;
      if (_directoryPath != null) {
        fileList = Directory(_directoryPath!)
            .listSync()
            .where((file) => file.path.endsWith('.pdf'))
            .toList();
      }
    });
    // } on PlatformException(e){
    //   // _logException(e.toString());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 120,
          child: FloatingActionButton.extended(
            onPressed: _selectFolder,
            label: const Text("选择文件夹"),
            icon: const Icon(Icons.folder),
          ),
        ),
        Expanded(
            // child: ListView(
            //   children: fileList?.map((e) => Text(p.basename(e.path))).toList() ?? [],
            // )
            child: ListView.builder(
                itemCount: fileList?.length,
                itemBuilder: (e, index) {
                  String text = "";
                  if (fileList != null) {
                    text = p.basename(fileList![index].path);
                  }
                  return Text(text);
                })),
      ],
    );
  }
}

// void _selectFolder() async {
//   _resetState();
//   try {
//     String? path = await FilePicker.platform.getDirectoryPath(
//       dialogTitle: _dialogTitleController.text,
//       initialDirectory: _initialDirectoryController.text,
//       lockParentWindow: _lockParentWindow,
//     );
//     setState(() {
//       _directoryPath = path;
//       _userAborted = path == null;
//     });
//   } on PlatformException catch (e) {
//     _logException('Unsupported operation' + e.toString());
//   } catch (e) {
//     _logException(e.toString());
//   } finally {
//     setState(() => _isLoading = false);
//   }
// }

class MyListView extends StatefulWidget {
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List<String> items = List.generate(50, (index) => "Item $index");
  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return CheckboxListTile(
                  value: selectedItems.contains(item),
                  title: Text(item),
                  onChanged: (value) {
                    setState(() {
                      value!
                          ? selectedItems.add(item)
                          : selectedItems.remove(item);
                    });
                  });
            },
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            // Handle button press to get selected items
            print(selectedItems);
          },
          child: Text('Get Selected Items'),
        ),
      ],
    );
  }
}
