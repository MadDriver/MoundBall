//
//  MBTitleView.swift
//  TableViewTestingSpacing
//
//  Created by Calvin Shultz on 4/3/20.
//  Copyright © 2020 Shultz. All rights reserved.
//

import UIKit

class MBTitleView: UIView {
    
    let titleLabel = MBLabel()
    let inningLabel = MBLabel()
    
    let innings: [String] = [
        "Top 1st", "Bottom 1st", "Top 2nd", "Bottom 2nd", "Top 3rd", "Bottom 3rd", "Top 4th", "Bottom 4th", "Top 5th", "Bottom 5th", "Top 6th", "Bottom 6th", "Top 7th", "Bottom 7th", "Top 8th", "Bottom 8th", "Top 9th", "Bottom 9th", "GAME OVER"
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1)
        
        addSubview(titleLabel)
        addSubview(inningLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "MOUND BALL"
        titleLabel.font = UIFont(name: "Rockwell-Bold", size: 25)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 100),
            
            inningLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -30),
            inningLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            inningLabel.widthAnchor.constraint(equalToConstant: 200),
            inningLabel.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
    
    
    func incrementInningLabel(_ currentInningIndex: Int) {
        inningLabel.text = innings[currentInningIndex]
    }
    
}
