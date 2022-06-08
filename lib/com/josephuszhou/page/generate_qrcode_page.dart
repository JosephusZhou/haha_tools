import 'package:buffer_image/buffer_image.dart';
import 'package:flutter/material.dart';

import '../base/base_state.dart';
import '../util/qrcode_util.dart';
import '../widget/common_widget.dart';
import '../style/widget_style.dart' as style;

class GenerateQrCodePage extends StatefulWidget {
  const GenerateQrCodePage({Key? key}) : super(key: key);

  @override
  State<GenerateQrCodePage> createState() => _GenerateQrCodePageState();
}

class _GenerateQrCodePageState extends BaseState<GenerateQrCodePage> {
  final TextEditingController _controller = TextEditingController();

  BufferImage? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () => {Navigator.pop(context)},
            child: backWidget(context),
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
                        decoration: InputDecoration(
                            hintText: s.plzInputContent,
                            border: style.inputBorder
                        ),
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
                            child: Text(
                              s.generateQrCode,
                              style: style.btnTextStyle,
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
