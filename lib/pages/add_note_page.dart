import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../providers/note_provider.dart';

class AddNotePage extends StatefulWidget {
  final Function addNote;
  const AddNotePage({
    Key? key,
    required this.addNote,
  }) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: [
              TextField(
                controller: titleController,
              ),
              TextField(
                controller: textController,
                minLines: 3,
                maxLines: 5,
              ),
            ],
          )),
      actions: [
        TextButton(
            onPressed: () async {
              await context.read<NoteProvider>().createNote(
                  title: titleController.text, text: textController.text);
              widget.addNote();
            },
            child: Text("Kaydet")),
      ],
    );
  }
}
