//
//  QuizViewController.swift
//  QuizQuiz
//
//  Created by Tanjim Hossain Sifat on 27/6/19.
//  Copyright © 2019 Tanjim Hossain Sifat. All rights reserved.
//

import UIKit
import MBProgressHUD

class QuizViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    var quizApi = QuizApi()
    var currentQuiz : Int = 0
    var quizes = [Quiz]() {
        didSet {
            updateView()
        }
    }
    

    @IBAction func onButtonA(_ sender: UIButton) {
    }
    
    @IBAction func onButtonB(_ sender: UIButton) {
    }
    
    @IBAction func onButtonC(_ sender: UIButton) {
    }
    
    @IBAction func onButtonD(_ sender: UIButton) {
    }
    
    @IBAction func onButtonNext(_ sender: UIButton) {
        self.currentQuiz = currentQuiz + 1
        updateView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataByApi()
        
    }
    
}


extension QuizViewController {
    
    func updateView() {
        
        if currentQuiz < quizes.count {
            self.nextButton.isHidden = false
            let quiz = quizes[currentQuiz]
            
            self.topLabel.text = "Question \(currentQuiz+1) out of \(quizes.count)"
            
            if let title = quiz.title {
                self.titleLabel.text = "Q. \(title)"
            }
            
            if let choiceA = quiz.choiceA {
                
                self.buttonA.setTitle(choiceA, for: UIControl.State.normal)
                self.buttonA.setTitle(choiceA, for: UIControl.State.highlighted)
            }
            
            if let choiceB = quiz.choiceB {
                self.buttonB.setTitle(choiceB, for: UIControl.State.normal)
                self.buttonB.setTitle(choiceB, for: UIControl.State.highlighted)
            }
            
            if let choiceC = quiz.choiceC {
                
                self.buttonC.setTitle(choiceC, for: UIControl.State.normal)
                self.buttonC.setTitle(choiceC, for: UIControl.State.highlighted)
            }
            
            if let choiceD = quiz.choiceD {
                self.buttonD.setTitle(choiceD, for: UIControl.State.normal)
                self.buttonD.setTitle(choiceD, for: UIControl.State.highlighted)
            }
            
            self.imageView.isHidden = true
            if let imageUrl = quiz.thumbnailUrl {
                self.imageView.isHidden = false
                self.imageView.setImageWith(imageUrl, placeholderImage: #imageLiteral(resourceName: "NoPreview"))
            }
            
        } else {
            self.nextButton.isHidden = true
        }
        
    }
}

extension QuizViewController {
    @objc func fetchDataByApi() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        quizApi.delegate = self
        quizApi.fetchQuizes()
    }
}


extension QuizViewController : QuizDelegate {
    func didFinishUpdatingQuizes(quizes: [Quiz]) {
        
        MBProgressHUD.hide(for: self.view, animated: true)
        self.quizes = quizes
    }
    
    func didFailWithError(error: Error) {
        
        MBProgressHUD.hide(for: self.view, animated: true)

    }
    
}
