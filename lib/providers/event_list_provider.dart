import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/model/event.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/toast_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../firebase_utils.dart';

class EventListProvider extends ChangeNotifier {
  // data
  List<Event> eventsList = [];
  List<Event> filterList = [];
  List<String> eventsNameList = [];
  int selectedIndex = 0;
  List<Event> favouriteEventsList = [];

  List<String> getEventsNameList(BuildContext context) {
    return eventsNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
  }

  // functions اللي هتغير الداتا

  //todo: get all events
  void getAllEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventsCollection(uId).get();

    /// List<Event>    List<QueryDocumentSnapshot<Event>>
    eventsList =
        querySnapshot.docs.map((doc) {
          return doc.data();
        }).toList();
    filterList = eventsList;

    //todo: sorting events
    filterList.sort((Event event1, Event event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  //todo: get filter events
  void getFilterEvents(String uId) {
    filterList =
        eventsList.where((event) {
          if (event.eventName == eventsNameList[selectedIndex]) {
            return true;

            /// يعني هحطه في ال list الجديدة
          } else {
            return false;
          }

          /// return event.eventName == eventsNameList[selectedIndex];
        }).toList();

    //todo: sorting events
    filterList.sort((Event event1, Event event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void getFilterEventsFromFireStore(String uId) async {
    var querySnapshot =
        await FirebaseUtils.getEventsCollection(uId)
            .where('eventName', isEqualTo: eventsNameList[selectedIndex])
            .orderBy('dateTime')
            .get();
    filterList =
        querySnapshot.docs.map((doc) {
          return doc.data();
        }).toList();
  }

  //todo: update isFavourite
  void updateIsFavouriteEvents(Event event, String uId) async {
    return FirebaseUtils.getEventsCollection(uId)
        .doc(event.id)
        .update({'isFavourite': !event.isFavourite})
        .timeout(
          Duration(milliseconds: 500),
          onTimeout: () {
            //todo: toast updated
            ToastUtils.toastMsg(
              bgColor: AppColors.greenColor,
              textColor: AppColors.whiteColor,
              msg: 'Favourite updated successfully.',
            );

            //todo: get events
            selectedIndex == 0
                ? getAllEvents(uId)
                : getFilterEventsFromFireStore(uId);

            //todo: get favourite events
            getAllFavouriteEvents(uId);
          },
        );
  }

  //todo: get all favourite events
  void getAllFavouriteEvents(String uId) async {
    var querySnapshot =
        await FirebaseUtils.getEventsCollection(
          uId,
        ).where('isFavourite', isEqualTo: true).orderBy('dateTime').get();
    favouriteEventsList =
        querySnapshot.docs.map((doc) {
          return doc.data();
        }).toList();

    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex, String uId) {
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? getAllEvents(uId) : getFilterEvents(uId);
  }

  //todo: Delete event
  Future<void> deleteEvent(String uId, String eventId) async {
    await FirebaseUtils.getEventsCollection(uId).doc(eventId).delete();

    eventsList.removeWhere((event) => event.id == eventId);
    filterList.removeWhere((event) => event.id == eventId);

    notifyListeners();
  }

  //todo: Update event

  Future<void> fetchEvents(String uId) async {
    final snapshot = await FirebaseUtils.getEventsCollection(uId).get();
    eventsList = snapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterList = List.from(eventsList); // Initialize filter list
    notifyListeners();
  }

  Future<void> updateEvent(String uId, Event updatedEvent) async {
    try {
      await FirebaseUtils.getEventsCollection(uId).doc(updatedEvent.id).update({
        'title': updatedEvent.title,
        'description': updatedEvent.description,
        'image': updatedEvent.image,
        'eventName': updatedEvent.eventName,
        'time': updatedEvent.time,
        'dateTime': updatedEvent.dateTime,
      });
      final indexInEvents = eventsList.indexWhere((event) =>
      event.id == updatedEvent.id);
      if (indexInEvents != -1) {
        eventsList[indexInEvents] = updatedEvent;
      }

      final indexInFilter = filterList.indexWhere((event) =>
      event.id == updatedEvent.id);
      if (indexInFilter != -1) {
        filterList[indexInFilter] = updatedEvent;
      }

      notifyListeners();
    } catch (error) {
      print("Error updating event: $error");
      rethrow;
    }
  }

  Event? getEventFromList(String eventId) {
    try {
      Event? event = eventsList.firstWhere((event) => event.id == eventId);
      return event;
    } catch (e) {
      try {
        Event? event = filterList.firstWhere((event) => event.id == eventId);
        return event;
      } catch (e) {
        print("Error getting event from list: $e");
        return null;
      }
    }
  }




}
