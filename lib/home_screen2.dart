import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/todo_provider2.dart';
import 'package:todo_list/todo_action2.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final TextEditingController _editingController2 = TextEditingController();
  final TextEditingController _subtitleController2 = TextEditingController();
  String newTask2 = '';
  String newSubtitle2 = '';
  DateTime? selectedDate2;
  TimeOfDay? selectedTime2;

  @override
  void dispose() {
    _editingController2.dispose();
    _subtitleController2.dispose();
    super.dispose();
  }

  void _submit2() {
    if (newTask2.trim().isEmpty) return;
    Provider.of<TodoProvider2>(context, listen: false).addTask2(
      newTask2,
      subtitle2: newSubtitle2,
      date2: selectedDate2,
      time2: selectedTime2,
    );
    Navigator.pop(context);
    _editingController2.clear();
    _subtitleController2.clear();
    selectedDate2 = null;
    selectedTime2 = null;
    newTask2 = '';
    newSubtitle2 = '';
  }

  @override
  void initState() {
    _editingController2.addListener(() {
      newTask2 = _editingController2.text;
    });
    _subtitleController2.addListener(() {
      newSubtitle2 = _subtitleController2.text;
    });
    super.initState();
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'New Task',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _editingController2,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: 'Task Title',
                        hintStyle: const TextStyle(
                          color: Color(0xFFBFDCC2),
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: const Icon(
                          Icons.title_outlined,
                          color: Color(0xFFA9D1B4),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE8F2EA),
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF7FAF6),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _subtitleController2,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: const TextStyle(
                          color: Color(0xFFBFDCC2),
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: const Icon(
                          Icons.description_outlined,
                          color: Color(0xFFA9D1B4),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE8F2EA),
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF7FAF6),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF6EA),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFA9D1B4),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            color: Color(0xFFA9D1B4),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            selectedDate2 == null
                                ? 'No date'
                                : '${selectedDate2!.toLocal()}'.split(' ')[0],
                          ),
                          const Spacer(),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (date != null) {
                                setState(() => selectedDate2 = date);
                              }
                            },
                            icon: const Icon(Icons.edit_outlined, size: 16),
                            label: const Text('Pick'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F8F4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFCDEBD6),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.schedule_outlined,
                            color: Color(0xFF8FC7A1),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            selectedTime2 == null
                                ? 'No time'
                                : selectedTime2!.format(context),
                          ),
                          const Spacer(),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                setState(() => selectedTime2 = time);
                              }
                            },
                            icon: const Icon(Icons.edit_outlined, size: 16),
                            label: const Text('Pick'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6BBF8C),
                  ),
                  onPressed: _submit2,
                  child: const Text(
                    'Create',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Tasks',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 70,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE8F2EA), Color(0xFFD4E8D8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Consumer<TodoProvider2>(
                builder: (context, prov, _) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF7EF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFA9D1B4),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    '${prov.allTasks2.length} tasks',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3E6B4F),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Consumer<TodoProvider2>(
            builder: (context, prov, _) {
              if (prov.allTasks2.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          color: Color(0xFFEAF6EA),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.list_alt,
                          size: 64,
                          color: Color(0xFF6BBF8C),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'No tasks yet',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6B5B95),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '🎉 Create your first task to get started',
                        style: TextStyle(
                          color: Color(0xFF8DAE97),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const TodoAction2();
            },
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFA9D1B4), Color(0xFF79BF8C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF79BF8C).withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: _showAddDialog,
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: const Icon(Icons.add),
          label: const Text('Add'),
        ),
      ),
    );
  }
}
