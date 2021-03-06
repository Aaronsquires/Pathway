import 'package:flutter/material.dart';
import 'package:pathway/Models/Classes/jobs.dart';
import 'package:pathway/Models/Services/savedJobs_api.dart';
import 'package:pathway/Models/Services/settings_api.dart';
import 'package:pathway/Screens/dashboard/jobAdvert.dart';
import 'package:pathway/Utils/Widgets/jobCard.dart';
import 'package:pathway/Utils/values/values.dart';
import 'package:provider/provider.dart';

class SavedJobsList extends StatefulWidget {
  @override
  _SavedJobsListState createState() => _SavedJobsListState();
}

class _SavedJobsListState extends State<SavedJobsList> {
  @override
  Widget build(BuildContext context) {
    SettingsProvider settings = Provider.of<SettingsProvider>(context);
    FavouriteJobs favourites = Provider.of<FavouriteJobs>(context);
    var jobs = Provider.of<List<Jobs>>(context)
        .where((jobs) => favourites.savedJobs.contains(jobs.jobTitle))
        .toList();
    //var jobs = Provider.of<List<Jobs>>(context);

    return Scaffold(
        backgroundColor: (settings.colortheme == 'Dark')
            ? DarkColors.primaryColor
            : LightColors.primaryColor,

        //Appbar
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text("Saved Jobs",
                style: ThemeText.titleStyle.copyWith(
                  color: (settings.colortheme == 'Dark')
                      ? DarkColors.primaryTextColor
                      : LightColors.primaryTextColor,
                )),
          ),
          backgroundColor: (settings.colortheme == 'Dark')
              ? DarkColors.primaryColorDarker
              : LightColors.primaryColorLighter,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(40))),
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
        ));
  }
}
