import 'package:flutter/material.dart';
import 'package:news_app/modules/web_veiw_screen.dart';
import 'package:news_app/shared/components/constans.dart';

Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    url = article['url'];
    navigateTo(context, WebViewScreen());
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120.0,

          height: 120.0,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10.0),

              image: DecorationImage(

                image: NetworkImage(article['urlToImage']??'https://images.pexels.com/photos/13081133/pexels-photo-13081133.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),

                fit: BoxFit.cover,

              )

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Container(

            height: 120.0,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(

                  article['title'],

                  maxLines: 3,

                  overflow:TextOverflow.ellipsis ,

                  style: Theme.of(context).textTheme.bodyMedium),

                Text(

                  article['publishedAt'],

                  style: TextStyle(

                    fontSize: 14.0,

                    color: Colors.grey[600],

                  ),),

              ],

            ),

          ),

        )

      ],

    ),

  ),
);


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  required String text,
  required IconData prefix,
  required BuildContext context,
  IconData? suffix,
  bool isPassword = false,
  Function? function ,
  Function? onTap,
  Function? onChange,
  bool isClickable = false,
}) => TextFormField(
  controller: controller,
  style: Theme.of(context).textTheme.bodyMedium,
  keyboardType: type,
  obscureText: isPassword ,
  validator:(s)
  {
    validate(s);
  },

  onChanged: (s){
    onChange!(s);
  },
  readOnly: isClickable,
  onTap:()
  {onTap!();},
  decoration: InputDecoration(
    labelText: text,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).focusColor,
        ),
    ),
    labelStyle: Theme.of(context).textTheme.bodyMedium,
    prefixIcon: Icon(
      prefix,
      color: Theme.of(context).focusColor,
    ),
    suffixIcon: suffix != null ? IconButton(
      icon: Icon(suffix),
      onPressed:()
      {
        function!();
      } ,
    ) :null,
    border: const OutlineInputBorder(),
  ),
);

void navigateTo(context,widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget ,
  ),
);
