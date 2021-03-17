//
//  MyHabitsViewController.swift
//  Habitable
//
//  Created by Mian Saram on 13/01/2021.
//  Copyright © 2021 Habitable. All rights reserved.
//

import UIKit
import RealmSwift


class MyTVC: UITableViewCell{
        @IBOutlet weak var habitTitle: UILabel!
        @IBOutlet weak var repeatMode: UILabel!
        @IBOutlet weak var iconImage: UIImageView!
        @IBOutlet weak var duration: UILabel!
        @IBOutlet weak var timeReps: UILabel!
    }

class MyHabitsViewController: UIViewController {

        let realm = try! Realm()
        var myHabits: Results<RegularHabit>!
        
        @IBOutlet weak var tableView: UITableView!
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "My Habits"
            
            tableView.delegate = self
            tableView.dataSource = self
            loadHabits()
        }
        override func viewWillAppear(_ animated: Bool) {
            loadHabits()
        }
        func loadHabits (){
            myHabits = realm.objects(RegularHabit.self)
            tableView.reloadData()
        }
    }

extension MyHabitsViewController: UITableViewDataSource,UITableViewDelegate {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             myHabits.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)as!MyTVC
            cell.habitTitle.text = self.myHabits[indexPath.row].name
            cell.repeatMode.text = self.myHabits[indexPath.row].repeatMode
            cell.iconImage.image =  UIImage(systemName: self.myHabits[indexPath.row].iconName)
            cell.iconImage.tintColor = UIColor(named: self.myHabits[indexPath.row].colorName )
            //cell.layer.shadowOffset = CGSize(width: 3, height: 3)
            //cell.layer.shadowColor = UIColor.black.cgColor
            //cell.layer.shadowOpacity = 0.30
            //cell.layer.shadowRadius = 5
            //cell.iconImage.tintColor = UIColor.magenta
            if(self.myHabits[indexPath.row].goal)
            {
            cell.timeReps.text = self.myHabits[indexPath.row].timeReps == "Time" ? "min" : "reps" ;
                cell.duration.text = String(self.myHabits[indexPath.row].duration)
            }
            else{
                cell.timeReps.text = ""
                cell.duration.text = ""
            }
            return cell
        }
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        CGFloat.leastNormalMagnitude
    //    }
    //
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        nil
    //    }
    //
    //    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        nil
    //    }
    //
    //    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //
    //        return 10
    //    }
    //    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    //        //view.tintColor = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1.00)
    //         //view.tintColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    //        view.tintColor = UIColor(named: "BackgroundColor")
    //    }
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete{
                do{
                    try realm.write{
                        realm.delete(myHabits[indexPath.row])
                    }
                }catch{
                    print("error deleting habit \(error)")
                }
                       
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            else if editingStyle == .insert
            {
                
            }
        }
        
    }
