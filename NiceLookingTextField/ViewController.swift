//
//  ViewController.swift
//  NiceLookingTextField
//
//  Created by Daniel Hjärtström on 2018-07-12.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

protocol DispatchQueueProtocol {}
extension DispatchQueueProtocol {
    func delay(time: Double, closure: @escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            closure()
        }
    }
}

class ViewController: UIViewController, DispatchQueueProtocol {

    private lazy var testView: TextfieldView = {
        let temp = TextfieldView(frame: CGRect(x: 0, y: 50.0, width: view.frame.width, height: 80.0))
        temp.setTitle = "Username"
        temp.setBackgroundColor = UIColor.blue
        temp.setTextfieldColor = UIColor.white
        temp.setTitleColor = UIColor.white
        temp.setBorderColor = UIColor.white
        temp.shouldAnimate = true
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testView.isHidden = false
        
        delay(time: 3.0) { [weak self] in
            self?.testView.isTextValid = true
            self?.delay(time: 3.0) { [weak self] in
                self?.testView.isTextValid = false
                self?.delay(time: 3.0) { [weak self] in
                    self?.testView.shouldAnimate = false
                    self?.testView.isTextValid = true
                }
            }
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

