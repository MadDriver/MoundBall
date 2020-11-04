//
//  MBButton.swift
//  Mound Ball
//
//  Created by Calvin Shultz on 4/16/20.
//  Copyright © 2020 Shultz. All rights reserved.
//

import UIKit

class MBButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    func configure() {
        layer.cornerRadius = 15
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
