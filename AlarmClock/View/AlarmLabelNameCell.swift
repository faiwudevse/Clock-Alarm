//
//  AlarmLabelNameCell.swift
//  AlarmClock
//
//  Created by Fai Wu on 3/5/20.
//  Copyright © 2020 Fai Wu. All rights reserved.
//

import UIKit

protocol AlarmLabelNameDelegate {
    func didFinishLabelName( name: String)
}

class AlarmLabelNameCell: UITableViewCell, Cell{
    
    var delegate: AlarmLabelNameDelegate?
    
     var labelNameTextField: TextField = {
        let tf = TextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .line
        tf.returnKeyType = .done
        tf.textColor = .black
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(labelNameTextField)
        labelNameTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        labelNameTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        labelNameTextField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        labelNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        labelNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        labelNameTextField.delegate = self
        labelNameTextField.addTarget(self, action: #selector(currentText), for: .editingChanged)
        backgroundColor = #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
@objc private func currentText(_ sender: UITextField) {
         delegate?.didFinishLabelName(name: sender.text ?? "")
    }
    
}

extension AlarmLabelNameCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.didFinishLabelName(name: textField.text ?? "")
        return true
    }
}
