//
//  TextfieldView.swift
//  NiceLookingTextField
//
//  Created by Daniel Hjärtström on 2018-07-12.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class TextfieldView: UIView {
    
    var isTextValid: Bool? {
        didSet {
            animateBorder(isValid: isTextValid)
        }
    }
    
    var setBackgroundColor: UIColor = UIColor.white {
        didSet {
            self.backgroundColor = setBackgroundColor
            titlelabel.backgroundColor = setBackgroundColor
            textfield.backgroundColor = setBackgroundColor
        }
    }
    
    var setTitleColor: UIColor = UIColor.black {
        didSet {
            self.titlelabel.setTitleColor(setTitleColor, for: .normal)
        }
    }
    
    var setTextfieldColor: UIColor = UIColor.black {
        didSet {
            self.textfield.textColor = setTextfieldColor
        }
    }
    
    var setTitle: String? {
        didSet {
            titlelabel.setTitle(setTitle, for: .normal)
        }
    }
    
    var setBorderColor: UIColor = UIColor.blue {
        didSet {
            //self.innerView.layer.borderColor = setBorderColor.cgColor
            innerViewShapeLayer.strokeColor = setBorderColor.cgColor
        }
    }
    
    private lazy var titlelabel: UIButton = {
        let temp = UIButton()
        temp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22.0)
        temp.setTitleColor(setTitleColor, for: .normal)
        temp.backgroundColor = setBackgroundColor
        temp.titleLabel?.textAlignment = .center
        temp.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        temp.titleLabel?.lineBreakMode = .byTruncatingTail
        temp.titleLabel?.adjustsFontSizeToFitWidth = true
        temp.titleLabel?.minimumScaleFactor = 0.8
        insertSubview(temp, aboveSubview: innerView)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: innerView.leadingAnchor, constant: 15.0).isActive = true
        temp.widthAnchor.constraint(lessThanOrEqualTo: innerView.widthAnchor, multiplier: 0.5).isActive = true
        temp.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        return temp
    }()
    
    private lazy var innerView: UIView = {
        let temp = UIView(frame: CGRect(x: 10.0, y: 10.0, width: frame.width - 20.0, height: frame.height - 20.0))
        temp.backgroundColor = UIColor.clear
        //    temp.layer.cornerRadius = 10.0
    //    temp.layer.borderColor = setBorderColor.cgColor
     //   temp.layer.borderWidth = 2.0
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        return temp
    }()
    
    private lazy var innerViewShapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = nil
        shapeLayer.path = UIBezierPath(roundedRect: innerView.bounds, cornerRadius: 10.0).cgPath
        shapeLayer.strokeColor = setBorderColor.cgColor
        shapeLayer.strokeEnd = 1.0
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineWidth = 2.0
        shapeLayer.frame = innerView.bounds
        return shapeLayer
    }()
    
    private lazy var textfield: UITextField = {
        let temp = UITextField()
        temp.textColor = setTextfieldColor
        temp.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.medium)
        temp.minimumFontSize = 15.0
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.trailingAnchor.constraint(equalTo: innerView.trailingAnchor, constant: -10.0).isActive = true
        temp.leadingAnchor.constraint(equalTo: titlelabel.leadingAnchor, constant: 10.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: innerView.bottomAnchor, constant: -5.0).isActive = true
        temp.topAnchor.constraint(equalTo: titlelabel.bottomAnchor).isActive = true
        return temp
    }()
    
    private func animateBorder(isValid: Bool?) {
        guard let isValid = isValid else { return }

        let color = isValid ? UIColor.green : UIColor.red
        innerViewShapeLayer.strokeEnd = 0
        innerViewShapeLayer.strokeColor = color.cgColor
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 3.0
        animation.fromValue = 0
        animation.toValue = 1.0
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        innerViewShapeLayer.add(animation, forKey: "strokeEnd")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = setBackgroundColor
        innerView.isHidden = false
        innerView.layer.addSublayer(innerViewShapeLayer)
        textfield.isHidden = false
        titlelabel.isHidden = false
    }
    
}
