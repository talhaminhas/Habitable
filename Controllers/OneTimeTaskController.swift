//
//  ViewController.swift
//  temp
//
//  Created by Minhax on 21/05/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import UIKit

class OneTimeTaskController: UITableViewController {

   
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var colorImage: UIImageView!
    
    var headersNames = ["Name:","Display:","I want to set a goal:" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
         title = "One Time Task"
        
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("TableHeader2", owner: self, options: nil)?.first as! TableHeader2
        headerView.headerLabel.text = headersNames[section]
        return headerView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1  {
            return 40
        }
        return 40
    }

}

extension OneTimeTaskController: ColorsViewControllerDelegate,IconsViewControllerDelegate {
    
    
    func passSelectedColor(data: String) {
        
        colorImage.backgroundColor = UIColor(named: data)
    }
    
    func passSelectedIcon(data: String) {
        
        iconImage.image = UIImage(systemName: data)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "IconSegue1" {
            if let nextViewController = segue.destination as? IconsViewController {

                nextViewController.delegate = self
            }
        }
        
        if segue.identifier == "ColorSegue1" {
                   if let nextViewController = segue.destination as? ColorsViewController {

                       nextViewController.delegate = self
                   }
               }
        
    }
    
    
}

