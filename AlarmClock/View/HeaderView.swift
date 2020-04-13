//
//  HeaderView.swift
//  AlarmClock
//
//  Created by Fai Wu on 3/19/20.
//  Copyright © 2020 Fai Wu. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    private func setup() {
        addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        backgroundColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
