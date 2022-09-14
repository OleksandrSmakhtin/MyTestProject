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
    let stackView = UIStackView()
    
    var doors = [Door]()
    var firstLoad = true
    var apiManager = ApiManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fetch request imitation
        DispatchQueue.main.async {
            self.apiManager.fetchDoors()
        }
        apiManager.delegate = self
        
        setView()
        configureTableView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.firstLoad = false
            self.tableView.reloadData()
            self.tableView.allowsSelection = true
        }
    }
}

//MARK: - ApiManagerDelegate
extension MainVC: ApiManagerDelegate {
    func didLoadDoors(_ apiManager: ApiManager, doors: [Door]) {
        DispatchQueue.main.async {
            self.doors = doors
            print(doors)
        }
    }
}



//MARK: - Set TableView
extension MainVC {
    func configureTableView() {
        view.addSubview(tableView)
        // set delegates
        setTableViewDelegates()
        // register cell
        tableView.register(DoorCell.self, forCellReuseIdentifier: "DoorCell")
        tableView.register(LoadingDoorCell.self, forCellReuseIdentifier: "LoadingCell")
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
    // delegates
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}


//MARK: - TableView Delegate & DataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DoorData.instance.getDoors().count
    }
    
    // set cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if firstLoad {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingDoorCell
            tableView.allowsSelection = false
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoorCell", for: indexPath) as! DoorCell
            cell.delegate = self
            let door = doors[indexPath.row]
            
            if door.status == K.DoorStatus.unlocking {
                    cell.unlockingDoor()
                    tableView.allowsSelection = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        cell.unlockDoor()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            cell.lockDoor()
                            tableView.allowsSelection = true
                        }
                    }
            }
            self.doors[indexPath.row].status = K.DoorStatus.locked
            cell.configureCell(door: door)
            return cell
        }
    }
    
    
    // select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        doors[indexPath.row].status = K.DoorStatus.unlocking
        tableView.reloadData()
    }
    
    
}

//MARK: - Change Status Delegate
extension MainVC: StatusButtonDelegate {
    func changeStatus(cell: DoorCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        doors[indexPath.row].status = K.DoorStatus.unlocking
        tableView.reloadData()
        print(indexPath.row)
    }
    
}


//MARK: - Set UI
extension MainVC {
    func setView() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
}
