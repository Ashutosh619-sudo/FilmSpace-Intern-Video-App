import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class VideoModel extends Equatable{
  final String title;
  final String description;
  final String url;

  VideoModel({@required this.title, 
  @required this.description, 
  @required this.url});

  List<Object> get props => [title, description, url];

  factory VideoModel.fromDocumentSnapshot(DocumentSnapshot snapshot){
    return VideoModel(title: snapshot.data()["title"], description: snapshot.data()["description"], url: snapshot.data()["url"]);
  }

}