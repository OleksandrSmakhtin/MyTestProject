//
//  MainVC.swift
//  MyTestProject
//
//  Created by Oleksandr Smakhtin on 10.09.2022.
//
import SnapKit
import UIKit

class MainVC: UIViewController {

    
    let tableView = UITableView()
    var doors = DoorData.instance.getDoors()
    var chosenRow: Int?
    var status = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setView()
        configureTableView()
    }
    
    let stackView = UIStackView()
    
    func setView() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(77.3)
            make.right.equalToSuperview().inset(27.0)
            make.left.equalToSuperview().inset(24.0)
        }
        
        
        
        // Logo and setting stack
        let logoAndSettingStack = UIStackView()
        view.addSubview(logoAndSettingStack)
        logoAndSettingStack.axis = .horizontal
        logoAndSettingStack.distribution = .equalSpacing
        stackView.addArrangedSubview(logoAndSettingStack)
        
        
        
        // Logo
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "interQR")
        logoImageView.contentMode = .scaleAspectFit
        logoAndSettingStack.addArrangedSubview(logoImageView)

        
        // Setting Btn
        let settingBtn = UIButton()
        settingBtn.setImage(UIImage(named: "Setting"), for: .normal)
        logoAndSettingStack.addArrangedSubview(settingBtn)

        
        
        
        // Welcome and Home StackView
        let welcomeAndHomeStack = UIStackView()
        view.addSubview(welcomeAndHomeStack)
        welcomeAndHomeStack.axis = .horizontal
        welcomeAndHomeStack.distribution = .equalSpacing
        welcomeAndHomeStack.spacing = 50
        stackView.addArrangedSubview(welcomeAndHomeStack)
        
        
        // Welcome Lbl
        let welcomeLbl = UILabel()
        welcomeLbl.text = "Welcome"
        welcomeLbl.font = UIFont.systemFont(ofSize: 34, weight: .medium)
        welcomeAndHomeStack.addArrangedSubview(welcomeLbl)
        
        // Home image
        let homeImageView = UIImageView()
        homeImageView.image = UIImage(named: "Home")
        homeImageView.contentMode = .scaleAspectFill
        welcomeAndHomeStack.addArrangedSubview(homeImageView)
        
        
    }
    
    
    
    func configureTableView() {
        view.addSubview(tableView)
        // set delegates
        setTableViewDelegates()
        // register cell
        tableView.register(DoorCell.self, forCellReuseIdentifier: "DoorCell")
        // settings
           // disable separator
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
           // disable scroll indicator
        tableView.showsVerticalScrollIndicator = false
           // set row height
        tableView.rowHeight = 131
        // set constrains
        tableView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(15)
            make.left.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
            make.top.equalTo(stackView.snp_bottomMargin).offset(84)
        }
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    


}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DoorData.instance.getDoors().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoorCell", for: indexPath) as! DoorCell
        
        let door = doors[indexPath.row]
//        if door.status == K.DoorStatus.unlocking{
//            cell.updatingCell()
//        }
        
        if door.status == K.DoorStatus.unlocking {
           // if row == indexPath.row {
                cell.updatingCell()
                tableView.allowsSelection = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    cell.updatedCell()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        cell.lockedCell()
                        
                        tableView.allowsSelection = true
                    }
                }
           // }
        }
        self.doors[indexPath.row].status = K.DoorStatus.locked
        cell.configureCell(door: door)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cell = tableView.cellForRow(at: indexPath) as! DoorCell
        
        //cell.updatingCell()
        
        //cell.updatedCell()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            cell.updatingCell()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//               cell.updatedCell()
//            }
        //}
        
        //doors[indexPath.row].status = K.DoorStatus.unlocking
        //print(indexPath.row)
    
    
    
        //chosenRow = indexPath.row
        //print(chosenRow)
        doors[indexPath.row].status = K.DoorStatus.unlocking
    
        tableView.reloadData()
                
    }
    
    
}
