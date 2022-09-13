//
//  DoorCell.swift
//  MyTestProject
//
//  Created by Oleksandr Smakhtin on 11.09.2022.
//

import UIKit

class DoorCell: UITableViewCell {

    
    let titleLbl = UILabel()
    let positionLbl = UILabel()
    let statusBtn = UIButton()
    let shieldImage = UIImageView()
    let doorImage = UIImageView()
    
    let unlockingShield = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // disable selection
        self.selectionStyle = .none
        configureContentView()
        

        
        configureTitleLbl()
        configurePositionLbl()
        configureStatusBtn()
        configureShieldImage()
        configureDoorImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func threeDotsAnim(animate: Bool) {
        let lay = CAReplicatorLayer()
        lay.frame = CGRect(x: 8, y: 18, width: 15, height: 7) //yPos == 12
        let circle = CALayer()
        circle.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        circle.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor.white.cgColor// UIColor(red: 110/255.0, green: 110/255.0, blue: 110/255.0, alpha: 1).cgColor//lightGray.cgColor //UIColor.black.cgColor
        lay.addSublayer(circle)
        lay.instanceCount = 3
        lay.instanceTransform = CATransform3DMakeTranslation(10, 0, 0)
        let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        anim.fromValue = 1.0
        anim.toValue = 0.2
        anim.duration = 1
        anim.repeatCount = .infinity
        circle.add(anim, forKey: nil)
        lay.instanceDelay = anim.duration / Double(lay.instanceCount)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            lay.removeFromSuperlayer()
        }
        shieldImage.layer.addSublayer(lay)
        //lay.position.equalTo(center)
        }
    
    
//MARK: - Set cell
    func configureCell(door: Door) {
        //if door.status == K.DoorStatus.unlocking {
        //    updatingCell()
        //}
        
        
//        if door.status == K.DoorStatus.unlocking {
//            titleLbl.text = door.title
//            positionLbl.text = door.position
//            statusBtn.setTitle(door.status, for: .normal)
//        } else {
            titleLbl.text = door.title
            positionLbl.text = door.position
            statusBtn.setTitle(door.status, for: .normal)
        //}
        
    }
    
    func updatingCell() {
        
        shieldImage.image = UIImage(named: K.StatusImagesNames.shieldUnlocking)
        statusBtn.setTitleColor(#colorLiteral(red: 0.8313726783, green: 0.8313726187, blue: 0.8313726187, alpha: 1), for: .normal)
        
        threeDotsAnim(animate: true)
    }
    
    func updatedCell() {
        shieldImage.layer.removeAllAnimations()
        shieldImage.image = UIImage(named: K.StatusImagesNames.shieldUnlocked)
        statusBtn.setTitleColor(#colorLiteral(red: 0.5039272904, green: 0.6311599612, blue: 0.7736265063, alpha: 1), for: .normal)
        statusBtn.setTitle("Unlocked", for: .normal)
       
        
        
    }
    
    func lockedCell() {
        shieldImage.image = UIImage(named: K.StatusImagesNames.shieldLocked)
        doorImage.image = UIImage(named: K.StatusImagesNames.doorLocked)
        statusBtn.setTitleColor(#colorLiteral(red: 0.0002588513307, green: 0.2672565579, blue: 0.544146657, alpha: 1), for: .normal)
        statusBtn.setTitle("Locked", for: .normal)
    }
    
    
    
    
//MARK: - Set UI
    // set door image
    func configureDoorImage() {
        contentView.addSubview(doorImage)
        doorImage.image = UIImage(named: K.StatusImagesNames.doorLocked)
        doorImage.clipsToBounds = true
        doorImage.contentMode = .scaleAspectFill
    }

    // set shield image
    func configureShieldImage() {
        contentView.addSubview(shieldImage)
        shieldImage.image = UIImage(named: K.StatusImagesNames.shieldLocked)
        shieldImage.clipsToBounds = true
        shieldImage.contentMode = .scaleAspectFill
    }

    // set status button
    func configureStatusBtn() {
        contentView.addSubview(statusBtn)
        statusBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        statusBtn.setTitleColor(#colorLiteral(red: 0.0002588513307, green: 0.2672565579, blue: 0.544146657, alpha: 1), for: .normal)
        statusBtn.titleLabel?.textColor = #colorLiteral(red: 0.0002588513307, green: 0.2672565579, blue: 0.544146657, alpha: 1)
    }

    // set position label
    func configurePositionLbl() {
        contentView.addSubview(positionLbl)
        positionLbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        positionLbl.textColor = #colorLiteral(red: 0.725490272, green: 0.7254902124, blue: 0.725490272, alpha: 1)
    }

    // set title label
    func configureTitleLbl() {
        contentView.addSubview(titleLbl)
        titleLbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLbl.textColor = #colorLiteral(red: 0.1962750554, green: 0.2163220048, blue: 0.334228158, alpha: 1)
    }
    
    // set contentView
    func configureContentView() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = #colorLiteral(red: 0.8887098432, green: 0.91862005, blue: 0.9181008935, alpha: 1)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
    }
    
//MARK: - Set constraints
    // set constraints
    override func layoutSubviews() {
            super.layoutSubviews()
        // for content view
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
        
        // for shield image
        shieldImage.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(27)
                    make.top.equalToSuperview().offset(18)
                }
        
        // for door image
        doorImage.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(18)
                    make.trailing.equalToSuperview().offset(-28)
                }
        
        // for title label
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(22)
            make.left.equalTo(shieldImage).offset(55)
        }
        
        // for position label
        positionLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp_bottomMargin).offset(8)
            make.left.equalTo(shieldImage).offset(55)
        }
        
        // for status button
        statusBtn.snp.makeConstraints { make in
                    make.bottom.equalTo(contentView).offset(-14)
                    make.centerX.equalTo(contentView)
                }
    }

    
    

    
}