//
//  ViewController.swift
//  HW_3
//
//  Created by Антон Баландин on 17.11.23.
//

import UIKit

final class ColorViewController: UIViewController {
    
    @IBOutlet var colorfulLabel: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    weak var delegate: ColorViewControllerDelegate!
    
    let numberToolbar: UIToolbar = UIToolbar()
    
    var startBackgroundColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorfulLabel.layer.cornerRadius = 25
        
        colorfulLabel.backgroundColor = startBackgroundColor
        
        setValueColor(for: redSlider, greenSlider, blueSlider)
        setValueText(for: redValueLabel, greenValueLabel, blueValueLabel)
        
        changeValueTextField()
        
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
        changeValueTextField()
        
        switch sender {
        case redSlider:
            setValueText(for: redValueLabel)
        case greenSlider:
            setValueText(for: greenValueLabel)
        default:
            setValueText(for: blueValueLabel)
        }
    }
    
    @IBAction func doneButtonAction() {
        delegate.setBackgroundColor(colorfulLabel.backgroundColor ?? .yellow)
        dismiss(animated: true)
    }
    
    private func changeColor() {
        colorfulLabel.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func changeValueTextField() {
        redTextField.text = redValueLabel.text
        greenTextField.text = greenValueLabel.text
        blueTextField.text = blueValueLabel.text
    }
    
    private func setValueColor(for sliders: UISlider...) {
        let color = CIColor(color: startBackgroundColor)
        sliders.forEach { slider in
            switch slider {
            case redSlider: redSlider.value = Float(color.red)
            case greenSlider: greenSlider.value = Float(color.green)
            case blueSlider: blueSlider.value = Float(color.blue)
            default: break
            }
        }
    }
    
    private func setValueText(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel: redValueLabel.text = String(format: "%.2f", redSlider.value)
            case greenValueLabel: greenValueLabel.text = String(format: "%.2f", greenSlider.value)
            case blueValueLabel: blueValueLabel.text = String(format: "%.2f", blueSlider.value)
            default: break
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
    
    func updateValue() {
        redValueLabel.text = String(Float(redTextField.text ?? "0") ?? 0)
        redSlider.setValue((Float(redValueLabel.text ?? "0") ?? 0), animated: true)
        
        greenValueLabel.text = String(Float(greenTextField.text ?? "0") ?? 0)
        greenSlider.setValue((Float(greenValueLabel.text ?? "0") ?? 0), animated: true)
        
        blueValueLabel.text = String(Float(blueTextField.text ?? "0") ?? 0)
        blueSlider.setValue((Float(blueValueLabel.text ?? "0") ?? 0), animated: true)
        
        changeColor()
    }
}

//MARK: - UITextFieldDelegate
extension ColorViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = Float(textField.text ?? "0") else {
            showAlert(title: "Wrong format!", message: "Enter valid values from 0.0 to 1.0")
            textField.text = "0"
            
            updateValue ()
            return
        }
        
        if 0...1 ~= text {
            updateValue ()
        } else {
            showAlert(title: "Wrong format!", message: "Please enter value from 0.0 to 1.0")
            textField.text = "0"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateValue()
        return textField.resignFirstResponder()
    }
}
