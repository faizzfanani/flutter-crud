import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud/Detail.dart';
import 'package:flutter_crud/main.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PageController pageController;
  List<String> images = [
    'https://images.pexels.com/photos/618613/pexels-photo-618613.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/7077/man-people-office-writing.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/7366/startup-photos.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/7097/people-coffee-tea-meeting.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/1661004/pexels-photo-1661004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
  ];
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    pageController = PageController(initialPage: 1, viewportFraction: 0.8);    
  }
  
  @override
  Widget build(BuildContext context) {    
    return Scaffold( 
      body: Container(
        child: ListView( 
          children: <Widget>[           
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.8,              
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff33313b),
                    Color(0xff4592af)
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
                )
              ),
              child: Container(
                child: PageView.builder(                                
                  controller: pageController,
                  itemCount: images.length,
                  itemBuilder: (context, position){
                    return imageSlider(position);
                  },
                ),
              ),              
            ),
            Container(
              margin: EdgeInsets.only(top: 20),               
                child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    children: List.generate(choices.length, (index) {
                        return Center(
                          child: ChoiceCard(choice: choices[index]),
                        );
                    },                    
                    )
                  ),              
            ) 
            ]
        ),        
      ),
      
    );
  }
  imageSlider(int index){
    return AnimatedBuilder(
      animation : pageController,
      builder : (context, widget){
        double value = 1;
        if(pageController.position.haveDimensions){
          value = pageController.page - index;
          value = (1 - (value.abs()*0.3)).clamp(0.0, 1.0);
        }
        return Align(
          alignment: Alignment.topCenter,          
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 200,
            width: Curves.easeInOut.transform(value) * 340,
            child: widget,
            
          ),
        );
      },
      child: Container(
        child: Image.network(images[index], fit: BoxFit.cover),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon, this.route});

  final String title;
  final IconData icon;
  final String route;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'My Profile', icon: Icons.person, route: '/profile'),
  const Choice(title: 'Employees', icon: Icons.group, route: '/dataemployee'),
  const Choice(title: 'To do list', icon: Icons.list, route: '/todolist'),
  const Choice(title: 'Salary', icon: Icons.attach_money, route: '/salary'),
  const Choice(title: 'Positioning', icon: Icons.arrow_upward, route: '/positioning'),
  const Choice(title: 'Statistics', icon: Icons.show_chart, route: '/statistic'),
  const Choice(title: 'About', icon: Icons.help_outline, route: '/about'),
  const Choice(title: 'Messages', icon: Icons.drafts, route: '/message'),
  const Choice(title: 'Setting', icon: Icons.settings, route: '/setting'),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {    
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
        return new GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, choice.route);
          },
          child: Card(
          color: Colors.white,
          child: Center(child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(choice.icon, size:40.0, color: textStyle.color),
                Text(choice.title, style: TextStyle(fontSize: 12)),
          ]
        ),
      )
    )
        );
        
  }
}