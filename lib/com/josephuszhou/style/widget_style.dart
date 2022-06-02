import 'package:flutter/material.dart';

/// App 通用的样式集合，减少重复代码，统一管理样式

// 按钮文字样式
TextStyle btnTextStyle = const TextStyle(color: Colors.white, fontSize: 16);

// 输入框边框样式
InputBorder inputBorder =
    const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));

// 标题文字样式
TextStyle titleTextStyle = const TextStyle(
    color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold);
