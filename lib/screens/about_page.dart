import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  double scaffoldOpacity = 1;
  double x = 0, y = 0, z = 0;
  double width = 60;
  double hiddenAvatarSize = 1;

  final kAnimationDuration = Duration(milliseconds: 800);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
            'https://unsplash.com/photos/XO25cX2_0iE/download?force=true&w=640'),
        AnimatedOpacity(
          duration: kAnimationDuration,
          opacity: scaffoldOpacity,
          curve: Curves.decelerate,
          onEnd: () {
            setState(() {
              scaffoldOpacity = 1.0;
            });
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: const Text('About'),
            ),
            body: SafeArea(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
//                      fit: FlexFit.tight,
                      child: AnimatedContainer(
                        alignment: FractionalOffset.center,
                        duration: kAnimationDuration,
                        curve: Curves.decelerate,
                        transform: Matrix4(
                            1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
                          ..rotateX(x)
                          ..rotateY(y)
                          ..rotateZ(z),
                        onEnd: () {
                          setState(() {
                            x = 0;
                            y = 0;
                            z = 0;

                            print('animation end');
                          });
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/me_kiam.jpg'),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Hi, I\'m Mike',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Text(
                      'I make apps for free!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 20,
                      width: 150,
                      child: Divider(
                        height: 5,
                        color: Colors.white,
                      ),
                    ),
                    Card(
                      elevation: 8,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
//                    leading: Icon(
//                      Icons.insert_emoticon,
//                      size: 20,
//                      color: Theme.of(context).primaryColor,
//                    ),
                          title: Text(
                            'I’m  a coder/app developer, but i’m also a homeschooler and involved parenting advocate. \nIf you (or your kids) have an app suggestion that I think will be simple enough and/or I think my kids will also benefit, then I’ll make it for free.',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 8,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      //color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.mail,
                            size: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text('suggestions@mikealbano.org',
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                      ),
                    ),
                    Wrap(
                      children: [
                        ColoredButton(
                          color: Colors.red,
                          icon: Icons.email,
                          onTap: () {
                            setState(() {
                              scaffoldOpacity = 0;
                            });
                          },
                        ),
                        ColoredButton(
                          color: Colors.yellow,
                          icon: Icons.done_all,
                          onTap: () {
                            setState(() {
                              hiddenAvatarSize = 400;
                              z = pi / 2;
                              //scaffoldOpacity = 0.40;
                            });
                          },
                        ),
                        ColoredButton(
                          color: Colors.green,
                          icon: Icons.call,
                          onTap: () {
                            setState(() {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 200,
                                      color: Colors.amber,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Text('I am xxx days old'),
                                            RaisedButton(
                                              child: const Text('Wow'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            });
                          },
                        ),
                        ColoredButton(
                          color: Colors.purple,
                          icon: Icons.folder_open,
                          onTap: () {
                            setState(() {
                              x = pi / 2;
//                              y = pi / 2;
                              //z = -1;
                            });
                          },
                        ),
                        ColoredButton(
                          color: Colors.pinkAccent,
                          icon: Icons.fitness_center,
                          onTap: () {
                            setState(() {
//                              x = -pi / 2;
                              y = pi / 2;
//                              z = pi / 2;
                            });
                          },
                        ),
                        ColoredButton(
                          color: Colors.teal,
                          icon: Icons.adb,
                          onTap: () {
                            setState(() {
//                              x = -pi / 2;
//                              y = pi / 2;
                              z = pi / 2;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          bottom: 1,
          left: 1,
          width: hiddenAvatarSize,
          height: hiddenAvatarSize,
          duration: kAnimationDuration,
          onEnd: () {
            setState(() {
              hiddenAvatarSize = 1;
            });
          },
          child: AnimatedContainer(
            padding: EdgeInsets.all(10),
//              color: Colors.pink,
            duration: Duration(seconds: 1),
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/me_kiam.jpg'),
            ),
          ),
        ),
      ],
    );
  }
}

class MikeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mike Albano')),
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'face',
              child: CircleAvatar(
                radius: 80.0,
                backgroundImage: NetworkImage(
                  // 'https://unsplash.com/photos/XO25cX2_0iE/download?force=true&w=640',
                  'http://mikealbano.org/wp-content/uploads/2020/06/me_kiam-2.jpg',
                ),
              ),
            ),
            // MikeTile(),
            Card(
              margin: EdgeInsets.all(15),
              color: Colors.blue.shade300,
              child: ListTile(
                leading: Icon(Icons.ac_unit, size: 30),
                title: Hero(
                  tag: 'name',
                  child: Text(
                    'Mike Albano',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              color: Colors.blue.shade300,
              child: ListTile(
                leading: Icon(Icons.email, size: 30),
                title: Text(
                  'mike@email.com',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColoredButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Function onTap;
  final int size;

  ColoredButton({this.color, this.icon, this.onTap, this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Icon(icon, size: 30),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        height: size ?? 40,
        width: size ?? 40,
      ),
      onTap: onTap,
    );
  }
}

class MikeTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: Hero(
          tag: 'face',
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
              //    'https://unsplash.com/photos/XO25cX2_0iE/download?force=true&w=640',
              'http://mikealbano.org/wp-content/uploads/2020/06/me_kiam-2.jpg',
            ),
          ),
        ),
        title: Hero(
          tag: 'name',
          child: Text('Mike Albano'),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => MikeCard(),
            ),
          );
        });
  }
}
