import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/news_channels_headlines_model.dart';
import '../viewModel/news_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

enum FilterList {bbcNews , aryNews , usaToday , reuters , cnn , alJazeera}
class Home extends StatefulWidget {
    Home ({Key? key} ) : super (key : key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');

  String name = 'cnn';

  FilterList? selectedMenu;

  @override
  Widget build(BuildContext context){
    final height = MediaQuery.sizeOf(context).height *  1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Headlines', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),),
        actions: [
          PopupMenuButton<FilterList>(
              initialValue: selectedMenu,
              onSelected: (FilterList item){
                if(FilterList.reuters.name == item.name){
                  name = 'reuters';
                }
                if(FilterList.cnn.name == item.name){
                  name = 'cnn';
                }
                if(FilterList.usaToday.name == item.name){
                  name = 'usa-today';
                }
                // newsViewModel.fetchNewsChannelHeadlinesApi();
                setState(() {
                  selectedMenu = item;
                });

              },
              itemBuilder: (context) => <PopupMenuEntry<FilterList>> [
                const PopupMenuItem(
                  value: FilterList.bbcNews,
                    child: Text('BBC News')
                ),
                const PopupMenuItem(
                    value: FilterList.cnn,
                    child: Text('CNN')
                ),
                const PopupMenuItem(
                    value: FilterList.aryNews,
                    child: Text('ARY News')
                ),
                const PopupMenuItem(
                    value: FilterList.alJazeera,
                    child: Text('Aljazeera')
                ),
                const PopupMenuItem(
                    value: FilterList.reuters,
                    child: Text('Reuters')
                ),
                const PopupMenuItem(
                    value: FilterList.usaToday,
                    child: Text('Independent')
                ),

              ]
          )
        ],

      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width:  width,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelHeadlinesApi(),
              builder: (BuildContext context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blueAccent,
                    ),
                  );
                } else{
                  return ListView.builder(
                      itemCount: snapshot.data?.articles?.length,
                      scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                        DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * 0.6,
                                  width:  width * 0.9,
                                  padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(child: const SpinKitFadingCircle(color: Colors.blueAccent,size: 50,),),
                                      errorWidget: (context, url, error)=> const Icon((Icons.error_outline)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Container(
                                    height: height * 0.22,
                                    width: width * 0.7,
                                    alignment: Alignment.bottomCenter,
                                    padding: EdgeInsets.symmetric(horizontal: height * 0.01,vertical: width *0.01),
                                    child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(snapshot.data!.articles![index].title.toString(),
                                        style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshot.data!.articles![index].source!.name.toString(),style: GoogleFonts.poppins(fontSize: 12),),
                                            Text(format.format(dateTime),style: GoogleFonts.poppins(fontSize: 12),)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  ),
                                )
                              ],
                            )) ;
                    }

                  );

                }

            }
            ),
          )
        ],
      ),
    );
  }
}


