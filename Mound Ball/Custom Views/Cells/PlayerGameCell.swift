//
//  PlayerGameCell.swift
//  TableViewTestingSpacing
//
//  Created by Calvin Shultz on 4/3/20.
//  Copyright © 2020 Shultz. All rights reserved.
//

import UIKit

class PlayerGameCell: UITableViewCell {
    
    let nameLabel   = MBLabel()
    let scoreLabel  = MBLabel()
    
    let cellViewPadding: CGFloat = 8
    
    let cellView: UIView = {
        let view                = UIView()
        view.backgroundColor    = #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        contentView.backgroundColor = #colorLiteral(red: 0.9525782466, green: 0.9605808854, blue: 0.9770829082, alpha: 1)
        
        contentView.addSubview(cellView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: cellViewPadding),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: cellViewPadding),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -cellViewPadding),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -cellViewPadding),
            
            nameLabel.topAnchor.constraint(equalTo: cellView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            nameLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: cellView.topAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 20),
            scoreLabel.widthAnchor.constraint(equalToConstant: 50),
            scoreLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor)
        ])
        
    }
    
    
    func setup(name: String, score: Int, backgroundColor: UIColor) {
        
        let scoreString = String(score)
        nameLabel.text  = name
        scoreLabel.text = "$\(scoreString)"
        cellView.backgroundColor = backgroundColor
        
    }
    
}
