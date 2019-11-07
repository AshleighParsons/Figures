//
//  UIButtonExtension.swift
//  Figures
//
//  Created by Ashleigh Parsons on 2019/11/07.
//  Copyright © 2019 Ashleigh Parsons. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.97
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.7
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
    }
}
