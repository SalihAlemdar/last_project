import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:last_project/models/note_model.dart';
import 'package:last_project/services/services.dart';

class NoteProvider extends ChangeNotifier {
  NoteModel note = NoteModel(title: "", text: "", createdAt: DateTime.now(), updataedAt: DateTime.now());
  List<NoteModel> notes = [];

  Services services = Services();
  Future getList() async {
    notes.clear();
    notes = await services.getNotes();
    notifyListeners();
  }

  setNote(NoteModel n) {
    note = n;
    notifyListeners();
  }

  Future createNote({required String title, required String text}) async {
    NoteModel? n = NoteModel(title: title, text: text, createdAt: DateTime.now(), updataedAt: DateTime.now());
    n = await services.postNote(n);
    if (n != null) {
      notes.add(n);
      notifyListeners();
    }
  }
}
