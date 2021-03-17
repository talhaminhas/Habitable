//
//  AppDelegate.swift
//  IslamicHT
//
//  Created by Minhax on 15/05/2020.
//  Copyright ©️ 2020 Talha. All rights reserved.
//

import UIKit
import RealmSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    let realm = try! Realm()
    func addMissedHabit(missedHabit:MissedHabit,inDate date :String){
        let dateRecord = realm.object(ofType: DateRecord.self, forPrimaryKey: date)
        if (dateRecord != nil){
            try! realm.write {
                dateRecord?.missed.append(missedHabit)
                realm.add(dateRecord!, update: .all)
            }
        }else{
            let newDateRecord = DateRecord(date: date)
            newDateRecord.missed.append(missedHabit)
            try! realm.write {
                realm.add(newDateRecord)
            }
        }
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let oldDate = UserDefaults.standard.string(forKey: "date")
        
        if oldDate != nil {
            //let newDate = "2020-06-15"
            if oldDate != TableCell.stringDate(date: Date()){//TableCell.stringDate(date: Date())
                let allHabits = realm.objects(RegularHabit.self)
                for i in allHabits{
                    if !OngoingController.statusExists(habit: i, date: oldDate!){
                        let monthDate = Date().dayBefore.get(.day, .month, .year).day!
                        let weekDay = Calendar.current.component(.weekday, from: Date().dayBefore)
                        if(i.repeatMode == "Monthly"){
                            for j in i.days{
                                if monthDate == j.date{
                                    addMissedHabit(missedHabit: MissedHabit(name: i.name, iconName: i.iconName, colorName: i.colorName, timeOfDay: i.timeOfDay), inDate: oldDate!)
                                }
                            }
                        }
                        else if(i.repeatMode == "Weekly")
                        {
                            for j in i.days{
                                if weekDay == j.date{
                                    addMissedHabit(missedHabit: MissedHabit(name: i.name, iconName: i.iconName, colorName: i.colorName, timeOfDay: i.timeOfDay), inDate: oldDate!)
                                }
                            }
                        }
                        else{
                            addMissedHabit(missedHabit: MissedHabit(name: i.name, iconName: i.iconName, colorName: i.colorName, timeOfDay: i.timeOfDay), inDate: oldDate!)
                        }
                    }
                }
                UserDefaults.standard.set(TableCell.stringDate(date: Date()), forKey: "date")
            }
        }else{
            print(TableCell.stringDate(date: Date()))
            UserDefaults.standard.set(TableCell.stringDate(date: Date()), forKey: "date")
            
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    var monthName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
}
