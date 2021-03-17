//
//  DateRecord.swift
//  IslamicHT
//
//  Created by Minhax on 11/06/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import Foundation
import RealmSwift
class CompeletedHabit : Object{
    @objc dynamic var name = ""
    @objc dynamic var iconName: String = "moon"
    @objc dynamic var colorName: String = "orange"
    @objc dynamic var timeOfDay: String = "Morning"
    var parentCategory = LinkingObjects(fromType: DateRecord.self, property: "compeleted")
    
    init(name:String,iconName:String,colorName:String,timeOfDay:String) {
        self.name = name
        self.iconName = iconName
        self.colorName = colorName
        self.timeOfDay = timeOfDay
    }
    required override init() {
        
    }
}
class LateHabit : Object{
    @objc dynamic var name = ""
    @objc dynamic var iconName: String = "moon"
    @objc dynamic var colorName: String = "orange"
    @objc dynamic var timeOfDay: String = "Morning"
    var parentCategory = LinkingObjects(fromType: DateRecord.self, property: "late")
    
    init(name:String,iconName:String,colorName:String,timeOfDay:String) {
        self.name = name
        self.iconName = iconName
        self.colorName = colorName
        self.timeOfDay = timeOfDay
    }
    required override init() {
        
    }
}
class MissedHabit : Object{
    @objc dynamic var name = ""
    @objc dynamic var iconName: String = "moon"
    @objc dynamic var colorName: String = "orange"
    @objc dynamic var timeOfDay: String = "Morning"
    var parentCategory = LinkingObjects(fromType: DateRecord.self, property: "missed")
    
    init(name:String,iconName:String,colorName:String,timeOfDay:String) {
        self.name = name
        self.iconName = iconName
        self.colorName = colorName
        self.timeOfDay = timeOfDay
    }
    required override init() {
        
    }
}
class DateRecord: Object{
    @objc dynamic var date = ""
    let compeleted = List<CompeletedHabit>()
    let late = List<LateHabit>()
    let missed = List<MissedHabit>()
    
    override class func primaryKey() -> String {
        return "date"
    }
    init(date:String) {
        self.date = date
    }
    required override init() {
        
    }
}
