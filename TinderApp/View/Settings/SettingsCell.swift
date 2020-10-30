//
//  File.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 27/10/20.
//

import Foundation
import UIKit


protocol SettingsCellDelegate: class {
    func settingsCell(_ cell: SettingsCell, updateUserWith value: String , for section: SettingsSections)
    func settingsCell(_ cell: SettingsCell, updateAgeWith sender: UISlider)
}

class SettingsCell: UITableViewCell {
    
    /*------> Componentes <------*/
    lazy var inputField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        let paddingView = UIView()
        paddingView.setDimensions(height: 50, width: 28)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        tf.returnKeyType = .done
        tf.delegate = self
        tf.addTarget(self, action: #selector(handleUpdateUserInfo), for: .editingDidEnd )
        return tf
    }()
    lazy var minAgeSlider = createSlider()
    lazy var maxAgeSlider = createSlider()
    let minAgeLabel = UILabel()
    let maxAgeLabel = UILabel()
    var sliderStack = UIStackView()
    
    /*------> Propiedades <------*/
    weak var delegate: SettingsCellDelegate?
    var viewModel: SettingsViewModel! {
        didSet {
            configure()
        }
    }
    
    /*------> Overrides <------*/
    // Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(inputField)
        inputField.fillSuperview()
        
        minAgeLabel.text = "Min: 18"
        maxAgeLabel.text = "Max: 60"
        
        let minStack = UIStackView(arrangedSubviews: [minAgeLabel, minAgeSlider])
        minStack.spacing = 24
        
        let maxStack = UIStackView(arrangedSubviews: [maxAgeLabel, maxAgeSlider])
        maxStack.spacing = 24
        
        sliderStack = UIStackView(arrangedSubviews: [minStack, maxStack])
        sliderStack.axis = .vertical
        sliderStack.spacing = 16
        addSubview(sliderStack)
        sliderStack.centerY(inView: self)
        sliderStack.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 24, paddingRight: 24)
    }
    // Inits
    required init?(coder: NSCoder) {
        fatalError("init(coder:) ha fallado al iniciar SettingsCell ")
    }
    
    /*------> Preparativos <------*/
    private func configure(){
        inputField.isHidden = viewModel.shouldHideInputField
        sliderStack.isHidden = viewModel.shouldHideSlider
        inputField.placeholder = viewModel.placeholderText
        inputField.text = viewModel.value
        minAgeLabel.text = viewModel.minAgeLabelText(forValue: viewModel.minAgeSliderValue)
        maxAgeLabel.text = viewModel.maxAgeLabelText(forValue: viewModel.maxAgeSliderValue)
        minAgeSlider.setValue(viewModel.minAgeSliderValue, animated: true)
        maxAgeSlider.setValue(viewModel.maxAgeSliderValue, animated: true)
    }
    
    /*------> Otras funciones <------*/
    private func createSlider() -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 60
        slider.addTarget(self, action: #selector(handleSliderChanged), for: .valueChanged)
        return slider
    }
    
    /*------> Acciones <------*/
    // Slider Cambio
    @objc func handleSliderChanged(sender: UISlider) {
        if (sender == minAgeSlider) {
            minAgeLabel.text = viewModel.minAgeLabelText(forValue: sender.value)
        } else {
            maxAgeLabel.text = viewModel.maxAgeLabelText(forValue: sender.value)
        }
        delegate?.settingsCell(self, updateAgeWith: sender)
    }
    // Textfield se edito
    @objc func handleUpdateUserInfo(sender: UITextField) {
        guard let value = sender.text else { return }
        delegate?.settingsCell(self, updateUserWith: value, for: viewModel.section)
    }
    
}

//Textfield Delegate
extension SettingsCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
    }
}
