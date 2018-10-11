//
//  CustomSegmentedController.swift
//
//  Created by Divya saraswati on 5/7/18.
//  Copyright © 2018 Divya saraswati. All rights reserved.
//

import UIKit
@IBDesignable

class CustomSegmentedController: UIControl {
    var buttons = [UIButton]()
    var selector:UIView!
    var selectedSegmentIndex: Int = 0
    @IBInspectable
    var border_width: CGFloat = 0 {
        didSet {
            layer.borderWidth = border_width
        }
    }
    
    @IBInspectable
    var border_color : UIColor = UIColor.clear {
        didSet {
            layer.borderColor = border_color.cgColor
        }
    }

    @IBInspectable
    var commaSeparatedButtonTitles:String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var textColor:UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var textFont:UIFont = UIFont.systemFont (ofSize: 16) {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectedTextFont:UIFont = UIFont.boldSystemFont (ofSize: 18) {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectedTextColor:UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorViewColor:UIColor = UIColor.red {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview()}
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        for buttonTitle in buttonTitles {
            let button = UIButton.init(type: .custom)
            button.setTitle(buttonTitle, for: .normal)
            button.contentVerticalAlignment = .center
            button.contentHorizontalAlignment = .center
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = textFont
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[0].setTitleColor(selectedTextColor, for: .normal)
        buttons[0].titleLabel?.font = selectedTextFont

        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        selector = UIView.init(frame: CGRect(x:0,y:0,width:selectorWidth,height:frame.height))
        selector.layer.cornerRadius = frame.height/2
        selector.backgroundColor = selectorViewColor
        addSubview(selector)
        
        let sv = UIStackView.init(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        addSubview(sv)
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height/2
    }
    
    @objc func buttonTapped(button:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            btn.titleLabel?.font = textFont
            if btn == button {
                selectedSegmentIndex = buttonIndex
                let selectorStartPosition = (frame.width / CGFloat(buttons.count)) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selector.frame.origin.x = selectorStartPosition
                }
                btn.setTitleColor(selectedTextColor, for: .normal)
                btn.titleLabel?.font = selectedTextFont
            }
        }
        sendActions(for: .valueChanged)
    }
}
