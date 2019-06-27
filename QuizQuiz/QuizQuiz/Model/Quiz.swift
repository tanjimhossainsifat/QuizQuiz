//
//  Quiz.swift
//  QuizQuiz
//
//  Created by Tanjim Hossain Sifat on 27/6/19.
//  Copyright © 2019 Tanjim Hossain Sifat. All rights reserved.
//

import UIKit

enum QuestionType {
    case Regular
    case Photo
}

class Quiz{
    var type : QuestionType?
    var title : String?
    var thumbnail : String? {
        didSet {
            if let thumbnail = thumbnail {
                thumbnailUrl = URL(string: Constant.getImageBaseUrl() + thumbnail)
            }
        }
    }
    var choiceA : String?
    var choiceB : String?
    var choiceC :String?
    var choiceD : String?
    var answer : String?
    var thumbnailUrl : URL?
    
    init(type: QuestionType?, title: String?, thumbnail: String?, choice_a : String?, choice_b : String?, choice_c : String?, choice_d : String?, answer: String?) {
        self.type = type
        self.title = title
        self.thumbnail = thumbnail
        self.choiceA = choice_a
        self.choiceB = choice_b
        self.choiceC = choice_c
        self.choiceD = choice_d
        self.answer = answer
    }
    
    init(dictionary : [String : Any?]) {
        title = dictionary["title"] as? String
        type = dictionary["question_type"] as? QuestionType
        thumbnail = dictionary["thumbnail"] as? String
        choiceA = dictionary["choice_a"] as? String
        choiceB = dictionary["choice_b"] as? String
        choiceC = dictionary["choice_c"] as? String
        choiceD = dictionary["choice_d"] as? String
        answer = dictionary["answer"] as? String
    }

}

extension Quiz {
    class func quizes(quizList : [[String : Any?]]) -> [Quiz] {
        return quizList.map{Quiz(dictionary: $0)}
    }
}
