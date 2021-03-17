//
//  IconsViewController.swift
//  IslamicHT
//
//  Created by Mian Saram on 29/05/2020.
//  Copyright © 2020 Mian Saram. All rights reserved.
//

import UIKit

protocol IconsViewControllerDelegate: class {
    
    func passSelectedIcon(data: String)
}
//..............................................................
class IconsCollectionViewCell: UICollectionViewCell
{
    
    
    @IBOutlet weak var icon: UIImageView!
}
//..............................................................
class IconsViewController: UIViewController {

    var icons = ["heart","book", "moon.stars", "message","phone", "video", "envelope", "paperclip", "link" , "pencil.tip" ,"flag", "bell" , "tag" , "camera" , "gear" , "scissors" ,"wrench" , "printer" , "bandage" , "lock", "pin", "map" , "bed.double" , "alarm" , "gamecontroller" , "gift", "hourglass", "eyeglasses", "car", "airplane" ,  "person.3", "cart", "creditcard"]
    weak var delegate : IconsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         title = "Icons"
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var iconsCollectionView: UICollectionView!
    {
        didSet
        {
            iconsCollectionView.delegate = self
            iconsCollectionView.dataSource = self
            
        }
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

//MARK: - UICollectionView

extension IconsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconsCell", for: indexPath)
        if let IconsCell = cell as? IconsCollectionViewCell
        {
           IconsCell.icon.image = UIImage(systemName: icons[indexPath.item])
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
           delegate?.passSelectedIcon(data: icons[indexPath.row])
           navigationController?.popViewController(animated: true)
           
       }
       
   
    
    
}
