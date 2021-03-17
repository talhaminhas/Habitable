//
//  ColorsViewController.swift
//  IslamicHT
//
//  Created by Mian Saram on 29/05/2020.
//  Copyright © 2020 Mian Saram. All rights reserved.
//

import UIKit

protocol ColorsViewControllerDelegate: class {
    
    func passSelectedColor(data: String)
}
//..............................................................
class ColorsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var color: UIView!
    
}
//..............................................................
class ColorsViewController: UIViewController {

    weak var delegate : ColorsViewControllerDelegate?
    let colorArray = ["systemGreen","green","systemPurple","systemTeal","blue","systemBlue","systemIndigo","magenta","brown","systemPink","systemYellow","yellow","orange","systemRed","red","systemOrange", "systemGray","black" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Colors"

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    {
        didSet
        {
            colorsCollectionView.delegate = self
            colorsCollectionView.dataSource = self
            
        }
    }
}

extension ColorsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorsCell", for: indexPath)
        if let ColorsCell = cell as? ColorsCollectionViewCell
        {
            ColorsCell.color.backgroundColor = UIColor(named: colorArray[indexPath.item])
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.passSelectedColor(data: colorArray[indexPath.row])
        navigationController?.popViewController(animated: true)
        
    }
}
