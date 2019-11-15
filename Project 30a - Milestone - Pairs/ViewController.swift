//
//  ViewController.swift
//  Project 30a - Milestone - Pairs
//
//  Created by Sean Williams on 14/11/2019.
//  Copyright © 2019 Sean Williams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cardTop: UIView!
    var cardBottom: UIView!
    var cardsView: UIView!
    
    var topCards = [UIView]()
    var bottomCards = [UIView]()
    var images = [UIImage]()
    
    var tappedCards = [UIButton]()
    var firstCardTag: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<2 {
            for index in 1...10 {
                images.append(UIImage(named: "\(index)")!)
            }
        }
        images.shuffle()
        
        cardsView = UIView(frame: CGRect(x: (view.frame.width / 2) - 500 , y: 100, width: 1000, height: 800))
        cardsView.backgroundColor = .white
        cardsView.layer.borderColor = UIColor.gray.cgColor
        cardsView.layer.borderWidth = 5
        view.addSubview(cardsView)
        
        let cardWidth = 200
        let cardHeight = 200
        var buttonTag = -1
        
        for row in 0..<4 {
            for col in 0..<5 {
                buttonTag += 1
                
                let cardPosition = CGRect(x: col * cardWidth, y: row * cardHeight, width: cardWidth, height: cardHeight)
                
                cardTop = UIView(frame: cardPosition)
                cardTop.tag = buttonTag
                cardTop.backgroundColor = UIColor.black
                cardTop.layer.borderColor = UIColor.gray.cgColor
                cardTop.layer.borderWidth = 2.5
                
                let button = UIButton()
                button.tag = buttonTag
                button.titleLabel?.font = UIFont.systemFont(ofSize: 34, weight: .thin)
                button.setTitle("PAIRS", for: .normal)
                button.setTitleShadowColor(.cyan, for: .normal)
                button.frame = CGRect(x: 0, y: 0, width: cardWidth, height: cardHeight)
                button.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)
                cardTop.addSubview(button)
                
                cardsView.addSubview(cardTop)
                topCards.append(cardTop)
                
                cardBottom = UIView(frame: cardPosition)
                cardBottom.tag = buttonTag
                cardBottom.backgroundColor = UIColor.blue
                cardBottom.layer.borderColor = UIColor.gray.cgColor
                cardBottom.layer.borderWidth = 2.5
                
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cardWidth, height: cardHeight))
                imageView.image = images[buttonTag]
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                cardBottom.addSubview(imageView)
                
                cardBottom.isHidden = true
                
                cardsView.addSubview(cardBottom)
                bottomCards.append(cardBottom)
            }
        }
    }
    
    @objc func cardTapped(sender: UIButton) {
        
        //Flip Card
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: topCards[sender.tag], duration: 2.0, options: transitionOptions, animations: {
            self.topCards[sender.tag].isHidden = true
        })
        
        UIView.transition(with: bottomCards[sender.tag], duration: 1, options: transitionOptions, animations: {
            self.bottomCards[sender.tag].isHidden = false
        })
        
        // If two cards are flipped
        if firstCardTag != nil {
            if images[firstCardTag!] == images[sender.tag] {
                //User interaction enabled false
                bottomCards[sender.tag].isUserInteractionEnabled = false
                bottomCards[firstCardTag!].isUserInteractionEnabled = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.cardsView.isUserInteractionEnabled = true
                    self.firstCardTag = nil
                }
            } else {
                // Flip cards back over
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    
                    // Flip second card back over
                    UIView.transition(with: self.bottomCards[sender.tag], duration: 0.4, options: transitionOptions, animations: {
                        self.bottomCards[sender.tag].isHidden = true
                    })
                    
                    UIView.transition(with: self.topCards[sender.tag], duration: 1, options: transitionOptions, animations: {
                        self.topCards[sender.tag].isHidden = false
                    })
                    
                    // Flip first card back over
                    UIView.transition(with: self.bottomCards[self.firstCardTag!], duration: 0.4, options: transitionOptions, animations: {
                        self.bottomCards[self.firstCardTag!].isHidden = true
                    })
                    
                    UIView.transition(with: self.topCards[self.firstCardTag!], duration: 1, options: transitionOptions, animations: {
                        self.topCards[self.firstCardTag!].isHidden = false
                    })
                    
                    self.firstCardTag = nil
                    self.tappedCards.removeAll(keepingCapacity: true)
                    self.cardsView.isUserInteractionEnabled = true
                }
            }
        }
        
        tappedCards.append(sender)
        if firstCardTag == nil {
            firstCardTag = sender.tag
        }
        
        if tappedCards.count == 2 {
            cardsView.isUserInteractionEnabled = false
        }
    }
}

