import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/note_model.dart';

class ApiConfig {
  static ApiConfig shared = ApiConfig();
  static String userId = "";
  static String baseUrl =
      "https://test-project-90b50-default-rtdb.europe-west1.firebasedatabase.app/$userId";
}

class Services {
  Uri getUrl(String endpoint) =>
      Uri.parse("${ApiConfig.baseUrl}/$endpoint.json");

  Future<List<NoteModel>> getNotes() async {
    http.Response response = await http.get(getUrl("notes"));
    List<NoteModel> list = [];
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = json.decode(response.body);
      for (var key in data.keys) {
        NoteModel note = NoteModel.fromMap(data[key]);
        note.id = key;
        list.add(note);
      }
    }
    return list;
  }

  Future<NoteModel?> getNoteById(String id) async {
    http.Response response = await http.get(getUrl("notes/$id"));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return NoteModel.fromJson(response.body)..id = id;
    } else {
      return null;
    }
  }

  Future<NoteModel?> postNote(NoteModel note) async {
    http.Response response = await http.post(getUrl("notes"),
        body: note.toJson(), headers: {"Content-Type": "application/json"});
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = json.decode(response.body);
      note.id = data["name"];
      return note;
    } else {
      return null;
    }
  }

  Future<bool> updateNote(NoteModel note) async {
    http.Response response = await http.put(getUrl("notes/${note.id}"),
        body: note.toJson(), headers: {"Content-Type": "application/json"});
    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<bool> deleteNote(String id) async {
    http.Response response = await http.delete(getUrl("notes/$id"));
    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
