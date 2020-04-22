//imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pathway/Models/Classes/User.dart';
import 'package:pathway/Models/Classes/categoryList.dart';
import 'package:pathway/Models/Classes/jobs.dart';
import 'package:pathway/Models/Classes/userData.dart';
import 'package:pathway/Models/Services/Database_api.dart';
import 'package:pathway/Models/Services/filters_api.dart';
import 'package:pathway/Models/Services/settings_api.dart';
import 'package:pathway/Screens/Accounts/editAccount.dart';
import 'package:pathway/Screens/dashboard/jobAdvert.dart';
import 'package:pathway/Screens/dashboard/jobCategories.dart';
import 'package:pathway/Screens/dashboard/search.dart';
import 'package:pathway/Utils/Widgets/Animations.dart';
import 'package:pathway/Utils/Widgets/Loading.dart';
import 'package:pathway/Utils/Widgets/SmallCategoryCard.dart';
import 'package:pathway/Utils/Widgets/bottomButtonBar.dart';
import 'package:pathway/Utils/Widgets/jobCard.dart';
import 'package:pathway/Utils/Widgets/sideMenu.dart';
import 'package:pathway/Utils/values/appData.dart';
import 'package:pathway/Utils/values/values.dart';
import 'package:provider/provider.dart';

const String testDevice = 'MobileId';

