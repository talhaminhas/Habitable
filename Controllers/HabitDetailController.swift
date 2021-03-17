//
//  HabitControllerViewController.swift
//  IslamicHT
//
//  Created by Minhax on 23/05/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import UIKit
import KDCalendar
class HabitDetailController: UIViewController {

    @IBOutlet weak var streakView: UIView!
    @IBOutlet weak var calendarView: CalendarView!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Habit"
        streakView.layer.borderWidth = 0.5
        streakView.layer.borderColor = #colorLiteral(red: 1, green: 0.6414161325, blue: 0, alpha: 1)
        calendarView.dataSource = self
        calenderFormat()
    }
}
extension HabitDetailController: CalendarViewDataSource{
    func calenderFormat(){
        calendarView.direction = .horizontal
        
        let myStyle = CalendarView.Style()
        myStyle.cellBorderColor = UIColor(named: "BrandColor")!
        myStyle.cellTextColorWeekend = UIColor(named: "BrandColor")!
        myStyle.cellColorToday = UIColor(named: "BrandColor")!
        myStyle.cellSelectedBorderColor = UIColor(named: "BrandColor")!
        myStyle.cellTextColorDefault = UIColor.label
        myStyle.cellTextColorToday = UIColor.label
        myStyle.cellSelectedTextColor = UIColor(named: "BrandColor")!
        myStyle.headerBackgroundColor = UIColor.systemBackground
        myStyle.weekdaysBackgroundColor = UIColor.systemBackground
        myStyle.weekdaysTextColor = UIColor(named: "BrandColor")!
        myStyle.headerTextColor = UIColor(named: "systemGreen")!
        myStyle.headerTopMargin = 10
        myStyle.weekdaysHeight = 20
        myStyle.weekdaysTopMargin = 10
        myStyle.weekdaysBottomMargin = 10
        myStyle.headerFont = UIFont.systemFont(ofSize: 25, weight: .regular)
        myStyle.weekdaysFont = UIFont.systemFont(ofSize: 18, weight: .regular)
        myStyle.cellBorderWidth = 1.0
        myStyle.cellShape = CalendarView.Style.CellShapeOptions.round
        myStyle.firstWeekday = .sunday
        self.calendarView.style = myStyle
        
    }
    func headerString(_ date: Date) -> String? {
        return Date().monthName
    }
    func endDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "2021/10/08 22:31")!
        return someDateTime
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let today = Date()
        self.calendarView.setDisplayDate(today, animated: true)
        //select date
    }
    func startDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = -3
        let today = Date()
        let threeMonthsAgo = self.calendarView.calendar.date(byAdding:dateComponents, to: today)!
        return threeMonthsAgo
    }
    
}
