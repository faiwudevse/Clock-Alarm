//
//  AlarmSoundCell.swift
//  AlarmClock
//
//  Created by Fai Wu on 3/19/20.
//  Copyright © 2020 Fai Wu. All rights reserved.
//

import UIKit

protocol AlarmSoundCellDelegate {
    func didSelectSound(sound: String)
}
class AlarmSoundCell: UITableViewCell, Cell {
    var delegate: AlarmSoundCellDelegate?
    var volume: Float = 0.5
    let soundPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.setValue(0.5, animated: false)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    let soundLabel: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "baseline_volume_up_black_24pt"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let musicButton: ToggleButton = {
        let btn = ToggleButton()
        btn.setImage(#imageLiteral(resourceName: "baseline_play_arrow_black_24pt"), for: .normal)
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    lazy var cellStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.spacing = 5
        sv.axis = .vertical
        return sv
    }()
    
    lazy var playStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fill
        sv.spacing = 2
        sv.axis = .horizontal
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        soundPicker.delegate = self
        soundPicker.dataSource = self
        cellStackView.addArrangedSubview(soundPicker)
        playStackView.addArrangedSubview(soundLabel)
        playStackView.addArrangedSubview(volumeSlider)
        playStackView.addArrangedSubview(musicButton)
        volumeSlider.addTarget(self, action: #selector(didVolumeChange(_:)), for: .valueChanged)
        musicButton.addTarget(self, action: #selector(didToogleButton(_:)), for: .touchUpInside)
        cellStackView.addArrangedSubview(playStackView)
        addSubview(cellStackView)
        cellStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cellStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        cellStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cellStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundColor = #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1)
    }
    
    @objc private func didVolumeChange(_ sender: UISlider) {
        volume = sender.value
        if musicButton.isToggle {
            AudioPlayer.shared.stopMusic()
            musicButton.isToggle.toggle()
            musicButton.setImage(#imageLiteral(resourceName: "baseline_play_arrow_black_24pt"), for: .normal)
        }
    }
    
    @objc private func didToogleButton(_ sender: ToggleButton) {
        sender.isToggle.toggle()
        if sender.isToggle {
            AudioPlayer.shared.setupAudioPlayer(audioFileName: Constants.Sound.ringtons[soundPicker.selectedRow(inComponent: 0)])
            AudioPlayer.shared.playMusic(volume: volume)
            sender.setImage(#imageLiteral(resourceName: "baseline_stop_black_24pt"), for: .normal)
        } else {
            AudioPlayer.shared.stopMusic()
            sender.setImage(#imageLiteral(resourceName: "baseline_play_arrow_black_24pt"), for: .normal)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlarmSoundCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return Constants.Sound.ringtons.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.Sound.ringtons[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if musicButton.isToggle {
            AudioPlayer.shared.stopMusic()
            musicButton.isToggle.toggle()
            musicButton.setImage(#imageLiteral(resourceName: "baseline_play_arrow_black_24pt"), for: .normal)
        }
        delegate?.didSelectSound(sound: Constants.Sound.ringtons[row])
    }
}
