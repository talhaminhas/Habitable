//
//  TableCell.swift
//  IslamicHT
//
//  Created by Minhax on 17/05/2020.
//  Copyright © 2020 Talha. All rights reserved.
//
//
import Foundation
import UIKit
import RealmSwift
class TableCell : UITableViewCell{
    
    let realm = try! Realm()
    
    var s = "https://docs.google.com/spreadsheets/d/1BqyVeQfAX0s-d1soP5n1j-rQW_P0B6owrLfbiuyfE1M/edit#gid=0"
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var habitLabel: UILabel!
    @IBOutlet weak var colorImage1: UIImageView!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var colorImage2: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    
    var parentController = OngoingController()
    var status = "Ongoing"
    var name = ""
    var iconName: String = "moon"
    var colorName: String = "orange"
    var timeOfDay: String = "Morning"
    
    func createCell(){
        self.backView.layer.borderWidth = 1
        self.backView.layer.borderColor = #colorLiteral(red: 1, green: 0.6414161325, blue: 0, alpha: 1)
        self.habitLabel.text = name
        self.colorImage1.backgroundColor = UIColor(named:colorName)
        self.colorImage2.backgroundColor = UIColor(named:colorName)
        self.iconImage.tintColor = UIColor(named:colorName)
        self.iconImage.image = UIImage(systemName: iconName)
        switch status {
            case "Compeleted":
                statusButton.setImage(UIImage(systemName:"checkmark.circle.fill"), for: .normal)
                statusButton.tintColor = #colorLiteral(red: 0.1333350511, green: 1, blue: 0.05652980038, alpha: 1)
            case "Missed":
                statusButton.setImage(UIImage(systemName:"clear.fill"), for: .normal)
                statusButton.tintColor = #colorLiteral(red: 1, green: 0.1040816333, blue: 0.0351642207, alpha: 1)
            default:
                let _ = 1
        }
    }
    @IBAction func statusButtonClicked(_ sender: UIButton) {
        let date = realm.object(ofType: DateRecord.self, forPrimaryKey: TableCell.stringDate(date: OngoingController.selectedDate))
        if status == "Ongoing"{
            if (date != nil){
                try! realm.write {
                    date?.compeleted.append(CompeletedHabit(name: name, iconName: iconName, colorName: colorName, timeOfDay: timeOfDay))
                    realm.add(date!, update: .all)
                }
                print("updated")
            }else{
                let newDate = DateRecord(date: TableCell.stringDate(date: OngoingController.selectedDate))
                newDate.compeleted.append(CompeletedHabit(name: name, iconName: iconName, colorName: colorName, timeOfDay: timeOfDay))
                try! realm.write {
                    realm.add(newDate)
                }
                print("added")
            }
        }
        if status == "Compeleted" {
            let compeleted = date?.compeleted
            try! realm.write {
                for i in compeleted!{
                    if i.name == name{
                        compeleted?.remove(at: (compeleted?.index(of: i))!) ; break
                    }
                }
                realm.add(date!, update: .all)
            }
        }
        parentController.loadHabits(monthDate: OngoingController.selectedDate.get(.day, .month, .year).day!,weekDay: Calendar.current.component(.weekday, from: OngoingController.selectedDate))
    }
    static func stringDate (date : Date)->String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let now = df.string(from: date)
        return now
    }
}
