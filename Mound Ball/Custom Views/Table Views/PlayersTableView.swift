//
//  PlayersTableView.swift
//  TableViewTestingSpacing
//
//  Created by Calvin Shultz on 4/2/20.
//  Copyright © 2020 Shultz. All rights reserved.
//

import UIKit

class PlayersTableView: UITableView {
        
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        backgroundColor = #colorLiteral(red: 0.9525782466, green: 0.9605808854, blue: 0.9770829082, alpha: 1)
        separatorStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
