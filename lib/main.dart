  import 'dart:math';
  
  import 'package:flutter/material.dart';
  
  void main() {
    runApp(const MyApp());
  }
  
  class MyApp extends StatelessWidget {
    const MyApp({super.key});
  
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
          '/question': (context) => QuestionPage(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      );
    }
  }
  
  class MyHomePage extends StatefulWidget {
    const MyHomePage({super.key, required this.title});
  
    final String title;
  
    @override
    State<MyHomePage> createState() => _MyHomePageState();
  }
  
  class _MyHomePageState extends State<MyHomePage> {
    List<int> blueContainerIndex = [201,186,171,156,141,125,124,123,
    122,121,120,105,90,91,92,93,94,95,81,66,51,36,21,6,7,8,23,38,53,68,83,
    99,100,101,102,103,104,119,134,133,132,131,130,129,143,158,173,188,
    203,218,217,202,187,172,157,142,127];
    List<int> redContainerIndex = [91,92,93,94,95,81,66,51,36,21,6,7,8,23,38,53,68,83,
      99,100,101,102,103,104,119,134,133,132,131,130,129,143,158,173,188,
      203,218,217,216,201,186,171,156,141,125,124,123,
      122,121,120,105,106,107,108,109,110,111];
    List<int> greenContainerIndex = [23,38,53,68,83,
      99,100,101,102,103,104,119,134,133,132,131,130,129,143,158,173,188,
      203,218,217,216,201,186,171,156,141,125,124,123,
      122,121,120,105,90,91,92,93,94,95,81,66,51,36,21,6,7,22,37,52,67,82,97];
    List<int> yellowContainerIndex = [133,132,131,130,129,143,158,173,188,
      203,218,217,216,201,186,171,156,141,125,124,123,
      122,121,120,105,90,91,92,93,94,95,81,66,51,36,21,6,7,8,23,38,53,68,83,
      99,100,101,102,103,104,119,118,117,116,115,114,113];
    int currPlayer=0;
    List<String> playerColor =['BLUE','RED','GREEN','YELLOW'];
  
    List<int> safeZone = [36,23,102,133,188,201,122,91];
    List<int> currBlueIdx =[0,0,0,0];
    List<int> currRedIdx =[0,0,0,0];
    List<int> currGreenIdx =[0,0,0,0];
    List<int> currYellowIdx =[0,0,0,0];
  
    List<int> bpc =[];
    List<int> rpc =[];
    List<int> gpc =[];
    List<int> ypc =[];
  
    int newPosition=0;
    bool hasAnsweredQuestion = false;
    int selectedPawnIndex = -1;

    String imagePath = 'assets/images/diceJoker.png';

    _MyHomePageState() {
      bpc =[151,154,196,199];
      rpc =[16,19,61,64];
      gpc =[25,28,70,73];
      ypc =[160,163,205,208];
    }


    @override
    Widget build(BuildContext context) {
  
  
      void checkColl(int curr,int temp){
        if(curr==0) {
          if (rpc.contains(bpc[temp])) {
            int mock = rpc.indexOf(bpc[temp]);
            if(!safeZone.contains(rpc[mock])){
              rpc[mock] = 16;}
          }
          else if (gpc.contains(bpc[temp])) {
            int mock = gpc.indexOf(bpc[temp]);
            if(!safeZone.contains(gpc[mock])){
              gpc[mock] = 25;}
          }
          else if (ypc.contains(bpc[temp])) {
            int mock = ypc.indexOf(bpc[temp]);
            if(!safeZone.contains(ypc[mock])){
              ypc[mock] = 160;}
          }
        }
        else if(curr==1) {
          if (bpc.contains(rpc[temp])) {
            int mock = bpc.indexOf(rpc[temp]);
            if(!safeZone.contains(bpc[mock])){
              bpc[mock] = 151;}
          }
          else if (gpc.contains(rpc[temp])) {
            int mock = gpc.indexOf(rpc[temp]);
            if(!safeZone.contains(gpc[mock])){
              gpc[mock] = 25;}
          }
          else if (ypc.contains(rpc[temp])) {
            int mock = ypc.indexOf(rpc[temp]);
            if(!safeZone.contains(ypc[mock])){
            ypc[mock] = 160;}
          }
        }
        else if(curr==2) {
          if (bpc.contains(gpc[temp])) {
            int mock = bpc.indexOf(gpc[temp]);
            if(!safeZone.contains(bpc[mock])){
              bpc[mock] = 151;}
          }
          else if (rpc.contains(gpc[temp])) {
            int mock = rpc.indexOf(gpc[temp]);
            if(!safeZone.contains(rpc[mock])){
              rpc[mock] = 16;}
          }
          else if (ypc.contains(gpc[temp])) {
            int mock = ypc.indexOf(gpc[temp]);
            if(!safeZone.contains(ypc[mock])){
              ypc[mock] = 160;}
          }
        }
        else if(curr==3){
          if(bpc.contains(ypc[temp])){
            int mock=bpc.indexOf(ypc[temp]);
            if(!safeZone.contains(bpc[mock])){
              bpc[mock]=151;}
          }
          else if(rpc.contains(ypc[temp])){
            int mock=rpc.indexOf(ypc[temp]);
            if(!safeZone.contains(rpc[mock])){
              rpc[mock]=16;}
          }
          else if(gpc.contains(ypc[temp])){
            int mock=gpc.indexOf(ypc[temp]);
            if(!safeZone.contains(ypc[mock])){
              gpc[mock]=25;}
          }
        }
      }


      void diceChange(int diceRoll){
        setState(() {
          if(diceRoll==0) {
            imagePath= 'assets/images/diceJoker.png';
          }
          else if(diceRoll==1){
            imagePath= 'assets/images/diceOne.png';
          }
          else if(diceRoll==2){
            imagePath= 'assets/images/diceTwo.png';
          }
          else if(diceRoll==3){
            imagePath= 'assets/images/diceThree.png';
          }
          else if(diceRoll==4){
            imagePath= 'assets/images/diceFour.png';
          }
          else if(diceRoll==5){
            imagePath= 'assets/images/diceFive.png';
          }
          else if(diceRoll==6){
            imagePath= 'assets/images/diceSix.png';
          }
        });
      }

      void changeImagePosition(int newPosition, int selIdx) {
        setState(() {
          if(currPlayer==0){
            int temp = bpc.indexOf(selIdx);
            currBlueIdx[temp] += newPosition ;
            bpc[temp]=blueContainerIndex[currBlueIdx[temp]];
            checkColl(currPlayer,temp);
            currPlayer=1;
          }
          else if(currPlayer==1){
            int temp = rpc.indexOf(selIdx);
            currRedIdx[temp] += newPosition ;
            rpc[temp]=redContainerIndex[currRedIdx[temp]];
            checkColl(currPlayer,temp);
            currPlayer=2;
          }
          else if(currPlayer==2){
            int temp = gpc.indexOf(selIdx);
            currGreenIdx[temp] += newPosition ;
            gpc[temp]=greenContainerIndex[currGreenIdx[temp]];
            checkColl(currPlayer,temp);
            currPlayer=3;
          }
          else if(currPlayer==3){
            int temp = ypc.indexOf(selIdx);
            currYellowIdx[temp] += newPosition ;
            ypc[temp]=yellowContainerIndex[currYellowIdx[temp]];
            checkColl(currPlayer,temp);
            currPlayer=0;
          }
          hasAnsweredQuestion=false;
  
        });

      }

      void openPawn(int selectedIndex) {
        setState(() {
          if (selectedIndex == 151 || selectedIndex == 154 || selectedIndex == 196 || selectedIndex == 199) {
            if(newPosition==6 || newPosition ==1) {
              int temp = bpc.indexOf(selectedIndex);
              currBlueIdx[temp] = 0;
              bpc[temp] = 201;
              currPlayer = 1;
            }
            else{
              currPlayer = 1;
            }
          } else if (selectedIndex == 16 || selectedIndex == 19 || selectedIndex == 61 || selectedIndex == 64) {
            if(newPosition==6 || newPosition ==1) {
              int temp = rpc.indexOf(selectedIndex);
              currRedIdx[temp] = 0;
              rpc[temp] = 91;
              currPlayer = 2;
            }
            else{
              currPlayer = 2;
            }
          } else if (selectedIndex == 25 || selectedIndex == 28 || selectedIndex == 70 || selectedIndex == 73) {
            if(newPosition==6 || newPosition ==1) {
              int temp = gpc.indexOf(selectedIndex);
              currGreenIdx[temp] = 0;
              gpc[temp] = 23;
              currPlayer = 3;
            }
            else{
              currPlayer = 3;
            }
          } else if (selectedIndex == 160 || selectedIndex == 163 || selectedIndex == 205 || selectedIndex == 208) {
            if(newPosition==6 || newPosition ==1) {
              int temp = ypc.indexOf(selectedIndex);
              currYellowIdx[temp] = 0;
              ypc[temp] = 133;
              currPlayer = 0;
            }
            else{
              currPlayer = 0;
            }
          }
  
          hasAnsweredQuestion=false;
  
        });
      }


  
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Stack(
            children: [
              Image.asset('assets/images/bgSmp.jpg',
                width: double.infinity,
                height: double.infinity,
                 fit: BoxFit.cover,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: IgnorePointer(
                              ignoring: currPlayer!=1,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    final answer = await Navigator.pushNamed(context, '/question');

                                    if (answer != null) {
                                      // Assuming answer is the new position for the image
                                      newPosition = answer as int;
                                      if(newPosition!=0) {
                                        diceChange(newPosition);
                                        hasAnsweredQuestion = true;
                                      }
                                      else{
                                        if(currPlayer!=3){
                                          currPlayer++;
                                        }
                                        else{
                                          currPlayer=0;
                                        }
                                        diceChange(newPosition);
                                      }
                                    }
                                  },
                                  child: currPlayer==1?Image.asset(imagePath,):
                                Container(width:70,height: 66,),
                              ),
                            ),
                          ),
                          Expanded(
                            child: IgnorePointer(
                              ignoring: currPlayer!=2,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final answer = await Navigator.pushNamed(context, '/question');

                                  if (answer != null) {
                                    // Assuming answer is the new position for the image
                                    newPosition = answer as int;
                                    if(newPosition!=0) {
                                      diceChange(newPosition);
                                      hasAnsweredQuestion = true;
                                    }
                                    else{
                                      if(currPlayer!=3){
                                        currPlayer++;
                                      }
                                      else{
                                        currPlayer=0;
                                      }
                                      diceChange(newPosition);
                                    }
                                  }
                                },
                                child: currPlayer==2?Image.asset(imagePath,):
                                Container(width:70,height: 66,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/LudoBoard.jpg',
                            width: double.infinity,
                          ),
                          Container(
                            width: double.infinity,
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: 15 * 15, // 15x15 grid
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 15,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    if(hasAnsweredQuestion){
                                      setState(() {
                                        selectedPawnIndex=index;
                                        if(currPlayer==0 && bpc.contains(selectedPawnIndex)){
                                          if(selectedPawnIndex==151 || selectedPawnIndex==154 ||
                                          selectedPawnIndex==196 ||selectedPawnIndex==199 ){
                                              openPawn(selectedPawnIndex);
                                          }
                                          else {
                                            changeImagePosition(newPosition, selectedPawnIndex);
                                          }
                                        }
                                        else if(currPlayer==1 && rpc.contains(selectedPawnIndex)){
                                          if(selectedPawnIndex==16 || selectedPawnIndex==19 ||
                                          selectedPawnIndex==61 ||selectedPawnIndex==64 ){
                                            openPawn(selectedPawnIndex);
                                          }
                                          else {
                                            changeImagePosition(newPosition, selectedPawnIndex);
                                          }
                                        }
                                        else if(currPlayer==2 && gpc.contains(selectedPawnIndex)){


                                          if(selectedPawnIndex==25 || selectedPawnIndex==28 ||
                                            selectedPawnIndex==70 ||selectedPawnIndex==73 ){
                                             openPawn(selectedPawnIndex);
                                          }
                                          else {
                                            changeImagePosition(newPosition, selectedPawnIndex);
                                          }
                                        }
                                        else if(currPlayer==3 && ypc.contains(selectedPawnIndex)){
                                          if(selectedPawnIndex==160 || selectedPawnIndex==163 ||
                                          selectedPawnIndex==205 ||selectedPawnIndex==208 ){
                                            openPawn(selectedPawnIndex);
                                          }
                                          else {
                                            changeImagePosition(newPosition, selectedPawnIndex);
                                          }
                                        }

                                      });
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent, // Border color
                                        width: 1.0, // Border width
                                      ),
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        if (bpc.contains(index))
                                          Transform.translate(
                                            offset: Offset(3.0,-10.0),
                                            child: Transform.scale(
                                              scale: 1.5,
                                              child: Image.asset('assets/images/bluePawn.png',
                                              ),
                                            ),
                                          )
                                        else if (rpc.contains(index))
                                          Transform.translate(
                                            offset: Offset(3.0,-10.0),
                                            child: Transform.scale(
                                              scale: 1.5,
                                              child: Image.asset('assets/images/redPawn.png',
                                              ),
                                            ),
                                          )
                                        else if (gpc.contains(index))
                                            Transform.translate(
                                              offset: Offset(3.0,-10.0),
                                              child: Transform.scale(
                                                scale: 1.5,
                                                child: Image.asset('assets/images/greenPawn.png',
                                                    ),
                                              ),
                                            )
                                          else if (ypc.contains(index))
                                              Transform.translate(
                                                offset: Offset(3.0,-10.0),
                                                child: Transform.scale(
                                                  scale: 1.5,
                                                  child: Image.asset('assets/images/yellowPawn.png',
                                                  ),
                                                ),
                                              ),


                                        // Add your grid item content here
                                        // For example, other images or content.
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: IgnorePointer(
                              ignoring: currPlayer!=0,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final answer = await Navigator.pushNamed(context, '/question');

                                  if (answer != null) {
                                    // Assuming answer is the new position for the image
                                    newPosition = answer as int;
                                    if(newPosition!=0) {
                                      diceChange(newPosition);
                                      hasAnsweredQuestion = true;
                                    }
                                    else{
                                      if(currPlayer!=3){
                                        currPlayer++;
                                      }
                                      else{
                                        currPlayer=0;
                                      }
                                      diceChange(newPosition);
                                    }
                                  }
                                },
                                child: currPlayer==0?Image.asset(imagePath,):
                                Container(width:70,height: 66,),
                              ),
                            ),
                          ),
                          Expanded(
                            child: IgnorePointer(
                              ignoring: currPlayer!=3,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final answer = await Navigator.pushNamed(context, '/question');

                                  if (answer != null) {
                                    // Assuming answer is the new position for the image
                                    newPosition = answer as int;
                                    if(newPosition!=0) {
                                      diceChange(newPosition);
                                      hasAnsweredQuestion = true;
                                    }
                                    else{
                                      if(currPlayer!=3){
                                        currPlayer++;
                                      }
                                      else{
                                        currPlayer=0;
                                      }
                                      diceChange(newPosition);
                                    }
                                  }
                                },
                                child: currPlayer==3?Image.asset(imagePath,):
                                Container(width:70,height: 66,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
  
  
  class QuestionPage extends StatefulWidget {
    @override
    _QuestionPageState createState() => _QuestionPageState();
  }
  
  class _QuestionPageState extends State<QuestionPage>{
    List<String> ques=['8+2 = ','7-3 =','7 X 8 =','14/2 =','13*4 ='];
    List<String> corrAns=['10','4','56','7','52'];
    List<String> ans0=['10','3','63','8','59'];
    List<String> ans1=['9','4','64','10','39'];
    List<String> ans2=['11','5','56','6','42'];
    List<String> ans3=['15','9','49','7','55'];
    List<String> ans4=['16','21','35','12','49'];
    List<String> ans5=['6','20','60','16','52'];
    int quesIndex=0;
    int selectedIndex=0;
    int randomQuesIndex=0;
    String? val;
    int? answer;
  
    void getRandomQuestionIndex() {
      final random = Random();
      randomQuesIndex = random.nextInt(ques.length); // Store the random index
    }
  
    String getRandomQuestion() {
      return ques[randomQuesIndex]; // Use the stored random index
    }
  
    @override
    void initState() {
      super.initState();
      getRandomQuestionIndex(); // Generate a new random question index when the page is created
    }
  
  
    String getListValue(int index, int quesIndex) {
      switch (index) {
        case 0:
          return ans0[quesIndex];
        case 1:
          return ans1[quesIndex];
        case 2:
          return ans2[quesIndex];
        case 3:
          return ans3[quesIndex];
        case 4:
          return ans4[quesIndex];
        case 5:
          return ans5[quesIndex];
        default:
          return "error"; // Handle an invalid index as needed
      }
    }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Test Question'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getRandomQuestion(),
                  style: TextStyle(fontSize: 24,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  for(int i=0;i<6;i++)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(

                        onPressed: () {
                          setState(() {
                            selectedIndex = i;
                            val=getListValue(i,randomQuesIndex);
                          });
                        },
                        child: Text('Option ${i+1}:  ${getListValue(i,randomQuesIndex)}'),
                      ),
                    ),

                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Get the user's answer and return it to the HomePage.
                if (val == corrAns[randomQuesIndex]) {
                  answer = selectedIndex;
                } else {
                  answer = -1;
                }
                Navigator.pop(context, answer!+1);
              },
              child: Text('Submit Answer'),
            ),
          ],
        ),
      );
    }
  }
