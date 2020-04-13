//
//  AcknowledgmentViewController.swift
//  AlarmClock
//
//  Created by Fai Wu on 1/5/20.
//  Copyright © 2020 Fai Wu. All rights reserved.
//

import UIKit

class AcknowledgementViewController: UIViewController {
    
    private let theySaidSoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "This app uses https://theysaidso.com API to get the inspirational quote of the day."
        return label
    }()
    
    private let flaticonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Permission Icon is made by Freepik https://www.flaticon.com/authors/freepik from www.flaticon.com."
        label.numberOfLines = 0
        return label
    }()
    
    private let icon8Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "App Icon is made by Clock Icon https://icons8.com/icons/set/clock from  https://icons8.com."
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1083748862, green: 0.1081092134, blue: 0.1190437749, alpha: 1)
        navigationItem.title = "Acknowledgement"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        
        view.addSubview(theySaidSoLabel)
        theySaidSoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        theySaidSoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        theySaidSoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        theySaidSoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        view.addSubview(flaticonLabel)
        flaticonLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        flaticonLabel.topAnchor.constraint(equalTo: theySaidSoLabel.bottomAnchor, constant: 60).isActive = true
        flaticonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        flaticonLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: 10).isActive = true
        
        view.addSubview(icon8Label)
        icon8Label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        icon8Label.topAnchor.constraint(lessThanOrEqualTo: flaticonLabel.bottomAnchor, constant: 60).isActive = true
        icon8Label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        icon8Label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    @objc private func handleBack() {
        dismiss(animated: true)
    }
}
