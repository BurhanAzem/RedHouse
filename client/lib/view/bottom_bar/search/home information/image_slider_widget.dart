import 'package:flutter/material.dart';

class ImageSliderWidget extends StatefulWidget {
  final List<String> propertyFiles;

  ImageSliderWidget({required this.propertyFiles});

  @override
  _ImageSliderWidgetState createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  PageController _controller = PageController();
  int slider = 1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 260,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {});
            },
            itemCount: widget.propertyFiles!.length,
            itemBuilder: (context, index) {
              slider = index + 1;
              return Image.asset(
                widget.propertyFiles![index],
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            width: 50,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text("$slider / ${widget.propertyFiles!.length}",
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 22,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  print("==============================================love");
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                      size: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.star_border,
                      color: Colors.black,
                      size: 23,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.share,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.comment,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}