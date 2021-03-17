//
//  ViewController.swift
//  temp
//
//  Created by Minhax on 21/05/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import UIKit
import KDCalendar
import RealmSwift
class RegularHabitController: UITableViewController,IconsViewControllerDelegate, ColorsViewControllerDelegate {
    
    

    let realm = try! Realm()
    let newHabit = RegularHabit()
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var calendarView: CalendarView!
    @IBOutlet var table: UITableView!
    @IBOutlet weak var goalSwitch: UISwitch!
    @IBOutlet var repeatTicks: [UIImageView]!
    @IBOutlet var timeTicks: [UIImageView]!
    @IBOutlet var weekDays: [UIButton]!
    
    @IBOutlet weak var IconImage: UIImageView!
    @IBOutlet weak var ColorImage: UIImageView!
    
    var IconImageView = "book"
    
    var selectedWeekDays = [Int]()
    var headersNames = ["Name:","Display:","Goal:","Repeat: ","On these days of week: ","On these days of month:","Time:"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.dataSource = self
        calenderFormat()
        title = "Regular Habit"
        newHabit.repeatMode = "Daily"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "IconSegue" {
            if let nextViewController = segue.destination as? IconsViewController {

                nextViewController.delegate = self
            }
        }
        
        if segue.identifier == "ColorSegue" {
                   if let nextViewController = segue.destination as? ColorsViewController {

                       nextViewController.delegate = self
                   }
               }
        
    }

