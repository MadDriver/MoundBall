//
//  MBView.swift
//  TableViewTestingSpacing
//
//  Created by Calvin Shultz on 4/2/20.
//  Copyright © 2020 Shultz. All rights reserved.
//

import UIKit

class MBView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1)
        layer.cornerRadius = 15
        translatesAutoresizingMaskIntoConstraints = false
    }

}
