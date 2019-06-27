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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataByApi()
        
    }
    
}


extension QuizViewController {
    
    func updateView() {
        
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
        currentQuiz = currentQuiz + 1
    }
    
    func didFailWithError(error: Error) {
        
        MBProgressHUD.hide(for: self.view, animated: true)

    }
    
}
