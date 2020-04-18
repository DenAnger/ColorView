//
//  ViewController.swift
//  ColourView
//
//  Created by Denis Abramov on 27.07.2019.
//  Copyright © 2019 Denis Abramov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var valueRedLabel: UILabel!
    @IBOutlet var valueGreenLabel: UILabel!
    @IBOutlet var valueBlueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    // MARK: - Methods of class
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 20
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        setColor()
        setValueForLabel()
        setValueForTextField()
        
        addDoneButton(redTextField)
        addDoneButton(greenTextField)
        addDoneButton(blueTextField)
    }
    
    // MARK: - IBActions
    @IBAction func rgbSlider(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            valueRedLabel.text = string(from: sender)
            redTextField.text = string(from: sender)
        case 1:
            valueGreenLabel.text = string(from: sender)
            greenTextField.text = string(from: sender)
        case 2:
            valueBlueLabel.text = string(from: sender)
            blueTextField.text = string(from: sender)
        default:
            break
        }
        setColor()
    }
    
    // MARK: - Values
    private func setColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }
    
    private func setValueForLabel() {
        valueRedLabel.text = string(from: redSlider)
        valueGreenLabel.text = string(from: greenSlider)
        valueBlueLabel.text = string(from: blueSlider)
    }
    
    private func setValueForTextField() {
        redTextField.text = string(from: redSlider)
        greenTextField.text = string(from: greenSlider)
        blueTextField.text = string(from: blueSlider)
    }
    
    private func string(from slider: UISlider) -> String {
        return String(format: "%.3f", slider.value)
    }
}

// MARK: - Extensions
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        if let currentValue = Float(text) {
            switch textField.tag {
            case 0:
                redSlider.value = currentValue
            case 1:
                greenSlider.value = currentValue
            case 2:
                blueSlider.value = currentValue
            default:
                break
            }
            setColor()
            setValueForLabel()
        } else {
            showAlert(title: "Empty value!",
                      message: "Enter value 0 to 1")
        }
    }
}

extension ViewController {
    private func addDoneButton(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDone))
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let aсtion = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(aсtion)
        present(alert, animated: true)
    }
}
