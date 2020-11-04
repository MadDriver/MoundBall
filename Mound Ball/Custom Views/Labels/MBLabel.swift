//
//  MBLabel.swift
//  TableViewTestingSpacing
//
//  Created by Calvin Shultz on 4/2/20.
//  Copyright © 2020 Shultz. All rights reserved.
//

import UIKit

class MBLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "Rockwell-Bold", size: 20)
        clipsToBounds = true
        textAlignment = .center
    }
    
}
