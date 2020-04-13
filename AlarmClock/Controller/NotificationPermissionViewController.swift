//
//  NotificationPermissionViewController.swift
//  AlarmClock
//
//  Created by Fai Wu on 1/7/20.
//  Copyright © 2020 Fai Wu. All rights reserved.
//

import UIKit

class NotificationPermissionViewController: UIViewController {

    let textLabel : UILabel = {
        let label = UILabel()
        label.text = "Notification Permission Required"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    let imageView : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "notification"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let permissionBtn : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.1345717907, green: 0.5408709645, blue: 0.9021015763, alpha: 1)
        button.layer.cornerRadius = 25
        button.setTitle("Enable notification", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleNotification), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160).isActive = true
        view.addSubview(textLabel)
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(permissionBtn)
        permissionBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        permissionBtn.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 30).isActive = true
        permissionBtn.widthAnchor.constraint(equalToConstant: 180).isActive = true
        permissionBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func handleNotification(){
        let alertController = UIAlertController(title: "Enable notification", message: "Please go to the app notification page and enable the notifications", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl) { (success) in
                    print("Settings opened: \(success)")
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)

        present(alertController, animated: true, completion: nil)
        
    }
}
