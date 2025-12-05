import 'package:clothing_store/view/layout/layout_screen.dart';
import 'package:flutter/material.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LayoutScreen(),));
        },
            icon: Icon(Icons.arrow_back_rounded,color: Theme.of(context).secondaryHeaderColor,)),),
      body: Center(
        child: Text(
          'Thanks for using our app its a demo version',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      )
    );
  }
}
