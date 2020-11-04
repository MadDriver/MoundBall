//
//  MainGameVC.swift
//  TableViewTestingSpacing
//
//  Created by Calvin Shultz on 4/2/20.
//  Copyright © 2020 Shultz. All rights reserved.
//

import UIKit

class MainGameVC: UIViewController {
    
    var currentInningIndex = 0
    var currentPlayerIndex = 0
    let cellId = "cellId"
    var scoreTracker = [Int]()
    var yesWasPressed = false
    
    var amountAvailableToWin = 0
    let amountView = MBAmountView()
    let titleView = MBTitleView()
    let ballOnMoundButton = MBButton(title: "YES", backgroundColor: #colorLiteral(red: 0.1746941805, green: 0.6476135254, blue: 1, alpha: 1))
    let ballNotOnMoundButton = MBButton(title: "NO", backgroundColor: #colorLiteral(red: 0.1746941805, green: 0.6476135254, blue: 1, alpha: 1))
    let skipButton = MBButton(title: "SKIP", backgroundColor: #colorLiteral(red: 0.9525782466, green: 0.9605808854, blue: 0.9770829082, alpha: 1))
    let backButton = MBButton(title: "BACK", backgroundColor: #colorLiteral(red: 0.9525782466, green: 0.9605808854, blue: 0.9770829082, alpha: 1))
    let inningLabel = MBLabel()
    
    var players = [Player]()
    var gameOver = false
    let playersTableView = PlayersTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTableView()
        setupAmountView()
        setupButtons()
    }

    
    func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.9525782466, green: 0.9605808854, blue: 0.9770829082, alpha: 1)
        view.addSubview(titleView)
        titleView.addSubview(inningLabel)
        titleView.incrementInningLabel(currentInningIndex)
            
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 150)
            ])
    }
    
    
    func setupTableView() {
        view.addSubview(playersTableView)
        playersTableView.register(PlayerGameCell.self, forCellReuseIdentifier: cellId)
        playersTableView.delegate = self
        playersTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            playersTableView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20),
            playersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            playersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            playersTableView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    
    func setupAmountView() {
        view.addSubview(amountView)
        let amountViewSize: CGFloat = 100
        amountView.layer.cornerRadius = amountViewSize / 2
        amountAvailableToWin = players.count
        amountView.updateAmount(amount: amountAvailableToWin)
        
        NSLayoutConstraint.activate([
            amountView.topAnchor.constraint(equalTo: playersTableView.bottomAnchor, constant: 20),
            amountView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountView.widthAnchor.constraint(equalToConstant: amountViewSize),
            amountView.heightAnchor.constraint(equalToConstant: amountViewSize)
        ])
    }
    
    
    func setupButtons() {
        view.addSubview(ballOnMoundButton)
        view.addSubview(ballNotOnMoundButton)
        view.addSubview(backButton)
        view.addSubview(skipButton)
            
        backButton.layer.borderWidth = 2
        backButton.layer.borderColor = #colorLiteral(red: 0.1746941805, green: 0.6476135254, blue: 1, alpha: 1)
        backButton.setTitleColor(#colorLiteral(red: 0.1746941805, green: 0.6476135254, blue: 1, alpha: 1), for: .normal)
        backButton.isEnabled = false
        backButton.alpha = 0.5
        
        skipButton.layer.borderWidth = 2
        skipButton.layer.borderColor = #colorLiteral(red: 0.1746941805, green: 0.6476135254, blue: 1, alpha: 1)
        skipButton.setTitleColor(#colorLiteral(red: 0.1746941805, green: 0.6476135254, blue: 1, alpha: 1), for: .normal)

        ballOnMoundButton.addTarget(self, action: #selector(yesButtonPressed), for: .touchUpInside)
        ballNotOnMoundButton.addTarget(self, action: #selector(noButtonPressed), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
                
        ballOnMoundButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        ballOnMoundButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        ballNotOnMoundButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        ballNotOnMoundButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        skipButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let buttonStackView = UIStackView(arrangedSubviews: [
            ballNotOnMoundButton, ballOnMoundButton
        ])
        
        let secondaryButtonStackView = UIStackView(arrangedSubviews: [
            backButton, skipButton
        ])
        
        view.addSubview(buttonStackView)
        view.addSubview(secondaryButtonStackView)
        buttonStackView.distribution = .equalCentering
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        secondaryButtonStackView.distribution = .equalCentering
        secondaryButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: amountView.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            
            secondaryButtonStackView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 20),
            secondaryButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            secondaryButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            secondaryButtonStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func scoreTrackerIncrement() {
        scoreTracker.append(amountAvailableToWin)
    }
    
    
    @objc func yesButtonPressed() {
        scoreTrackerIncrement()
        if currentInningIndex < 17 {
            players[currentPlayerIndex].score += amountAvailableToWin
            amountAvailableToWin = players.count
            amountView.updateAmount(amount: amountAvailableToWin)
            playersTableView.reloadData()
            currentInningIndex += 1
            titleView.incrementInningLabel(currentInningIndex)
            if currentPlayerIndex < players.count - 1 {
                currentPlayerIndex += 1
            } else {
                currentPlayerIndex = 0
            }
        } else {
            gameOver = true
            players[currentPlayerIndex].score += amountAvailableToWin
            playersTableView.reloadData()
            ballOnMoundButton.isEnabled = false
            ballNotOnMoundButton.isEnabled = false
            ballOnMoundButton.alpha = 0.5
            ballNotOnMoundButton.alpha = 0.5
            playersTableView.reloadData()
            currentInningIndex += 1
            titleView.incrementInningLabel(currentInningIndex)
            backButton.isEnabled = false
            backButton.alpha = 0.5
            skipButton.isEnabled = false
            skipButton.alpha = 0.5

        }
        
        backButton.isEnabled = true
        backButton.alpha = 1.0
        yesWasPressed = true
        let indexPath = IndexPath(row: currentPlayerIndex, section: 0)
        playersTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    
    
    @objc func noButtonPressed() {
        scoreTrackerIncrement()
        if currentInningIndex < 17 {
            amountAvailableToWin += players.count
            amountView.updateAmount(amount: amountAvailableToWin)
            playersTableView.reloadData()
            currentInningIndex += 1
            titleView.incrementInningLabel(currentInningIndex)
            
            if currentPlayerIndex < players.count - 1 {
                currentPlayerIndex += 1
            } else {
                currentPlayerIndex = 0
            }
        } else {
            gameOver = true
            ballOnMoundButton.isEnabled = false
            ballNotOnMoundButton.isEnabled = false
            ballOnMoundButton.alpha = 0.5
            ballNotOnMoundButton.alpha = 0.5
            playersTableView.reloadData()
            currentInningIndex += 1
            titleView.incrementInningLabel(currentInningIndex)
            backButton.isEnabled = false
            backButton.alpha = 0.5
            skipButton.isEnabled = false
            skipButton.alpha = 0.5
        }
        
        let indexPath = IndexPath(row: currentPlayerIndex, section: 0)
        playersTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        yesWasPressed = false
    }
    
    
    @objc func backButtonPressed() {
        
        if yesWasPressed {
            let lastScore = scoreTracker.last ?? 0
            
            if currentPlayerIndex == 0 {
                let lastPlayerIndex = players.count - 1
                players[lastPlayerIndex].score = players[lastPlayerIndex].score - lastScore
            } else {
                let lastPlayerIndex = currentPlayerIndex - 1
                players[lastPlayerIndex].score = players[lastPlayerIndex].score - lastScore
            }
            
            amountView.updateAmount(amount: lastScore)
            amountAvailableToWin = lastScore
            scoreTracker.removeLast()
        } else {
            let lastScore = scoreTracker.last ?? 0
            amountView.updateAmount(amount: lastScore)
            amountAvailableToWin = lastScore
        }
        
        if currentPlayerIndex == 0 {
            currentPlayerIndex = players.count - 1
        } else {
            currentPlayerIndex -= 1
        }
        
        playersTableView.reloadData()
        backButton.isEnabled = false
        backButton.alpha = 0.5
        print(scoreTracker)
    }
    
    
    @objc func skipButtonPressed() {
        if currentPlayerIndex < players.count - 1 {
            currentPlayerIndex += 1
        } else {
            currentPlayerIndex = 0
        }
        playersTableView.reloadData()
    }
}


extension MainGameVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let currentPlayerCellColor: UIColor = #colorLiteral(red: 0.1898635785, green: 0.7348599285, blue: 1, alpha: 1)
        let defaultPlayerCellColor = #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PlayerGameCell
        let player = players[indexPath.row]
        
        if currentPlayerIndex == indexPath.row {
            if gameOver == false {
                cell.setup(name: player.name, score: player.score, backgroundColor: currentPlayerCellColor)
            } else {
                cell.setup(name: player.name, score: player.score, backgroundColor: defaultPlayerCellColor)
            }
        } else {
            cell.setup(name: player.name, score: player.score, backgroundColor: defaultPlayerCellColor)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }

}
