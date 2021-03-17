//
//  CategoryDetailViewController.swift
//  IslamicHT
//
//  Created by Mian Saram on 14/06/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import UIKit

class CategoryListTVC: UITableViewCell
{
   
    @IBOutlet weak var CDImage: UIImageView!
    @IBOutlet weak var CDTitle: UILabel!
    
}

class CategoryDetailViewController: UIViewController {

    
    @IBOutlet weak var CategoryTV: UITableView!
    
    let count = ["Recite Surah Yaseen","Recite Surah AL-Rehman","Recite Surah Yaseen","Recite Surah AL-Rehman","Recite Surah Yaseen","Recite Surah AL-Rehman","Recite Surah Yaseen","Recite Surah AL-Rehman","Recite Surah Yaseen","Recite Surah AL-Rehman","Recite Surah Yaseen","Recite Surah AL-Rehman"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CategoryTV.delegate = self
        CategoryTV.dataSource = self
        title = "Islamic"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CategoryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell2", for: indexPath)as!CategoryListTVC
        
        cell.CDTitle.text = self.count[indexPath.row]
        return cell
    }
    
    
}
