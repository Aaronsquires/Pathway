import 'package:flutter/material.dart';
import 'package:pathway/Models/Classes/jobs.dart';
import 'package:pathway/Models/Services/settings_api.dart';
import 'package:pathway/Screens/dashboard/jobAdvert.dart';
import 'package:pathway/Utils/Widgets/Loading.dart';
import 'package:pathway/Utils/Widgets/jobCard.dart';
import 'package:pathway/Utils/values/values.dart';
import 'package:provider/provider.dart';

class JobCategoriesList extends StatefulWidget {
  @override
  _JobCategoriesListState createState() => _JobCategoriesListState();
}

class _JobCategoriesListState extends State<JobCategoriesList> {
  @override
  Widget build(BuildContext context) {
    final String category = ModalRoute.of(context).settings.arguments;
    SettingsProvider settings = Provider.of<SettingsProvider>(context);
    final String searchResult = 'Computing';

    return Scaffold(
      backgroundColor: (settings.colortheme == 'Dark')
          ? DarkColors.primaryColor
          : LightColors.primaryColor,
      //Appbar
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Hero(
            tag: 'dash',
            child: Text(
              category,
              style: TextStyle(
                fontSize: 22,
                color: (settings.colortheme == 'Dark')
                    ? DarkColors.primaryTextColor
                    : LightColors.primaryTextColor,
              ),
            ),
          ),
        ),
        backgroundColor: (settings.colortheme == 'Dark')
            ? DarkColors.primaryColorDarker
            : LightColors.primaryColorLighter,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
              ),
              color: (settings.colortheme == 'Dark')
                  ? DarkColors.primaryTextColor
                  : LightColors.primaryTextColor,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),

      //Main body
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: _buildAllJobsSection(category, searchResult),
      ),
    );
  }

  Widget _buildAllJobsSection(category, searchResult) {
    var jobs = Provider.of<List<Jobs>>(context)
        .where((jobs) => category.contains(jobs.category))
        .toList();
    if (jobs != null) {
      return Container(
        child: ListView.separated(
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            Jobs job = jobs[index];
            return GestureDetector(
              onTap: () {
                var currentJob = job.jobTitle;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobAdvert(),
                    settings: RouteSettings(
                      arguments: currentJob,
                    ),
                  ),
                );
              },
              child: JobCard(
                logo: job.logo,
                title: job.jobTitle,
                date: job.endDate,
                grade: job.gradeRequired,
                pay: job.pay,
                location: job.location,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 20,
            );
          },
        ),
      );
    } else {
      return OnPageLoading();
    }
  }
}
