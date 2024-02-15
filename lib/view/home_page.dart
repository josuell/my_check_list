import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:my_check_list/bloc/check_list_bloc.dart';
import 'package:my_check_list/model/check_list.dart';
import 'package:my_check_list/service/my_to_do_list_service.dart';

class HomePage extends StatefulWidget {
  final String titlePage;

  const HomePage(this.titlePage, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateFormat _formatter;
  String sortTypeInitial = 'alphabetic';
  SortType sortType = SortType.asc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titlePage),
      ),
      body: BlocConsumer<CheckListBloc, CheckListState>(
          listener: (context, state) {
        if (state is UpdateCheckSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          context.read<CheckListBloc>().add(ShowingTheCheckListEvent());
        }
        if (state is AddCheckSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          context.read<CheckListBloc>().add(ShowingTheCheckListEvent());
        }
        if (state is DeleteTaskSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          context.read<CheckListBloc>().add(ShowingTheCheckListEvent());
        }
        if (state is CheckError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
          context.read<CheckListBloc>().add(ShowingTheCheckListEvent());
        }
      }, builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ShowCheckListState) {
          List<CheckList> allCheckList = state.theCheckList;
          List<CheckList> sortedCheckList =
              (sortTypeInitial.compareTo('alphabetic') == 0)
                  ? MyToDoListService()
                      .sortTaskByDesignation(allCheckList, sortType)
                  : MyToDoListService()
                      .sortTaskByDate(allCheckList, sortType);
          return (sortedCheckList.isNotEmpty)
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(child: TextFormField()),
                            PopupMenuButton(
                              icon: const Icon(Icons.swap_vert),
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        if(sortTypeInitial=='alphabetic')...[if (sortType == SortType.asc)
                                          const Icon(Icons.arrow_upward_rounded)
                                        else
                                          const Icon(Icons.arrow_downward_rounded),],
                                        const Expanded(child: Text('Sort by designation')),
                                      ],
                                    ),
                                    onTap: () {
                                      sortTypeInitial = 'alphabetic';
                                      setState(() {
                                        if (sortType == SortType.asc) {
                                          sortType = SortType.desc;
                                        } else {
                                          sortType = SortType.asc;
                                        }
                                      });
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        const Expanded(child: Text('Sort by date')),
                                       if(sortTypeInitial!='alphabetic')...[ if (sortType == SortType.asc)
                                          const Icon(Icons.arrow_upward_rounded)
                                        else
                                          const Icon(Icons.arrow_downward_rounded),]
                                      ],
                                    ),
                                    onTap: () {
                                      sortTypeInitial = 'date';
                                      setState(() {
                                        if (sortType == SortType.asc) {
                                          sortType = SortType.desc;
                                        } else {
                                          sortType = SortType.asc;
                                        }
                                      });
                                    },
                                  ),
                                ];
                              },
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          itemCount: sortedCheckList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const BehindMotion(),
                                children: [
                                  SlidableAction(
                                      onPressed: (context) async {
                                        bool? valider = await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Delete'),
                                                content:
                                                    const SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Text(
                                                          'Are you sure to delete this task '),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, false);
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text('Ok'),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, true);
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                        if (valider != null && valider) {
                                          if (!mounted) {
                                            return;
                                          }
                                          this
                                              .context
                                              .read<CheckListBloc>()
                                              .add(DeleteOneTaskEvent(
                                                  sortedCheckList[index]));
                                        }
                                      },
                                      icon: Icons.delete_outline,
                                      foregroundColor: Colors.red,
                                      label: 'Delete')
                                ],
                              ),
                              child: GestureDetector(
                                onLongPress: () {
                                  CheckList task = sortedCheckList[index];
                                  TextEditingController designationController =
                                      TextEditingController(
                                          text: task.designation);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'Edit the name of the task'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Form(
                                                    child: TextFormField(
                                                  controller:
                                                      designationController,
                                                  decoration:
                                                      const InputDecoration(
                                                    icon: Icon(Icons.person),
                                                    hintText: 'Write the task',
                                                    labelText: 'Designation',
                                                  ),
                                                  validator: (String? value) {
                                                    return (value == null)
                                                        ? 'Don\'t miss it '
                                                        : null;
                                                  },
                                                  onChanged: (value) {
                                                    designationController.text =
                                                        value;
                                                  },
                                                ))
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context, false);
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Ok'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                if (designationController
                                                    .text.isNotEmpty) {
                                                  task.designation =
                                                      designationController
                                                          .text;
                                                  context
                                                      .read<CheckListBloc>()
                                                      .add(UpdateATodoEvent(
                                                          task));
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: CheckboxListTile(
                                  title:
                                      Text(sortedCheckList[index].designation),
                                  subtitle: Text((_formatter.format(
                                      sortedCheckList[index].dateCreation))),
                                  onChanged: (value) {
                                    sortedCheckList[index].completed = value!;
                                    context.read<CheckListBloc>().add(
                                        UpdateATodoEvent(
                                            sortedCheckList[index]));
                                  },
                                  value: sortedCheckList[index].completed,
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                )
              : const Center(
                  child: Text('You don\'t have any task'),
                );
        } else {
          return Container();
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController designationController = TextEditingController();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Add a new task'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Form(
                            child: TextFormField(
                          controller: designationController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Write the task',
                            labelText: 'Designation',
                          ),
                          validator: (String? value) {
                            return (value == null) ? 'Don\'t miss it ' : null;
                          },
                        ))
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    ),
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.pop(context);
                        if (designationController.text.isNotEmpty) {
                          context
                              .read<CheckListBloc>()
                              .add(AddATaskEvent(designationController.text));
                        }
                      },
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _formatter = DateFormat('dd MMM yyyy', 'fr_Fr');
    context.read<CheckListBloc>().add(ShowingTheCheckListEvent());
  }
}
