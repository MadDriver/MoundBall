//
//  AddPlayersMainVC.swift
//  Mound Ball
//
//  Created by Calvin Shultz on 4/6/20.
//  Copyright © 2020 Shultz. All rights reserved.
//

import UIKit

class AddPlayersMainVC: UIViewController {
    
    let addPlayerButton = MBButton()
    let startButton = MBButton(title: "START GAME", backgroundColor: #colorLiteral(red: 0.3285509944, green: 0.6433524489, blue: 1, alpha: 1))
    let playersTableView = PlayersTableView()
    var players = [Player]()
    
    let gradientLayer = CAGradientLayer()
    lazy var customNavBar: UIView = {
        let v =  UIView()
        gradientLayer.colors = [
            #colorLiteral(red: 0.3285509944, green: 0.6433524489, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.2535623014, green: 0.5533919334, blue: 0.8896663785, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        v.layer.addSublayer(gradientLayer)
        v.setupShadow(opacity: 0.5, radius: 8, offset: .init(width: 0, height: 5), color: #colorLiteral(red: 0.3285509944, green: 0.6433524489, blue: 1, alpha: 1))
        return v
    }()
    
    
    let moundBallLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "MOUND BALL"
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Rockwell-Bold", size: 35)
        return lbl
    }()
    
    let editButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Edit", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9525782466, green: 0.9605808854, blue: 0.9770829082, alpha: 1)
        configureTableView()
        configureButtons()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCustomNavBar()
        
    }
    
    
    func setupCustomNavBar() {
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 150))
        
        customNavBar.addSubview(moundBallLabel)
        moundBallLabel.anchor(top: nil, leading: customNavBar.leadingAnchor, bottom: customNavBar.bottomAnchor, trailing: customNavBar.trailingAnchor, size: .init(width: 0, height: 100))
        
        customNavBar.addSubview(editButton)
        editButton.anchor(top: nil, leading: nil, bottom: customNavBar.bottomAnchor, trailing: customNavBar.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 1, right: 12))
        editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        gradientLayer.frame = customNavBar.bounds
    }
    
    
    func configureTableView() {
        playersTableView.delegate   = self
        playersTableView.dataSource = self
        playersTableView.register(PlayersCell.self, forCellReuseIdentifier: PlayersCell.cellID)
        view.addSubview(playersTableView)
        
        NSLayoutConstraint.activate([
            playersTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            playersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            playersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            playersTableView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        
    }
    
    
    func configureButtons() {
        view.addSubview(addPlayerButton)
        view.addSubview(startButton)
        let plusImageSize               = UIImage.SymbolConfiguration(pointSize: 22, weight: .bold, scale: .large)
        let plusImage                   = UIImage(systemName: "plus", withConfiguration: plusImageSize)
        
        addPlayerButton.setImage(plusImage, for: .normal)
        addPlayerButton.backgroundColor = #colorLiteral(red: 1, green: 0.3715987206, blue: 0.3299833536, alpha: 1)
        addPlayerButton.tintColor       = .white
        addPlayerButton.addTarget(self, action: #selector(addPlayerButtonPressed), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        startButton.isEnabled = false
        startButton.alpha = 0.5
        
        NSLayoutConstraint.activate([
            addPlayerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            addPlayerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            addPlayerButton.widthAnchor.constraint(equalToConstant: 70),
            addPlayerButton.heightAnchor.constraint(equalToConstant: 70),
            
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            startButton.trailingAnchor.constraint(equalTo: addPlayerButton.leadingAnchor, constant: -20),
            startButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
        
        
    @objc func addPlayerButtonPressed() {
        let vc = AddPlayerVC()
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    
    @objc func editButtonPressed() {
        playersTableView.isEditing.toggle()
        if playersTableView.isEditing {
            self.editButton.setTitle("Done", for: .normal)
        } else {
            self.editButton.setTitle("Edit", for: .normal)
        }
    }
    
    @objc func startButtonPressed() {
        let vc = MainGameVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.players = players
        present(vc, animated: true)
    }
    
    func scrollToLastPlayerAdded() {
        let indexPath = IndexPath(row: players.count - 1, section: 0)
        playersTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

}

extension AddPlayersMainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if players.count == 0 {
            self.playersTableView.setEmptyMessage("Add Players")
        } else {
            self.playersTableView.restore()
        }
        
        if players.count > 1 {
            startButton.isEnabled = true
            startButton.alpha = 1.0
        }
        
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayersCell.cellID, for: indexPath) as! PlayersCell
        cell.setupCell(player: players[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let headerTitle: UILabel = {
            let lbl = UILabel()
            lbl.text = "Players"
            lbl.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            lbl.translatesAutoresizingMaskIntoConstraints = true
            return lbl
        }()
        
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9525782466, green: 0.9605808854, blue: 0.9770829082, alpha: 1)
        view.addSubview(headerTitle)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: view.topAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerTitle.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        return view
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)

            if players.count < 2 {
                startButton.isEnabled = false
                startButton.alpha = 0.5
            }
        }
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = players[indexPath.row]
        let vc = AddPlayerVC()
        vc.playerToEdit = player
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        playersTableView.setEditing(playersTableView.isEditing, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let player = players[sourceIndexPath.row]
        players.remove(at: sourceIndexPath.row)
        players.insert(player, at: destinationIndexPath.row)
    }
    
    // Changes background color of delete and row moving symbols in edit mode
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = #colorLiteral(red: 0.9525782466, green: 0.9605808854, blue: 0.9770829082, alpha: 1)
    }

}

extension AddPlayersMainVC: AddPlayerDelegate {
    func editPlayerDelegate(player: Player) {
        if let index = players.firstIndex(of: player) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = self.playersTableView.cellForRow(at: indexPath) as? PlayersCell {
                let name = player.name
                players[indexPath.row].name = name
                cell.playerName.text = name
                self.playersTableView.reloadData()
            }
        }
    }
    
    
    func addPlayerDelegate(player: Player) {
        players.append(player)
        
        if players.count > 1 {
            startButton.isEnabled = true
            startButton.alpha = 1.0
        }
        
        self.playersTableView.reloadData()
        scrollToLastPlayerAdded()
    }
    
}