//dashboard
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {


  //tabbar controller
  TabController tabController;
  bool loading = false;

  //Search Button onPressed -> navigates to search page
  void onSearchButtonPressed(BuildContext context) =>
      Navigator.push(context, FadeRouteBuilder(page: SearchJobsList()));

  @override
  void initState() {
    //set tab controller length
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  //Horizontal ListView for categories
  Widget _buildCategoryListview() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      //Listview
      child: ListView.separated(
        //Sets listview to display horizontally
        scrollDirection: Axis.horizontal,
        itemCount: jobTypes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              //Material push gets the index of the gridtile and takes the title to the next page
              print("Tile " + jobTypes[index].title);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => JobCategoriesList(),
                  settings: RouteSettings(
                    arguments: jobTypes[index].title,
                  ),
                ),
              );
            },
            child: SmallCategoryCard(
              imageUrl: jobTypes[index].imageUrl,
              title: jobTypes[index].title,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 7,
          );
        },
      ),
    );
  }

  //Builds the Tab Selector
  Widget _buildTabBar() {
    //import settings
    SettingsProvider settings = Provider.of<SettingsProvider>(context);

    return Container(
      alignment: Alignment.centerLeft,
      child: TabBar(
          controller: tabController,
          //sets the underline on currently selected
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 1,
                color: DarkColors.secondaryColor,
              ),
              insets: EdgeInsets.only(left: 8, right: 11, bottom: 0)),
          isScrollable: true,
          labelPadding: EdgeInsets.only(left: 0, right: 10),
          labelStyle: TextStyle(
            fontSize: 20,
            color: (settings.colortheme == 'Dark')
                ? DarkColors.primaryTextColor
                : LightColors.primaryTextColor,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 20,
            color: (settings.colortheme == 'Dark')
                ? DarkColors.primaryTextColor
                : LightColors.primaryTextColor,
          ),
          tabs: <Widget>[
            Container(child: Text("All")),
            Container(
              child: Text("Filtered"),
            ),
            Container(
              child: Text("Recommended"),
            ),
          ]),
    );
  }

  //Builds the view to store the jobs
  Widget _buildTabBarView(userData) {
    //Expanded widget makes the view fit the available space
    return Expanded(
      child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 20.7,
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: TabBarView(
            //Stop the tabbar from being scrolled left to right
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: <Widget>[
              _buildAllJobsSection(),
              _buildFilterJobsSection(),
              _buildRecommendedJobsSection(userData)
            ],
          )),
    );
  }

  //All Jobs Section
  Widget _buildAllJobsSection() {
    var jobs = Provider.of<List<Jobs>>(context);
    if (jobs != null) {
      return ListView.separated(
        itemCount: jobs.length + 1,
        itemBuilder: (context, index) {
          //Adds the Google AdMob at start of the list
          if(index == 0){
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: Container(
                decoration: BoxDecoration(
                  color: DarkColors.secondaryColor,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                  child: Text(
                    'PlaceHolder Ad'
                  ),
                ),
              ),
            );
          }
          index -= 1;
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
      );
    } else {
      return OnPageLoading();
    }
  }

  Widget _buildFilterJobsSection() {
    FiltersProvider filters = Provider.of<FiltersProvider>(context);
    var jobs = Provider.of<List<Jobs>>(context)
        //1. show list of jobs according to Categories selected
        .where((jobs) => (filters.category == 'All')
            //2. show all of the jobs in the categories provided
            ? categories.contains(jobs.category)
            //3. or show the jobs that are selected in filters
            : filters.category.contains(jobs.category))
        //2. show list of jobs according to the grade selected
        .where((jobs) => (filters.grade == 'All')
            ? grades.contains(jobs.gradeRequired)
            : filters.grade.contains(jobs.gradeRequired))
        //3. show list of jobs according to the location selected
        .where((jobs) => (filters.location == 'All')
            ? counties.contains(jobs.location)
            : filters.location.contains(jobs.location))
        .toList();

    List<String> chips = [
      filters.grade, filters.category, filters.location
    ];

    if (jobs != null) {
      return ListView.separated(
       itemCount: jobs.length + 1,
        itemBuilder: (context, index) {
          //Adds the Google AdMob at start of the list
          if(index == 0){
           return Wrap(
             spacing: 6,
             runSpacing: 6,
             children: List<Widget>.generate(chips.length, (int index) {
               return Chip(
                 label: Text(chips[index], style: TextStyle(
                   color: DarkColors.primaryTextColor
                 ),),
                 deleteIconColor: DarkColors.secondaryColor,     
                 onDeleted: () {
                   (chips[index] == filters.category) ?
                   filters.setCategory('All') : (chips[index] == filters.grade) ?
                   filters.setGrade('All') : filters.setLocation('All');
                 },
                 backgroundColor: DarkColors.primaryColorDark,
              );

             }
           ));
          }
          index -= 1;
          print(jobs[index].category);
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
      );
    } else {
      return OnPageLoading();
    }
  }

  Widget _buildRecommendedJobsSection(userData) {
    var recommended;
    (userData.disciplin == 'Computer Science')
        ? recommended = 'Computing'
        : (userData.disciplin == 'Teacher')
            ? recommended = 'Education'
            : recommended = '';
    var jobs = Provider.of<List<Jobs>>(context)
        .where((jobs) => recommended.contains(jobs.category))
        .toList();

    if (jobs != null) {
      return ListView.separated(
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
      );
    } else {
      return OnPageLoading();
    }
  }

  Widget _buildAccountInformation() {
    return Container(
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Container(
            padding: EdgeInsets.fromLTRB(10, 2, 0, 2),
            color: Colors.orangeAccent,
            child: Row(
              children: [
                //Text
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dont miss out on great opportunities!',
                        style: TextStyle(
                            color: DarkColors.primaryColorDarker,
                            fontWeight: FontWeight.w800),
                      ),
                      Text('Update your information')
                    ],
                  ),
                ),
                //Button
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountDetails()));
                  },
                  child: Text('Here'),
                  color: Colors.transparent,
                  elevation: 0,
                )
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SettingsProvider settings = Provider.of<SettingsProvider>(context);
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).usersdata,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          //1. gets the users full name.
          //2. splits the name at the space
          //3. Takes the first element - i.e. the first part of the name
          //4. converts to a singular string from an element in a list
          var splitFullName =
              userData.fullName.split(" ").elementAt(0).toString();

          //if loading is = true then show the loading otherwise show the dashboard
          return loading
              ? Loading()
              : Stack(
                  children: <Widget>[
                    Scaffold(
                      //Background Color
                      backgroundColor: (settings.colortheme == 'Dark')
                          ? DarkColors.primaryColor
                          : LightColors.primaryColor,

                      //App bar
                      appBar: AppBar(
                        backgroundColor: (settings.colortheme == 'Dark')
                            ? DarkColors.primaryColor
                            : LightColors.primaryColor,
                        //removes the dop shadow
                        elevation: 0,
                        titleSpacing: 10.0,
                        automaticallyImplyLeading: false,
                        title: Row(
                          children: <Widget>[
                            Text("Welcome ",
                                style: ThemeText.titleStyle.copyWith(
                                  color: (settings.colortheme == 'Dark')
                                      ? DarkColors.primaryTextColor
                                      : LightColors.primaryTextColor,
                                )),
                            Text(
                                //1. Checks if the user has added their details in
                                (userData.fullName != '')
                                    //2a. takes the splitname string from before.
                                    ? splitFullName
                                            //3. grabs the first character from the string and capitilises
                                            .substring(0, 1)
                                            .toUpperCase() +
                                        //4. Adds the remaining characters back onto the now capital letter
                                        splitFullName.substring(1) +
                                        ',' //adds comma
                                    //2b. If the user hasnt added their details then show their display name
                                    : userData.displayName
                                            .substring(0, 1)
                                            .toUpperCase() +
                                        userData.displayName.substring(1) +
                                        ',',
                                style: ThemeText.titleStyle.copyWith(
                                  color: (settings.colortheme == 'Dark')
                                      ? DarkColors.primaryTextColor
                                      : LightColors.primaryTextColor,
                                )),
                          ],
                        ),
                        actions: <Widget>[
                          //Opens the search functionality
                          FlatButton(
                            onPressed: () {
                              // _onTap();
                              onSearchButtonPressed(context);
                            },
                            child: Icon(
                              Icons.search,
                              color: (settings.colortheme == 'Dark')
                                  ? DarkColors.primaryTextColor
                                  : LightColors.primaryTextColor,
                              size: 28,
                            ),
                          )
                        ],
                      ),

                      //side menu
                      drawer: SideMenu(),

                      //Main Body
                      body: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //1. Checks if the user has updated their data
                          (userData.grade == '')
                              //2. shows them the account information warning
                              ? Column(
                                  children: [
                                    _buildAccountInformation(),
                                    SizedBox(height: 5)
                                  ],
                                )
                              //3. else shows them an empter container
                              : Container(),
                          //spacer
                          SizedBox(height: 10),
                          //
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text("What role can we help you find?",
                                  style: ThemeText.titleStyle2.copyWith(
                                    color: (settings.colortheme == 'Dark')
                                        ? DarkColors.primaryTextColor
                                        : LightColors.primaryTextColor,
                                  )),
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: _buildCategoryListview(),
                          ),
                          SizedBox(height: 15),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: _buildTabBar(),
                            ),
                          ),
                          SizedBox(height: 20),
                          _buildTabBarView(userData)
                        ],
                      ),

                      bottomNavigationBar: BottomNavBar(),
                    ),
                  ],
                );
        } else {
          return Loading();
        }
      },
    );
  }
}