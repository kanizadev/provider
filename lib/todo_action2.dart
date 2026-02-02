import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/todo_provider2.dart';

class TodoAction2 extends StatelessWidget {
  const TodoAction2({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider2>(
      builder: (context, task2, _) {
        return ListView.separated(
          itemCount: task2.allTasks2.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final item = task2.allTasks2[index];
            return Dismissible(
              key: ValueKey(item.toDoTitle2 + index.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                color: const Color(0xFFF4A8A8),
                child: const Icon(Icons.delete_outline, color: Colors.white),
              ),
              confirmDismiss: (_) async {
                final shouldDelete =
                    await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Delete task?'),
                        content: Text('Delete "${item.toDoTitle2}"?'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(false),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF4A8A8),
                            ),
                            onPressed: () => Navigator.of(ctx).pop(true),
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ) ??
                    false;
                return shouldDelete;
              },
              onDismissed: (_) => task2.deleteTask2(item),
              child: Card(
                elevation: 5,
                shadowColor: const Color(0xFFA9D1B4).withValues(alpha: 0.22),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: item.completed2 ? const Color(0xFFFAFAFA) : Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: item.completed2
                          ? const Color(0xFFD9D9D9)
                          : const Color(0xFFE8F2EA),
                      width: 1.4,
                    ),
                    boxShadow: [
                      if (!item.completed2)
                        BoxShadow(
                          color: const Color(
                            0xFFA9D1B4,
                          ).withValues(alpha: 0.04),
                          blurRadius: 6,
                          spreadRadius: 0,
                        ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: item.completed2
                            ? const Color(0xFFD4EDDA)
                            : const Color(0xFFE8F2EA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Checkbox(
                        value: item.completed2,
                        activeColor: const Color(0xFF6BBF8C),
                        onChanged: (_) => task2.toggleTask2(item),
                      ),
                    ),
                    title: Text(
                      item.toDoTitle2,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        decoration: item.completed2
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: item.completed2
                            ? Colors.grey.shade500
                            : Colors.black87,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item.subtitle2.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              item.subtitle2,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                decoration: item.completed2
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        if (item.date2 != null || item.time2 != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.schedule_outlined,
                                  size: 14,
                                  color: Color(0xFF6BBF8C),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${item.date2 != null ? '${item.date2!.toLocal()}'.split(' ')[0] : ''} ${item.time2 != null ? item.time2!.format(context) : ''}'
                                      .trim(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF3E6B4F),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        final shouldDelete =
                            await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Delete task?'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                content: Text(
                                  'Delete "${item.toDoTitle2}"?',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(ctx).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFF4A8A8),
                                    ),
                                    onPressed: () =>
                                        Navigator.of(ctx).pop(true),
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ) ??
                            false;
                        if (shouldDelete) task2.deleteTask2(item);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Color(0xFFF4A8A8),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
