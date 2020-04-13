//
//  MotivationDismissViewController.swift
//  AlarmClock
//
//  Created by Fai Wu on 1/1/20.
//  Copyright © 2020 Fai Wu. All rights reserved.
//

import UIKit

class MotivationDismissViewController: UIViewController {
    
    private var dismissBtn : UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width:80 ,height: 80)
        button.layer.cornerRadius = button.frame.size.height / 2.0
        button.clipsToBounds = true
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.1345717907, green: 0.5408709645, blue: 0.9021015763, alpha: 1)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    private let motivationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        motivationLabel.text = Constants.Quote.dream
    }
    
    @objc private func handleDismiss() {
        ScheduledNotification.shared.updateAllDeliveredNotifications()
        let vc = CustomNaviController(rootViewController: AlarmTableViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc , animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(motivationLabel)
        motivationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        motivationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        motivationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        motivationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35).isActive = true
        
        view.addSubview(authorLabel)
        authorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        authorLabel.topAnchor.constraint(equalTo: motivationLabel.bottomAnchor, constant: 10).isActive = true
        
        view.addSubview(dismissBtn)
        dismissBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        dismissBtn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        dismissBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        if Reachability.isConnectedToNetwork(){
            Client.shared.fetchQuteOfDay { (quote,author, error) in
                guard let quote = quote else {
                    return
                }
                DispatchQueue.main.async {
                    self.motivationLabel.text = quote
                    
                    if let author = author {
                        self.authorLabel.text = "- " + author
                    }
                }
            }
        } else {
            self.motivationLabel.text = Constants.Quote.dream
        }
    }
}
