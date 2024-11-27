import 'package:flutter/material.dart';
import 'package:store/src/constants/AppColors.dart';
import 'package:store/src/services/APIService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<List<dynamic>> data;


  @override
  void initState() {
    super.initState();
    data = APIService.fetchData();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SafeArea(
        top: true,
        bottom: true,
        child: FutureBuilder<List<dynamic>>(
          future: data,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator.adaptive();
            }
            else if (snapshot.hasError){
              return const Text('Error loading data', style: TextStyle(fontSize: 20, color: AppColors.black));
            }
            else if (snapshot.hasData){
              return const Center(
                child: Text('Data received', style: TextStyle(fontSize: 20, color: AppColors.black)),
              );
            }
            else{
              return const Center(
                child: Text('No data found', style: TextStyle(fontSize: 20, color: AppColors.black)),
              );
            }
          },
        )
      ),
    );
  }
}