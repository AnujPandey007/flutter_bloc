import 'package:flutter/material.dart';

final textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  hintText: "Employee name",
  contentPadding: const EdgeInsets.all(0),
  prefixIcon: const Icon(Icons.person_outline, color: Colors.blue,),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: const BorderSide(
      color: Colors.grey,
    )
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: const BorderSide(
      color: Colors.grey,
    )
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(
      color: Colors.grey.shade300,
    )
  ),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: Colors.red.shade300,
      )
  ),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: Colors.red.shade300,
      )
  ),
  hintStyle: const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  ),
);

final dropDownInputDecoration = InputDecoration(
  prefixIcon: const Icon(Icons.work_outline, color: Colors.blue,),
  hintText: 'Select role',
  contentPadding: const EdgeInsets.all(0),
  hintStyle: const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: Colors.grey.shade300,
      )
  ),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: Colors.grey.shade300,
      )
  ),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: Colors.grey.shade300,
      )
  ),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: Colors.red.shade300,
      )
  ),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: Colors.red.shade300,
      )
  ),
);