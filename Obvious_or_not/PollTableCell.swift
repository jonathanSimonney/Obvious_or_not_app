//
//  PollTableCell.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 23/11/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import Foundation
import UIKit

class PollTableCell: UITableViewCell{
    func prepareView(title: String){
        let cellTitle = UILabel()
        cellTitle.text = title
        self.contentView.addSubviewGrid(cellTitle, grid: [1, 0, 12, 1], collNumber: 12, rowNumber: 1)
    }
}
