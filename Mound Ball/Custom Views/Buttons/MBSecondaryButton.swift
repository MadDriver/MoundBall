//
//  MBSecondaryButton.swift
//  TableViewTestingSpacing
//
//  Created by Calvin Shultz on 4/5/20.
//  Copyright © 2020 Shultz. All rights reserved.
//

import UIKit

class MBSecondaryButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 15
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
