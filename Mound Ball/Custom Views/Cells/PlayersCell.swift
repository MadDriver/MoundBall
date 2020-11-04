//
//  PlayersCell.swift
//  TableViewTestingSpacing
//
//  Created by Calvin Shultz on 4/1/20.
//  Copyright © 2020 Shultz. All rights reserved.
//

import UIKit

class PlayersCell: UITableViewCell {
    
    static let cellID = "CellID"
    let cellViewPadding: CGFloat = 8
    
    let cellView: UIView        = {
        let view                = UIView()
        view.backgroundColor    = #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let playerName = MBLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupCellViews() {
        contentView.backgroundColor = #colorLiteral(red: 0.9525782466, green: 0.9605808854, blue: 0.9770829082, alpha: 1)
        contentView.addSubview(cellView)
        cellView.addSubview(playerName)
        
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: cellViewPadding),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: cellViewPadding),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -cellViewPadding),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -cellViewPadding),
            
            playerName.topAnchor.constraint(equalTo: cellView.topAnchor),
            playerName.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            playerName.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            playerName.bottomAnchor.constraint(equalTo: cellView.bottomAnchor)
        ])
    }
    
    
    func setupCell(player: Player) {
        
        playerName.text = player.name
        playerName.textAlignment = .center
        playerName.font = UIFont.boldSystemFont(ofSize: 20)
        
    }
}