    func passSelectedColor(data: String)
    {
        newHabit.colorName = data
        ColorImage.backgroundColor = UIColor(named: data)
        IconImage.tintColor = UIColor(named: data)
    }
    func passSelectedIcon(data: String)
    {
        newHabit.iconName = data
        IconImageView = data
        IconImage.image = UIImage(systemName: IconImageView)
    }
    @IBAction func doneClicked(_ sender: UIBarButtonItem) {
        if(nameTextField.text! != ""){
            newHabit.name = nameTextField.text!
            newHabit.goal = goalSwitch.isOn
            if(newHabit.repeatMode == "Weekly")
            {
                for i in selectedWeekDays{
                    let day = Day()
                    day.date = i
                    newHabit.days.append(day)
                }
                print(selectedWeekDays)
            }
            if(newHabit.repeatMode == "Monthly"){
                for i in self.calendarView.selectedDates{
                    let components = i.get(.day, .month, .year)
                    let day = Day()
                    day.date = components.day!
                    newHabit.days.append(day)
                }
            }
            do{
                try realm.write{
                    realm.add(newHabit)
                }
            }catch{
                print("error saving new habit \(error)")
                }
            _ = navigationController?.popToRootViewController(animated: true)
        }
    }
    @IBAction func weekDayClick(_ sender: UIButton) {
        if selectedWeekDays.contains(weekDays.firstIndex(of: sender)!+1){
            sender.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
            sender.setTitleColor(UIColor.label, for: .normal)
            //print(selectedWeekDays.firstIndex(of: weekDays.firstIndex(of: sender)!+1)!)
            selectedWeekDays.remove(at: selectedWeekDays.firstIndex(of: weekDays.firstIndex(of: sender)!+1)!)
        }
        else{
            selectedWeekDays.append(weekDays.firstIndex(of: sender)!+1)
            sender.setBackgroundImage(UIImage(systemName: "circle.fill"), for: .normal)
            sender.setTitleColor(#colorLiteral(red: 0.9322496057, green: 0.622553885, blue: 0.1740649045, alpha: 1), for: .normal)
        }
    }
    @IBAction func goalSwitchChanged(_ sender: UISwitch) {
        table.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        switch indexPath {
        case [3,0]:
            newHabit.repeatMode = "Daily"
            repeatTicks[0].image = UIImage(systemName: "checkmark.circle.fill")
            repeatTicks[1].image = nil
            repeatTicks[2].image = nil
            table.reloadData()
        case [3,1]:
            newHabit.repeatMode = "Weekly"
            repeatTicks[0].image = nil
            repeatTicks[1].image = UIImage(systemName: "checkmark.circle.fill")
            repeatTicks[2].image = nil
            table.reloadData()
        case [3,2]:
            newHabit.repeatMode = "Monthly"
            repeatTicks[0].image = nil
            repeatTicks[1].image = nil
            repeatTicks[2].image = UIImage(systemName: "checkmark.circle.fill")
            table.reloadData()
        case [6,0]:
            newHabit.timeOfDay = "Morning"
            timeTicks[0].image = UIImage(systemName: "checkmark.circle.fill")
            timeTicks[1].image = nil
            timeTicks[2].image = nil
            timeTicks[3].image = nil
            table.reloadData()
        case [6,1]:
            newHabit.timeOfDay = "Afternoon"
            timeTicks[0].image = nil
            timeTicks[1].image = UIImage(systemName: "checkmark.circle.fill")
            timeTicks[2].image = nil
            timeTicks[3].image = nil
            table.reloadData()
        case [6,2]:
            newHabit.timeOfDay = "Evening"
            timeTicks[0].image = nil
            timeTicks[1].image = nil
            timeTicks[2].image = UIImage(systemName: "checkmark.circle.fill")
            timeTicks[3].image = nil
            table.reloadData()
        case [6,3]:
            newHabit.timeOfDay = "Once at any time"
            timeTicks[0].image = nil
            timeTicks[1].image = nil
            timeTicks[2].image = nil
            timeTicks[3].image = UIImage(systemName: "checkmark.circle.fill")
            table.reloadData()
        case [5,0],[4,0]:
            table.reloadData()
        default:
            return
        }
    }
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 && indexPath.row == 1 && goalSwitch.isOn == false {
            return 0
        }
        if indexPath.section == 0 && indexPath.row == 0{
            return 55
        }
        if indexPath.section == 5 && indexPath.row == 0{
            return 360
        }
        return tableView.rowHeight
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("TableHeader2", owner: self, options: nil)?.first as! TableHeader2
        headerView.headerLabel.text = headersNames[section]
        return headerView
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if newHabit.repeatMode == "Daily" && (section == 4 || section == 5){
            return 0
        }
        if newHabit.repeatMode == "Weekly" && section == 5{
                return 0
        }
        if newHabit.repeatMode == "Monthly" && section == 4{
                return 0
        }
        switch section {
        case 1,2:
            return 2
        case 3:
            return 3
        case 6:
            return 4
        default:
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        }
        if section == 1 || section == 2 {
            return 40
        }
        if newHabit.repeatMode == "Daily" && (section == 4 || section == 5){
            return 0
        }
        if newHabit.repeatMode == "Weekly" && section == 5{
                return 0
        }
        if newHabit.repeatMode == "Monthly" && section == 4{
                return 0
        }
        return 40
    }
}
extension RegularHabitController: CalendarViewDataSource{
    func calenderFormat(){
        calendarView.direction = .horizontal
        
        let myStyle = CalendarView.Style()
        myStyle.cellBorderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        myStyle.cellTextColorWeekend = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        myStyle.cellColorToday = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        myStyle.cellSelectedBorderColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        myStyle.cellTextColorDefault = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        myStyle.cellTextColorToday = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        myStyle.cellSelectedTextColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        myStyle.headerBackgroundColor = #colorLiteral(red: 0.282318294, green: 0.2823728323, blue: 0.282314837, alpha: 1)
        myStyle.weekdaysBackgroundColor = #colorLiteral(red: 0.282318294, green: 0.2823728323, blue: 0.282314837, alpha: 1)
        myStyle.weekdaysTextColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        myStyle.headerTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        myStyle.headerTopMargin = 0
        myStyle.headerHeight = 0
        myStyle.weekdaysHeight = 0
        myStyle.weekdaysTopMargin = 0
        myStyle.weekdaysBottomMargin = 0
        myStyle.headerFont = UIFont.systemFont(ofSize: 25, weight: .regular)
        myStyle.weekdaysFont = UIFont.systemFont(ofSize: 18, weight: .regular)
        myStyle.cellBorderWidth = 1.0
        myStyle.cellSelectedBorderWidth = 1.0
        myStyle.cellShape = CalendarView.Style.CellShapeOptions.round
        self.calendarView.style = myStyle
        
    }
    func headerString(_ date: Date) -> String? {
        return "Today"
    }
    func endDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "2021/03/31 22:31")!
        return someDateTime
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let startDate = formatter.date(from: "2021/03/01 22:31")!
        self.calendarView.setDisplayDate(startDate, animated: false)
        //select date
    }
    func startDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = 0
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let startDate = formatter.date(from: "2021/03/01 22:31")!
        let threeMonthsAgo = self.calendarView.calendar.date(byAdding:dateComponents, to: startDate)!
        return threeMonthsAgo
    }
}
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
