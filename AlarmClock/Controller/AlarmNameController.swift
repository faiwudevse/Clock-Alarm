//
//  LabelController.swift
//  AlarmClock
//
//  Created by Fai Wu on 11/26/19.
//  Copyright © 2019 Fai Wu. All rights reserved.
//

import UIKit

protocol LabelControllerDelegate {
    func finishLabelName(label: String)
}

class AlarmNameViewController: UIViewController {
    
    var delegate: LabelControllerDelegate?
    
    let textField: UITextField = {
        let tx = UITextField()
        tx.translatesAutoresizingMaskIntoConstraints = false
        tx.backgroundColor = .red
        return tx
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(textField)
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        setNavigationController()
    }
    private func setNavigationController() {
        navigationItem.title = "Label"
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBackButton))
    }
    
    @objc private func handleBackButton() {
//        selectionArrary.sort()
        delegate?.finishLabelName(label: textField.text ?? "")
//        delegate?.didSelect(day: selectionArrary)
        navigationController?.popViewController(animated: true)
    }
    

}

extension AlarmNameViewController : UITextFieldDelegate {
    
}
