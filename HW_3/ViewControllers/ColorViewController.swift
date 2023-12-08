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
    
    weak var delegate: ColorViewControllerDelegate!
    
    var startBackgroundColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        colorfulLabel.layer.cornerRadius = 25
        
        colorfulLabel.backgroundColor = startBackgroundColor
        
        setValueColor(for: redSlider, greenSlider, blueSlider)
        setValueText(for: redValueLabel, greenValueLabel, blueValueLabel)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        changeColor()
        
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

}

