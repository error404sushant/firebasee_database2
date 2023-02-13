import 'package:firebase_data/home/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = HomeBloc(context);
    homeBloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),
      body: body(),
    );
  }

  //region body

//region list
  Widget body() {
    return StreamBuilder<HomeState>(
        stream: homeBloc.homeCtl.stream,
        initialData: HomeState.Loading,
        builder: (context, snapshot) {
          if (snapshot.data == HomeState.Loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == HomeState.Success) {
            return ListView.builder(
                itemCount: homeBloc.homeResponse.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        //Image
                        Image.network(
                          homeBloc.homeResponse.data![index].thumbImage!,
                          width: 100,
                        ),
                        //center info
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                homeBloc.homeResponse.data![index].name!,
                              ),
                              RatingBar.builder(
                                itemSize: 15,
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              Expanded(child: Text(homeBloc.homeResponse.data![index].name!,
                              overflow: TextOverflow.ellipsis,
                              ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(),
                        //Button
                        InkWell(
                          onTap: () {
                            homeBloc.launchAppUrl(url: Uri.parse(homeBloc.homeResponse.data![index].appLink!));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "Download",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          }
          return Container();
        });
  }
//endregion
}
