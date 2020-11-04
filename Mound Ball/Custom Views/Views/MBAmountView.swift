//
//  MBAmountView.swift
//  TableViewTestingSpacing
//
//  Created by Calvin Shultz on 4/3/20.
//  Copyright © 2020 Shultz. All rights reserved.
//

import UIKit

class MBAmountView: UIView {
    
    let amountLabel = MBLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(amount: Int) {
        super.init(frame: .zero)
        amountLabel.text = String(amount)
        configure()
    }
    
    
    private func configure() {
        backgroundColor = #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1)
        addSubview(amountLabel)
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            amountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            amountLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            amountLabel.widthAnchor.constraint(equalToConstant: 50),
            amountLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func updateAmount(amount: Int) {
        let amountToUpdate = String(amount)
        amountLabel.text = "$\(amountToUpdate)"
    }
    
}
