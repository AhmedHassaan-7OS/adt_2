import 'package:adt2/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



    final String useremail = FirebaseAuth.instance.currentUser!.email!;

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back)),
                IconButton(onPressed: () {}, icon: Icon(Icons.settings))
              ],
            ),
            Container(
              width: 139,
              height: 206,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("Images/Ellipse 37.png"),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(icon:Icon(Icons.edit)  ,
                         onPressed: () {
                           
                         }, 
                          iconSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'User',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Job disc',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 32,),
            Text(
            'Your Email',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8), 
          
          Container(
            width: 300, 
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1), 
              borderRadius: BorderRadius.circular(12), 
              border: Border.all(color: Colors.grey, width: 1), 
            ),
            child: Row(
              children: [
               
                Icon(
                  Icons.email_outlined,
                  color: Colors.grey[500],
                  size: 24,
                ),
                SizedBox(width: 12), 
                
                Text(
                 useremail,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
           SizedBox(height: 16,),
            Text(

            'Your Phone',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
 Container(
            width: 300, 
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1), 
              borderRadius: BorderRadius.circular(12), 
              border: Border.all(color: Colors.grey, width: 1), 
            ),
            child: Row(
              children: [
               
                Icon(
                  Icons.phone,
                  color: Colors.grey[500],
                  size: 24,
                ),
                SizedBox(width: 12), 
                
                Text(
                 "+123456789",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
           SizedBox(height: 16,),
            Text(

            'Your web site',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
 Container(
            width: 300, 
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1), 
              borderRadius: BorderRadius.circular(12), 
              border: Border.all(color: Colors.grey, width: 1), 
            ),
            child: Row(
              children: [
               
                Icon(
                  Icons.web,
                  color: Colors.grey[500],
                  size: 24,
                ),
                SizedBox(width: 12), 
                
                Text(
                 "www.example.com",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
                     SizedBox(height: 16,),
            Text(

            'Your password',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
 Container(
            width: 300, 
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1), 
              borderRadius: BorderRadius.circular(12), 
              border: Border.all(color: Colors.grey, width: 1), 
            ),
            child: Row(
              children: [
               
                Icon(
                  Icons.password,
                  color: Colors.grey[500],
                  size: 24,
                ),
                SizedBox(width: 12), 
                
                Text(
                 "000xxxxxxx",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 42,),
         ElevatedButton(onPressed: ()  async {
        await signOut();
        Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
            }, 
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.orange, 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), 
      side: BorderSide(color: Colors.orange, width: 2),
            ),
            minimumSize: Size(200, 50), 
    elevation: 0,
         ), child: Text("Logout!!"),


        )],
        ),
      ),
      
    );
  }
}
