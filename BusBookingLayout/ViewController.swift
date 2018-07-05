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
    var selectedSeatNumber = [Int: Bool]()
    var pathWayNumber = Int()
    var seatNumer = Int()
    var skipSeatNumber = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pathWayNumber = 0 // CENTER - PASSENGER CAN WALK
        seatNumer = 1  // STARTING NUMBER
        for i in 0...63
        {
            if i == pathWayNumber // If it s centre, values empty to dictionary
            {
                busSeatNumDict[i] = ""
                if skipSeatNumber == 2 {
                    pathWayNumber = pathWayNumber + skipSeatNumber
                    skipSeatNumber = 3
                }else {
                    pathWayNumber = pathWayNumber + skipSeatNumber
                    skipSeatNumber = 2
                }
            }else if i%6 == 0 {
                busSeatNumDict[i] = ""
                pathWayNumber = pathWayNumber + 1
            }
            else
            {
                busSeatNumDict[i] = String(seatNumer)
                seatNumer = seatNumer + 1
            }
            
            selectedSeatNumber[i] = false
        }
        
        selectedSeatLbl.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func proceedBtnTapped(_ sender: UIButton) {
    }
}

//MARK:- UICollectionViewDelegate and UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if seatCollectionView == collectionView {
            return 64
        }
        return seatInfoDict.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if seatCollectionView == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "SeatsCell", for: indexPath) as! SeatCollectionViewCell
            
            cell.alpha = 0 // Initially alpha 0
            let text = busSeatNumDict[indexPath.row]!
            
            if text == "" || text == "31"
            {
                cell.alpha = 0
            }
            else
            {
                cell.alpha = 1
            }
            cell.backgroundColor = UIColor.clear
            
            let isSeatSelected = selectedSeatNumber[indexPath.row]
            
            if isSeatSelected! {
                cell.sleeperSeatView.backgroundColor = UIColor.green
            }else {
                cell.sleeperSeatView.backgroundColor = UIColor.white
            }
            
            cell.layer.borderColor = UIColor.green.cgColor
            cell.layer.borderWidth = 1.0
            cell.seatNumberLbl.text = text
            cell.seatNumberLbl.textAlignment = .center
            cell.seatNumberLbl.textColor = UIColor.darkGray
            //cell.layer.cornerRadius = 5
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "SeatInfoCell", for: indexPath) as! SeatInfoCollectionViewCell
            let infoArray = seatInfoDict[indexPath.row]
            cell.nameLbl.text = infoArray[0] as? String
            cell.colorView.backgroundColor = infoArray[1] as? UIColor
            
            if indexPath.row > 3 {
                cell.colorView.backgroundColor = UIColor.white
                let color = infoArray[1] as? UIColor
                cell.colorView.layer.borderColor =  color?.cgColor
                cell.colorView.layer.borderWidth = 1
                if indexPath.row == 5 {
                    cell.squareWidthContraint.constant = 30
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if seatCollectionView == collectionView {
            let cellWidht = (seatCollectionView.bounds.width - 50)/6
            
            if indexPath.row > 60
            {
                let text = busSeatNumDict[indexPath.row]!
                if text == "32" {
                    return CGSize(width: (cellWidht * 2)+10, height: cellWidht)
                }
                //return CGSize(width: cellWidht, height: cellWidht)
                return CGSize(width: cellWidht, height: cellWidht * 2)
            }
            return CGSize(width: cellWidht, height: cellWidht * 2)
        }
        
        //For info seat collection view
        if indexPath.row == 1 ||  indexPath.row == 3 {
            return CGSize(width: 60, height: 50)
        }
        
        if indexPath.row == 4 {
            return CGSize(width: 70, height: 50)
        }
        
        if indexPath.row == 5 {
            return CGSize(width: 100, height: 50)
        }
        
        return CGSize(width: 75, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select Row- \(indexPath.row)")
        let cell = collectionView.cellForItem(at: indexPath) as? SeatCollectionViewCell
        let isSeatSelected = selectedSeatNumber[indexPath.row]
        if isSeatSelected! {
            cell?.sleeperSeatView.backgroundColor = UIColor.white
            selectedSeatNumber[indexPath.row] = false
        
            if (selectedSeatLbl.text?.contains(busSeatNumDict[indexPath.row]! + ", "))! {
                selectedSeatLbl.text = selectedSeatLbl.text?.replacingOccurrences(of: (busSeatNumDict[indexPath.row]! + ", "), with: "")
            }else if (selectedSeatLbl.text?.contains(", " + busSeatNumDict[indexPath.row]!))! {
                selectedSeatLbl.text = selectedSeatLbl.text?.replacingOccurrences(of: (", " + busSeatNumDict[indexPath.row]!), with: "")
            }else {
                selectedSeatLbl.text = ""
            }
        }else {
            cell?.sleeperSeatView.backgroundColor = UIColor.green
            selectedSeatNumber[indexPath.row] = true
            
            if selectedSeatLbl.text == "" {
                selectedSeatLbl.text = busSeatNumDict[indexPath.row]
            }else {
                selectedSeatLbl.text = busSeatNumDict[indexPath.row]! + ", " + selectedSeatLbl.text!
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("Deselect Row- \(indexPath.row)")
        //let cell = collectionView.cellForItem(at: indexPath) as? SeatCollectionViewCell
        //cell?.backgroundColor = UIColor.clear
    }
}

//MARK:- String Extension
extension String
{
    func contains(_ find: String) -> Bool{
        return self.range(of: find) != nil
    }
}
