//
//  ViewController.swift
//  GlossButtonDemo
//
//  Created by Lane Faison on 3/1/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var coolButton: CoolButton!
    
    @IBAction func hueValueChanged(_ sender: Any) {
        guard let slider = sender as? UISlider else { return }
        coolButton.hue = CGFloat(slider.value)
    }
    
    @IBAction func saturationValueChanged(_ sender: Any) {
        guard let slider = sender as? UISlider else { return }
        coolButton.saturation = CGFloat(slider.value)
    }
    @IBAction func brightnessValueChanged(_ sender: Any) {
        guard let slider = sender as? UISlider else { return }
        coolButton.brightness = CGFloat(slider.value)
    }
    
}

