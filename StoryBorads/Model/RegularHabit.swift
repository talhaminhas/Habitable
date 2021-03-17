//
//  RegularHabit.swift
//  IslamicHT
//
//  Created by Minhax on 08/06/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import Foundation
import RealmSwift
class Day : Object{
    @objc dynamic var date: Int = 0
    var parentCategory = LinkingObjects(fromType: RegularHabit.self, property: "days")
}
class RegularHabit: Object{
    @objc dynamic var isOn: Bool = true
    @objc dynamic var name: String = ""
    @objc dynamic var repeatMode: String = "Daily"
    @objc dynamic var iconName: String = "moon"
    @objc dynamic var colorName: String = "orange"
    @objc dynamic var goal: Bool = true
    @objc dynamic var timeReps: String = "Time"
    @objc dynamic var duration: Int = 0
    @objc dynamic var timeOfDay: String = "Morning"
    let days = List<Day>()
    
    override class func primaryKey() -> String {
        return "name"
    }
}
