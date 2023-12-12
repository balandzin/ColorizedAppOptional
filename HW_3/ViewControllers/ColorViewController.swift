//
//  ViewController.swift
//  HW_3
//
//  Created by Антон Баландин on 17.11.23.
//

import UIKit

final class ColorViewController: UIViewController {
    
    @IBOutlet var colorLabel: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    unowned var delegate: ColorViewControllerDelegate!
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorLabel.layer.cornerRadius = 25
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        colorLabel.backgroundColor = color
        
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        changeColor()
        //setValue()
        
        switch sender {
        case redSlider:
            setValue(for: redValueLabel)
        case greenSlider:
            setValue(for: greenValueLabel)
        default:
            setValue(for: blueValueLabel)
        }
    }
    
    @IBAction func doneButtonAction() {
        delegate.setColor(colorLabel.backgroundColor ?? .yellow)
        dismiss(animated: true)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func changeColor() {
        colorLabel.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel: redValueLabel.text = string(from: redSlider)
            case greenValueLabel: greenValueLabel.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for sliders: UISlider...) {
        let color = CIColor(color: color)
        sliders.forEach { slider in
            switch slider {
            case redSlider: redSlider.value = Float(color.red)
            case greenSlider: greenSlider.value = Float(color.green)
            default: slider.value = Float(color.blue)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        
        textFields.forEach { textField in
            switch textField {
            case redTextField: textField.text = string(from: redSlider)
            case greenTextField: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension ColorViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        
        if let currentValue = Float(text), 0...1 ~= currentValue  {
            switch textField {
            case redTextField:
                redSlider.setValue(currentValue, animated: true)
                setValue(for: redValueLabel)
            case greenTextField:
                greenSlider.setValue(currentValue, animated: true)
                setValue(for: greenValueLabel)
            default:
                blueSlider.setValue(currentValue, animated: true)
                setValue(for: blueValueLabel)
            }
            changeColor()
            
        } else {
            showAlert(title: "Wrong format!", message: "Enter valid value from 0.0 to 1.0")
            switch textField {
            case redTextField:
                redSlider.setValue(0, animated: true)
                redValueLabel.text = "0.00"
                redTextField.text = "0.00"
            case greenTextField:
                greenSlider.setValue(0, animated: true)
                greenValueLabel.text = "0.00"
                greenTextField.text = "0.00"
            default:
                blueSlider.setValue(0, animated: true)
                blueValueLabel.text = "0.00"
                blueTextField.text = "0.00"
            }
            
            changeColor()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
