
import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/ui/home_screen/events/events_card.dart';
import 'package:evently_app/ui/register/app_form/app_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../database/model/EventsDao.dart';
import '../../../../database/model/category.dart';
import '../../../../providers/app_auth_provider.dart';

class FavouriteTab extends StatefulWidget {
  FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  int selectedCategoryIndex = 0;
  List<Category> allCategories = Category.getCategories(includeAll: true);
  @override
  Widget build(BuildContext context) {
    AppAuthProvider provider = Provider.of<AppAuthProvider>(context,listen: false);
    return SafeArea(
      child: Column(
        // spacing: 16,
        children: [
          SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              decoration: BoxDecoration(
                  color:Colors.transparent ,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  )
              ),
              child: TextField(

                cursorColor: AppColor.bluePrimaryColor,
                onChanged: (textFormUser) {
                  // searchByUserInputSura(textFormUser);
                },


                style: const TextStyle(color: AppColor.bluePrimaryColor),
                decoration: InputDecoration(

                  hoverColor: AppColor.bluePrimaryColor,
                  filled: true,
                  fillColor: const Color(0xB3202020),
                  focusedBorder: builtTextFormFieldBorder(),
                  disabledBorder: builtTextFormFieldBorder(),
                  enabledBorder: builtTextFormFieldBorder(),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  hintText: 'Search for Event',
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: const Color(0xFFD9D9D9)),
                ),
              ),

            ),
          ),
          Expanded(
            child: FutureBuilder(future:
            EventsDao.getFavoriteEvents(allCategories[selectedCategoryIndex].id// filter by category
                , provider.getUser()?.favorites ?? []
            ),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  // loading
                  return Center(child: CircularProgressIndicator());
                }else if(snapshot.hasError){
                  return Center(child: Text("Something went Wrong"),);
                }
                var events = snapshot.data?.toList();
                if(events==null ||events.isEmpty == true){
                  return Center(child: Text("No Events Found",
                    style: TextStyle(
                        color: Colors.black
                    ),),);
                }
                return  Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView.separated(
                      itemCount: events?.length ?? 0,
                      separatorBuilder: (context, index) => SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        var event  = events![index];
                        var isFavorite = provider.isFavorite(event);
                        event.isFavorite = isFavorite;
                        return EventsCard(
                          event: events[index],
                        );
                      }
                  ),
                );

              },),
            // child: ListView.separated(
            //   itemCount: 10,
            //   separatorBuilder: (context, index) => SizedBox(height: 16),
            //   itemBuilder: (context, index) => EventCard(),
            // ),
          ),
        ],
      ),
    );
  }
  OutlineInputBorder builtTextFormFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColor.bluePrimaryColor, width: 2),
    );
  }
}
