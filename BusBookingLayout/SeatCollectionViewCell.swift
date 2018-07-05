//
//  SeatCollectionViewCell.swift
//  BusBookingLayout
//
//  Created by Nilesh's MAC on 7/5/18.
//  Copyright © 2018 Nilesh's MAC. All rights reserved.
//

import UIKit

class SeatCollectionViewCell: UICollectionViewCell {
    @IBOutlet var sleeperSeatView: UIView!
    @IBOutlet var seatNumberLbl: UILabel!
    
    var isSeatSelected: Bool? = false
    
}
