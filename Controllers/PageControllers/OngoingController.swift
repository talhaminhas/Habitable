//
//  OngoingController.swift
//  IslamicHT
//
//  Created by Minhax on 15/05/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import UIKit
import DateScrollPicker
import RealmSwift
class OngoingController: UIViewController {

    let realm = try! Realm()
    
    @IBOutlet weak var datePicker: DateScrollPicker!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
   // @IBOutlet weak var messageLabel: UITextView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet var label: UILabel!
    
    var morningHabits = [RegularHabit]()
    var afternoonHabits = [RegularHabit]()
    var eveningHabits = [RegularHabit]()
    static var selectedDate = Date()
    var habits = [Objects]()
    var displayString : String?
    var index : Int?
    let messageTitle = [ "Stay Consistent","Perfect!", "Be Punctual","Give It Another Try"]
//    let message = [ "Consistency is the key to success","Nothing is impossible, the word itself says ‘I’m possible", "It seems like you have done everything on time, Keep it up! 😀","You can always start over and do better"]
    let messageColor = [#colorLiteral(red: 1, green: 0.6414161325, blue: 0, alpha: 1),#colorLiteral(red: 0.3843137255, green: 0.7764705882, blue: 0.3333333333, alpha: 1),#colorLiteral(red: 0.2549019608, green: 0.5725490196, blue: 0.8745098039, alpha: 1),#colorLiteral(red: 0.7568627451, green: 0.3019607843, blue: 1, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        label.text=messageTitle[index!]
       // messageLabel.text = message[index!]
        messageView.layer.cornerRadius=5
        messageView.backgroundColor = messageColor[index!]
        if (index == 3){
            //messageLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        if (index == 0){
            messageView.frame.size.height = 0
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        datePicker.delegate = self
        switch displayString {
        case "Ongoing":
            pickerView.selectRow(0, inComponent: 0,animated: true)
        case "Compeleted":
            pickerView.selectRow(1, inComponent: 0,animated: true)
        case "Late":
            pickerView.selectRow(2, inComponent: 0,animated: true)
        default:
            pickerView.selectRow(3, inComponent: 0,animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        loadHabits(monthDate: OngoingController.selectedDate.get(.day, .month, .year).day!,weekDay: Calendar.current.component(.weekday, from: OngoingController.selectedDate))
    }
    func loadHabits(monthDate: Int, weekDay:Int){
        switch displayString {
        case "Ongoing":
            loadOngoingHabits(monthDate: monthDate, weekDay: weekDay)
        default:
            loadHabitsStatus()
        }
    }
    private func sortHabit(habit:RegularHabit){
        switch habit.timeOfDay {
        case "Morning":
            morningHabits.append(habit)
        case "Afternoon":
            afternoonHabits.append(habit)
        case "Evening":
            eveningHabits.append(habit)
        default:
            morningHabits.append(habit)
        }
    }
    static func statusExists (habit : RegularHabit , date : String)-> Bool{
        let realm = try! Realm()
        let date = realm.object(ofType: DateRecord.self, forPrimaryKey: date)
        if date != nil{
            for i in date!.compeleted{
                if habit.name == i.name{
                    return true
                }
            }
            for i in date!.late{
                if habit.name == i.name{
                    return true
                }
            }
            for i in date!.missed{
                if habit.name == i.name{
                    return true
                }
            }
        }
        return false
    }
    private func loadOngoingHabits(monthDate: Int, weekDay:Int){
        habits.removeAll()
        morningHabits.removeAll()
        afternoonHabits.removeAll()
        eveningHabits.removeAll()
        let order = Calendar.current.compare(OngoingController.selectedDate, to: Date(), toGranularity: .day)
        if order == .orderedDescending || order == .orderedSame{
            let allHabits = realm.objects(RegularHabit.self)
            for i in allHabits{
                if !OngoingController.statusExists(habit: i,date: TableCell.stringDate(date: OngoingController.selectedDate)){
                    if(i.repeatMode == "Monthly"){
                        for j in i.days{
                            if monthDate == j.date{
                                sortHabit(habit: i)
                            }
                        }
                    }
                    else if(i.repeatMode == "Weekly")
                    {
                        for j in i.days{
                            if weekDay == j.date{
                                sortHabit(habit: i)
                            }
                        }
                    }
                    else{
                        sortHabit(habit: i)
                    }
                }
            }
        }
        
        loadTable()
        messageView.frame.size.height = habits.isEmpty ? 80 : 0
        
    }
    private func loadTable(){
        if !morningHabits.isEmpty{
            habits.append(Objects(sectionName: "Morning", sectionObjects: morningHabits))
        }
        if !afternoonHabits.isEmpty{
            habits.append(Objects(sectionName: "Afternoon", sectionObjects: afternoonHabits))
        }
        if !eveningHabits.isEmpty{
            habits.append(Objects(sectionName: "Evening", sectionObjects: eveningHabits))
        }
        UIView.transition(with: tableView,duration: 0.35,options: .transitionCrossDissolve ,animations: {self.tableView.reloadData() })
    }
    func loadHabitsStatus()
    {
        habits.removeAll()
        morningHabits.removeAll()
        afternoonHabits.removeAll()
        eveningHabits.removeAll()
        let date = realm.object(ofType: DateRecord.self, forPrimaryKey: TableCell.stringDate(date: OngoingController.selectedDate))
        if date != nil{
            switch displayString {
            case "Compeleted":
                let compeleted = date?.compeleted
                for i in compeleted!{
                    let newhabit = RegularHabit()
                    newhabit.name = i.name
                    newhabit.colorName = i.colorName
                    newhabit.iconName  = i.iconName
                    newhabit.timeOfDay = i.timeOfDay
                    sortHabit(habit: newhabit)
                }
            case "Late":
                let late = date?.late
                for i in late!{
                    let newhabit = RegularHabit()
                    newhabit.name = i.name
                    newhabit.colorName = i.colorName
                    newhabit.iconName  = i.iconName
                    newhabit.timeOfDay = i.timeOfDay
                    sortHabit(habit: newhabit)
                }
            default:
                let missed = date?.missed
                for i in missed!{
                    let newhabit = RegularHabit()
                    newhabit.name = i.name
                    newhabit.colorName = i.colorName
                    newhabit.iconName  = i.iconName
                    newhabit.timeOfDay = i.timeOfDay
                    sortHabit(habit: newhabit)
                }
            }
        }
        loadTable()
    }
}
extension OngoingController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits[section].sectionObjects.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for : indexPath) as! TableCell
        
        cell.name = habits[indexPath.section].sectionObjects[indexPath.row].name
        cell.colorName = habits[indexPath.section].sectionObjects[indexPath.row].colorName
        cell.iconName = habits[indexPath.section].sectionObjects[indexPath.row].iconName
        cell.timeOfDay = habits[indexPath.section].sectionObjects[indexPath.row].timeOfDay
        cell.status = displayString!
        cell.parentController = self
        cell.createCell()
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        habits.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        habits[section].sectionName
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("TableHeader", owner: self, options: nil)?.first as! TableHeader
        headerView.headerLabel.text = habits[section].sectionName
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
        
    }
}
extension OngoingController : DateScrollPickerDelegate{
    func dateScrollPicker(_ dateScrollPicker: DateScrollPicker, didSelectDate date: Date) {
        OngoingController.selectedDate = date
        let components = date.get(.day, .month, .year)
        loadHabits(monthDate: components.day!,weekDay: Calendar.current.component(.weekday, from: date))
    }
}
