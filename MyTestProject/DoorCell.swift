//
//  DoorCell.swift
//  MyTestProject
//
//  Created by Oleksandr Smakhtin on 11.09.2022.
//

import UIKit

class DoorCell: UITableViewCell {

    
    
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContentView() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = #colorLiteral(red: 0.8887098432, green: 0.91862005, blue: 0.9181008935, alpha: 1)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        // constraints
        
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
    }

    
    

    
}
