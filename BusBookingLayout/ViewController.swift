//
//  ViewController.swift
//  BusBookingLayout
//
//  Created by Nilesh's MAC on 7/5/18.
//  Copyright © 2018 Nilesh's MAC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var seatInfoView: UIView!
    @IBOutlet var seatInfoCollectionView: UICollectionView!
    @IBOutlet var seatSelectionView: UIView!
    @IBOutlet var upDownSegment: UISegmentedControl!
    @IBOutlet var cabinView: UIView!
    @IBOutlet var seatCollectionView: UICollectionView!
    
    @IBOutlet var selectedDetailView: UIView!
    @IBOutlet var selectedSeatLbl: UILabel!
    @IBOutlet var proceedBtn: UIButton!
    
    var seatInfoDict = [["Normal", UIColor.green], ["Sold", UIColor.lightGray], ["Female", UIColor.magenta], ["Male", UIColor.blue], ["Seater", UIColor.green], ["Sleeper", UIColor.green]]
    
    var busSeatNumDict = [Int : String]()
    var pathWayNumber = Int()
    var seatNumer = Int()
    var deductNumber = 2
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pathWayNumber = 0 // CENTER - PASSENGER CAN WALK
        seatNumer = 1  // STARTING NUMBER
        for i in 0...59
        {
            if i == pathWayNumber // If it s centre, values empty to dictionary
            {
                busSeatNumDict[i] = ""
                if deductNumber == 2 {
                    pathWayNumber = pathWayNumber + deductNumber
                    deductNumber = 3
                }else {
                    pathWayNumber = pathWayNumber + deductNumber
                    deductNumber = 2
                }
                 // Position empty - 2,7,12,17,22 ...... like that
            }else if i%6 == 0 {
                busSeatNumDict[i] = ""
                pathWayNumber = pathWayNumber + 1
            }
            else
            {
                busSeatNumDict[i] = String(seatNumer)
                seatNumer = seatNumer + 1
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func proceedBtnTapped(_ sender: UIButton) {
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if seatCollectionView == collectionView {
            return 60
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if seatCollectionView == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "SeatsCell", for: indexPath) as! SeatCollectionViewCell
            
            cell.alpha = 0 // Initially alpha 0
            let text = busSeatNumDict[indexPath.row]!
            
            if text == ""
            {
                cell.alpha = 0
            }
            else
            {
                cell.alpha = 1
            }
            cell.backgroundColor = UIColor.clear
            
            cell.layer.borderColor = UIColor.green.cgColor
            cell.layer.borderWidth = 1.0
            cell.seatNumberLbl.text = text
            cell.seatNumberLbl.textAlignment = .center
            cell.seatNumberLbl.textColor = UIColor.darkGray
            //cell.layer.cornerRadius = 5
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "SeatInfoCell", for: indexPath) as! SeatInfoCollectionViewCell
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if seatCollectionView == collectionView {
            return CGSize(width: (self.seatCollectionView?.frame.width)! / 7, height: 100)
        }
        
        return CGSize.zero
    }
}
