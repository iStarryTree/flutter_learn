import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

class PFolderPicker extends StatefulWidget {
  const PFolderPicker({super.key});

  @override
  State<PFolderPicker> createState() => _PFolderPickerState();
}

class _PFolderPickerState extends State<PFolderPicker> {
  String? _directoryPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 按钮和路径显示
        Row(
          children: [
            // 按钮
            SizedBox(
              width: 120,
              child: FloatingActionButton.extended(
                label: const Text('选择文件夹'),
                icon: const Icon(Icons.folder),
                onPressed: _selectFolder,
              ),
            ),

            // 显示路径
            Text(
              _directoryPath ?? "未选择路径",
            ),
          ],
        ),

        // 显示ListView
        Expanded (
          child: Container(
            width: 200,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Text("文件名");
              },
              itemCount: 10,
            ),
          ),
        ),
      ],
    );
  }

  void _selectFolder() async {
    String? path = await FilePicker.platform.getDirectoryPath(
      dialogTitle: "选择文件夹",
    );

    setState(() {
      _directoryPath = path;
    });
  }
}
