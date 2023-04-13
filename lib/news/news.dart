import 'package:flutter/material.dart';
import 'package:kavach/news/models/article_model.dart';
import 'package:kavach/news/services/api_service.dart';
import 'package:kavach/utils/kavach_theme.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: KavachTheme.pureWhite,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Kavach",
          style: KavachTheme.titleText(
              size: width / 13,
              weight: FontWeight.w600,
              color: KavachTheme.lightPink),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "News",
                  style: KavachTheme.titleText(
                      size: width / 18,
                      weight: FontWeight.normal,
                      color: KavachTheme.nearlyGrey),
                ),
                Text("Be aware of the current affairs related to you.",
                    style: KavachTheme.subtitleText(
                        size: width / 28,
                        weight: FontWeight.normal,
                        color: KavachTheme.nearlyGrey.withOpacity(0.7)))
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: client.getArticle(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Article>> snapshot) {
                    List<Article>? articles = snapshot.data;
                    print(articles);
                    if (articles != null) {
                      return ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(articles[index].title!),
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }))
        ],
      ),
    );
  }
}
