import 'package:flutter/material.dart';
import '../widgets/search.dart';
import '../resources/api_provider.dart';
// import '../widgets/loading_container.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatelessWidget {
  final jsonData = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Picsearch'),
        actions: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: Search(),
                );
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: jsonData.fetchItemList(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          Map data = snapshot.data;
          return GridView.builder(
            itemCount: data['hits'].length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              final item = data['hits'][index];
              return GridTile(
                child: GestureDetector(
                  onTap: () async {
                    final url = item['pageURL'];
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Container(
                    child: Image.network(
                      '${item['largeImageURL']}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.search,
      //   ),
      //   onPressed: () {},
      // ),
    );
  }
}
