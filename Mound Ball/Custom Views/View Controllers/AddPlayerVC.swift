//
//  AddPlayerVC.swift
//  TableViewTestingSpacing
//
//  Created by Calvin Shultz on 4/2/20.
//  Copyright © 2020 Shultz. All rights reserved.
//

import UIKit

protocol AddPlayerDelegate: class {
    func addPlayerDelegate(player: Player)
    func editPlayerDelegate(player: Player)
}

class AddPlayerVC: UIViewController {
    
    var delegate: AddPlayerDelegate!
    
    let popupView = UIView()
    
    var playerToEdit: Player?
    
    let addPlayerLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Add Player"
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let playerTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter player name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textContentType = .name
        tf.textAlignment = .center
        tf.borderStyle = .line
        return tf
    }()
    
    let cancelButton = MBButton(title: "CANCEL", backgroundColor: #colorLiteral(red: 0.3285509944, green: 0.6433524489, blue: 1, alpha: 1))
    let addPlayerButton = MBButton(title: "ADD", backgroundColor: #colorLiteral(red: 0.3285509944, green: 0.6433524489, blue: 1, alpha: 1))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerTextField.delegate = self
        
        if let playerToEdit = playerToEdit {
            playerTextField.text = playerToEdit.name
            addPlayerButton.setTitle("DONE", for: .normal)
        } else {
            addPlayerButton.isEnabled = false
            addPlayerButton.alpha = 0.5
        }
        
        setupViews()
        setupLabelAndTextfield()
        setupButtons()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        playerTextField.becomeFirstResponder()
    }
    
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    
    @objc func addPlayerButtonPressed() {
        
        if let playerToEdit = playerToEdit {
            if let name = playerTextField.text {
                playerToEdit.name = name
                delegate.editPlayerDelegate(player: playerToEdit)
            }
            dismiss(animated: true)
        } else {
            guard let playerName = playerTextField.text else {
                return
            }
            delegate.addPlayerDelegate(player: Player(name: playerName))
            dismiss(animated: true)
        }
    }
    
    
    func setupViews() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40)
        
        view.addSubview(popupView)
        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupView.backgroundColor = #colorLiteral(red: 0.9525782466, green: 0.9605808854, blue: 0.9770829082, alpha: 1)
        popupView.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            popupView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            popupView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    
    func setupLabelAndTextfield() {
        
        popupView.addSubview(addPlayerLabel)
        popupView.addSubview(playerTextField)
        
        NSLayoutConstraint.activate([
            addPlayerLabel.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 10),
            addPlayerLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 10),
            addPlayerLabel.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -10),
            addPlayerLabel.heightAnchor.constraint(equalToConstant: 40),
            
            playerTextField.topAnchor.constraint(equalTo: addPlayerLabel.bottomAnchor, constant: 20),
            playerTextField.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 10),
            playerTextField.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -10),
            playerTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        
    }
    
    
    func setupButtons() {
        popupView.addSubview(cancelButton)
        popupView.addSubview(addPlayerButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        addPlayerButton.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        addPlayerButton.addTarget(self, action: #selector(addPlayerButtonPressed), for: .touchUpInside)
        
        
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 20),
            cancelButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -20),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            
            addPlayerButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -20),
            addPlayerButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -20),
            addPlayerButton.widthAnchor.constraint(equalToConstant: 100),
            addPlayerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


extension AddPlayerVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        playerTextField.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = playerTextField.text, let stringRange = Range(range, in: oldText) else {
            return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            addPlayerButton.isEnabled = false
            addPlayerButton.alpha = 0.5
        } else {
            addPlayerButton.isEnabled = true
            addPlayerButton.alpha = 1.0
        }
        return true
    }
    
}
