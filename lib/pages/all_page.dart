import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:last_project/models/note_model.dart';
import 'package:last_project/pages/add_note_page.dart';
import 'package:last_project/providers/note_provider.dart';
import 'package:provider/provider.dart';

import '../components/app_colors.dart';
import '../components/curved_box.dart';

class AllView extends StatelessWidget {
  const AllView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddNotePage(
              addNote: () {
                Navigator.pop(context);
              },
            ),
          );
        },
        child: const Icon(
          FontAwesomeIcons.notesMedical,
          color: AppColors.white,
        ),
      ),
      body: AnimationLimiter(
        child: MasonryGridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemCount: context.watch<NoteProvider>().notes.length,
            itemBuilder: (context, i) {
              NoteModel note = context.watch<NoteProvider>().notes[i];
              return AnimationConfiguration.staggeredGrid(
                  position: i,
                  columnCount: 2,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: CurvedBox(
                        children: [
                          Text(
                            note.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(note.text.substring(0,
                              note.text.length > 50 ? 50 : note.text.length)),
                          const SizedBox(
                            height: 16,
                          ),
                          DateFooter(
                              date:
                                  "${note.updataedAt.year}:${note.updataedAt.month}:${note.updataedAt.day}",
                              footerText: 'Not')
                        ],
                      ),
                    ),
                  ));
            }),
      ),
    );
  }
}

class _ListTileRow extends StatelessWidget {
  const _ListTileRow({Key? key, required this.isChecked, required this.text})
      : super(key: key);
  final String text;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 32,
          width: 16,
          child: Checkbox(
            shape: const CircleBorder(
              side: BorderSide(
                width: 2,
                color: AppColors.white,
              ),
            ),
            value: isChecked,
            activeColor: AppColors.white,
            checkColor: AppColors.grey,
            onChanged: (bool? val) {},
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  decoration: isChecked ? TextDecoration.lineThrough : null)),
        )
      ],
    );
  }
}

class DateFooter extends StatelessWidget {
  const DateFooter({Key? key, required this.date, required this.footerText})
      : super(
          key: key,
        );
  final String date, footerText;
  final TextStyle style = const TextStyle(color: AppColors.lightGrey);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          date,
          style: style,
        ),
        Text(
          footerText,
          style: style,
        )
      ],
    );
  }
}
