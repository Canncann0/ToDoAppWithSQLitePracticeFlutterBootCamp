import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapppractice/Cubits/update_screen_cubit.dart';
import 'package:todoapppractice/Data/task_model.dart';

class UpdateScreen extends StatefulWidget {
  final TaskModel taskModel;
  const UpdateScreen({super.key, required this.taskModel});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.text = widget.taskModel.taskName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(
        title: Text(
          "Update Task",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 48,
                bottom: 48,
              ),
              child: TextField(
                controller: _controller,
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Task Name",
                  hintStyle: GoogleFonts.poppins(color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey.shade600,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.limeAccent, width: 1),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: ElevatedButton(
                  onPressed: () {
                    //buraya cubite gidecek fonsiyonu yaz
                    context.read<UpdateScreenCubit>().update(
                      widget.taskModel.id,
                      _controller.text,
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.limeAccent,
                    foregroundColor: Colors.grey.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    "Update",
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade900,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
