//
//  StartViewController.swift
//  HW_3
//
//  Created by Антон Баландин on 7.12.23.
//

import UIKit

protocol ColorViewControllerDelegate: AnyObject {
    func setColor(_ color: UIColor)
}

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorVC = segue.destination as? ColorViewController else { return }
        colorVC.delegate = self
        colorVC.color = view.backgroundColor
    }
}

// MARK: - ColorViewControllerDelegate
extension StartViewController: ColorViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
