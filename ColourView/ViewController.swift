//
//  ViewController.swift
//  ColourView
//
//  Created by Denis Abramov on 27.07.2019.
//  Copyright © 2019 Denis Abramov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var colourView: UIView!
    
    @IBOutlet var numberRedLabel: UILabel!
    @IBOutlet var numberGreenLabel: UILabel!
    @IBOutlet var numberBlueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colourView.layer.cornerRadius = 20
        changeColour()
        
        let doneToolBar = UIToolbar()
        doneToolBar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonAction))
        
        doneToolBar.setItems([flexSpace, done], animated: false)
        
        redTextField.inputAccessoryView = doneToolBar
        greenTextField.inputAccessoryView = doneToolBar
        blueTextField.inputAccessoryView = doneToolBar
        
        self.hideKeyboard()
    }
    
    func changeColour() {
        colourView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
    }
    
    @IBAction func rgbColourChanged(_ sender: Any) {
        changeColour()
    }
    
    @IBAction func rgbNumberChanged(_ sender: Any) {
        numberRedLabel.text = String(format: "%.3f", (redSlider.value))
        numberGreenLabel.text = String(format: "%.3f", (greenSlider.value))
        numberBlueLabel.text = String(format: "%.3f", (blueSlider.value))
        
        redTextField.text = numberRedLabel.text
        greenTextField.text = numberGreenLabel.text
        blueTextField.text = numberBlueLabel.text
    }
    
    func setDataTextField(textField: UITextField, slider: UISlider, textValue: UILabel) {
        guard let inputData = textField.text, !inputData.isEmpty else { return }
        if let data = Float(inputData) {
            if data >= 0 && data <= 1 {
                slider.setValue(data, animated: true)
                textValue.text = String(data)
                textField.placeholder = String(data)
            }
        } else {
            showAlert(textField: textField)
        }
    }
    
    @objc func doneButtonAction(textfield: UITextField) {
        view.endEditing(true)
        
        setDataTextField(textField: redTextField, slider: redSlider, textValue: numberRedLabel)
        setDataTextField(textField: greenTextField, slider: greenSlider, textValue: numberGreenLabel)
        setDataTextField(textField: blueTextField, slider: blueSlider, textValue: numberBlueLabel)
        
        changeColour()
    }
}

extension ViewController {
    private func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func showAlert(textField: UITextField) {
        let alert = UIAlertController(
            title: "Не правильно введены данные!",
            message: "Введите значение от 0 до 1",
            preferredStyle: .alert
        )
        
        let aсtion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(aсtion)
        present(alert, animated: true)
    }
}
