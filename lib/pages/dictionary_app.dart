import 'package:dictionary_app/hive_repository.dart';
import 'package:flutter/material.dart';

class DictionaryApp extends StatefulWidget {
  const DictionaryApp({Key? key}) : super(key: key);

  @override
  State<DictionaryApp> createState() => _DictionaryAppState();
}

class _DictionaryAppState extends State<DictionaryApp> {
  TextEditingController wordEngController = TextEditingController();
  TextEditingController wordUzController = TextEditingController();
  TextEditingController Engtxt = TextEditingController();
  TextEditingController Uztxt = TextEditingController();
  HiveRepository hiveRepository = HiveRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> wordEng = hiveRepository.getWordEng();
    List<String> wordUz = hiveRepository.getWordUz();

    List<String> englishWord = [];
    List<String> uzbekWord = [];

    Dialog addWordsDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width / 5 * 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: wordEngController,
                decoration: InputDecoration(
                  hintText: 'English word',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: wordUzController,
                decoration: InputDecoration(
                  hintText: 'Uzbek word',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  if (wordEngController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('WordEng file Empty'),
                    ));
                    return;
                  }

                  if (wordUzController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('WordUz file Empty'),
                    ));
                    return;
                  }

                  (englishWord..addAll(hiveRepository.getWordEng()))
                      .add(wordEngController.text);
                  (uzbekWord..addAll(hiveRepository.getWordUz()))
                      .add(wordUzController.text);

                  hiveRepository.saveWordEng(englishWord);
                  hiveRepository.saveWordUz(uzbekWord);

                  Navigator.pop(context);
                },
                child: Text(
                  'Add!',
                  style: TextStyle(color: Colors.purple, fontSize: 18.0),
                ))
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        titleSpacing: 0,
        centerTitle: true,
        title: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 45,
                  child: Center(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.black38,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.change_circle_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Text(
                          wordEng[index],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Text(
                          wordUz[index],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          Engtxt.text = wordEng[index];
                          Uztxt.text = wordUz[index];
                          await showDialog(
                              context: (context),
                              builder: (builder) {
                                return Dialog(
                                  child: Container(
                                    height: 300,
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextField(
                                          controller: Engtxt,
                                        ),
                                        TextField(
                                          controller: Uztxt,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            hiveRepository
                                                .getWordUz()
                                                .remove(index);
                                            hiveRepository
                                                .getWordEng()
                                                .remove(index);

                                            setState(() {
                                              hiveRepository
                                                  .getWordUz()
                                                  .removeAt(index);
                                              hiveRepository
                                                  .getWordEng()
                                                  .removeAt(index);

                                              wordEngController = Engtxt;
                                              wordUzController = Uztxt;

                                              (englishWord
                                                    ..addAll(hiveRepository
                                                        .getWordEng()))
                                                  .add(wordEngController.text);
                                              (uzbekWord
                                                    ..addAll(hiveRepository
                                                        .getWordUz()))
                                                  .add(wordUzController.text);

                                              hiveRepository
                                                  .saveWordEng(englishWord);
                                              hiveRepository
                                                  .saveWordUz(uzbekWord);
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Add',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                          setState(() {});
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async{
                          await(hiveRepository.getWordEng().removeAt(index),
                              hiveRepository.getWordUz().removeAt(index),);
                          setState(() {

                          });
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
            ;
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: wordEng.length),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent,
        onPressed: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) => addWordsDialog);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
