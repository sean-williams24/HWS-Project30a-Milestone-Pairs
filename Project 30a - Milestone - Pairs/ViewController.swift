//
//  ViewController.swift
//  Project 30a - Milestone - Pairs
//
//  Created by Sean Williams on 14/11/2019.
//  Copyright © 2019 Sean Williams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstView: UIView!
    var secondView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        firstView = UIView(frame: CGRect(x: 32, y: 32, width: 128, height: 128))
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 128, height: 128)
        button.addTarget(self, action: #selector(flip), for: .touchUpInside)
        firstView.addSubview(button)
        
        secondView = UIView(frame: CGRect(x: 32, y: 32, width: 128, height: 128))
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 128, height: 128))
        imageView.image = UIImage(named: "sean1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        secondView.addSubview(imageView)
        
        let button2 = UIButton()
        button2.frame = CGRect(x: 0, y: 0, width: 128, height: 128)
        button2.addTarget(self, action: #selector(flip2), for: .touchUpInside)
        secondView.addSubview(button2)

        firstView.backgroundColor = UIColor.red
        secondView.backgroundColor = UIColor.blue
        

        secondView.isHidden = true

        view.addSubview(firstView)
        view.addSubview(secondView)

    }
    
    @objc func flip() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]

        UIView.transition(with: firstView, duration: 1.0, options: transitionOptions, animations: {
            self.firstView.isHidden = true
        })

        UIView.transition(with: secondView, duration: 1.0, options: transitionOptions, animations: {
            self.secondView.isHidden = false
        })
    }
    
    @objc func flip2() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]

        UIView.transition(with: firstView, duration: 1.0, options: transitionOptions, animations: {
            self.firstView.isHidden = false
        })

        UIView.transition(with: secondView, duration: 1.0, options: transitionOptions, animations: {
            self.secondView.isHidden = true
        })
    }

}

