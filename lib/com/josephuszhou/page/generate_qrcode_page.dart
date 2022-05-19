import 'package:buffer_image/buffer_image.dart';
import 'package:flutter/material.dart';

import '../util/qrcode_util.dart';
import '../widget/common_widget.dart';

class WriteQrCodePage extends StatefulWidget {
  const WriteQrCodePage({Key? key}) : super(key: key);

  @override
  State<WriteQrCodePage> createState() => _WriteQrCodePageState();
}

class _WriteQrCodePageState extends State<WriteQrCodePage> {
  final TextEditingController _controller = TextEditingController();

  BufferImage? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () => {Navigator.pop(context)},
            child: backWidget(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: TextField(
                        controller: _controller,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                            hintText: "请输入内容",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 8),
                        child: SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: MaterialButton(
                            color: Colors.blue,
                            child: const Text(
                              "生成二维码",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {
                              createQrCode();
                            },
                          ),
                        )),
                    buildQrCode(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQrCode() {
    if (_image != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        child: Image(
          image: RgbaImage.fromBufferImage(_image!),
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 8),
      );
    }
  }

  Future<void> createQrCode() async {
    BufferImage image = await createQrcode(_controller.text);
    setState(() {
      _image = image;
    });
  }
}
