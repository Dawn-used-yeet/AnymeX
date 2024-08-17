// ignore_for_file: prefer_const_constructors, deprecated_member_use, non_constant_identifier_names, must_be_immutable, avoid_print
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:aurora/components/MangaExclusive/chapters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:text_scroll/text_scroll.dart';

class MangaDetailsPage extends StatefulWidget {
  final String id;
  const MangaDetailsPage({super.key, required this.id});

  @override
  State<MangaDetailsPage> createState() => _MangaDetailsPageState();
}

class _MangaDetailsPageState extends State<MangaDetailsPage> {
  dynamic mangaData;
  bool isLoading = true;
  dynamic charactersData;
  String? description;

  final String baseUrl =
      'https://anymey-proxy.vercel.app/cors?url=https://manga-ryan.vercel.app/api/manga/';

  @override
  void initState() {
    super.initState();
    FetchMangaData();
  }

  Future<void> FetchMangaData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + widget.id));
      if (response.statusCode == 200) {
        final tempData = jsonDecode(response.body);
        log(tempData['name']);
        setState(() {
          mangaData = tempData;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
          leading: IconButton(
            icon: Icon(IconlyBold.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body: Center(
          child: CupertinoActivityIndicator(
            radius: 40,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextScroll(
          mangaData['name'],
          mode: TextScrollMode.bouncing,
          velocity: Velocity(pixelsPerSecond: Offset(30, 0)),
          delayBefore: Duration(milliseconds: 500),
          pauseBetween: Duration(milliseconds: 1000),
          textAlign: TextAlign.center,
          selectable: true,
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(IconlyBold.arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Column(
                children: [
                  Poster(mangaInfo: mangaData),
                  const SizedBox(height: 30),
                  Info(context)
                ],
              ),
            ],
          ),
          FloatingBar(
            title: mangaData['name'],
            id: widget.id,
          ),
        ],
      ),
    );
  }

  Container Info(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 170),
                    child: TextScroll(
                      mangaData['name'] ?? '??',
                      mode: TextScrollMode.endless,
                      velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                      delayBefore: Duration(milliseconds: 500),
                      pauseBetween: Duration(milliseconds: 1000),
                      textAlign: TextAlign.center,
                      selectable: true,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 15,
                    width: 3,
                    color: Color(0xFF8192CF),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.star_rounded,
                    size: 14,
                    color: Colors.indigo.shade400,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '6.9',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: (mangaData['genres'] as List<dynamic>? ?? [])
                    .take(3)
                    .map<Widget>(
                      (genre) => Container(
                        margin: EdgeInsets.only(right: 8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.inverseSurface,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          genre as String,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodySmall?.color,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.fontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: EdgeInsets.all(7),
                  width: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                      color: Theme.of(context).colorScheme.tertiary),
                  child: Column(
                    children: [
                      Text(
                          mangaData['view'] == null
                              ? '?'
                              : (mangaData['view'].toString()),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text('Popularity')
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).colorScheme.primary,
                  height: 30,
                  width: 2,
                ),
                Container(
                  width: 130,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      color: Theme.of(context).colorScheme.tertiary),
                  child: Column(
                    children: [
                      Text(
                        mangaData['status'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text('Status')
                    ],
                  ),
                ),
              ])
            ],
          ),
          const SizedBox(height: 30),
          ChapterList(chaptersData: mangaData['chapterList'], id: widget.id),
          const SizedBox(height: 70)
        ],
      ),
    );
  }
}

class FloatingBar extends StatelessWidget {
  final String? title;
  final String? id;
  const FloatingBar({super.key, this.title, this.id});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              constraints: BoxConstraints(maxWidth: 130),
                              child: TextScroll(
                                title!,
                                mode: TextScrollMode.bouncing,
                                velocity:
                                    Velocity(pixelsPerSecond: Offset(20, 0)),
                                delayBefore: Duration(milliseconds: 500),
                                pauseBetween: Duration(milliseconds: 1000),
                                textAlign: TextAlign.center,
                                selectable: true,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            const Text(
                              'Chapter 1',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/manga/read',
                            arguments: {'id': '/$id/chapter-1', 'mangaId': id});
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Iconsax.book,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Read',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Poster extends StatelessWidget {
  dynamic mangaInfo;
  Poster({
    super.key,
    required this.mangaInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .inverseSurface
                      .withOpacity(0.10),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 7),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width - 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                mangaInfo['imageUrl'],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}