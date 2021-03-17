//
//  HabitsViewController.swift
//  IslamicHT
//
//  Created by Mian Saram on 22/05/2020.
//  Copyright © 2020 Mian Saram. All rights reserved.
//

import UIKit



class CategoryTVC: UITableViewCell{
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categorySubHeading1: UILabel!
    @IBOutlet weak var categorySubHeading2: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
}

class HabitsViewController: UIViewController {

    
    @IBOutlet weak var TableView: UITableView!
    
    let count = ["My Habits","Islamic","Education","Fitness","Work","Events"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
         title = "Create"
        TableView.delegate = self
        TableView.dataSource = self
        
    }
    
    
}

extension HabitsViewController: UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell1", for: indexPath)as!CategoryTVC
        
        cell.categoryName.text = self.count[indexPath.row]
        return cell
        
    }
    
    
}


