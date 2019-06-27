//
//  QuizApi.swift
//  QuizQuiz
//
//  Created by Tanjim Hossain Sifat on 27/6/19.
//  Copyright © 2019 Tanjim Hossain Sifat. All rights reserved.
//

import UIKit

import UIKit
import CoreData


enum QuizError: Error {
    case networkFail(description: String)
    case jsonSerializationFail
    case dataNotReceived
    case castFail
    case internalError
    case unknown
}

extension QuizError: LocalizedError {
    public var errorDescription: String? {
        let defaultMessage = "Unknown error!"
        let internalErrorMessage = "Something's wrong! Please contact our support team."
        switch self {
        case .networkFail(let localizedDescription):
            print(localizedDescription)
            return localizedDescription
        case .jsonSerializationFail:
            return internalErrorMessage
        case .dataNotReceived:
            return internalErrorMessage
        case .castFail:
            return internalErrorMessage
        case .internalError:
            return internalErrorMessage
        case .unknown:
            return defaultMessage
        }
    }
}

protocol QuizDelegate: NSObjectProtocol {
    func didFinishUpdatingQuizes(quizes : [Quiz]) -> Void
    func didFailWithError(error: Error) -> Void
}

class QuizApi {
    
    var delegate: QuizDelegate?
    
    func fetchQuizes() {
        var urlRequest = URLRequest(url: URL(string: Constant.getApiUrl())!)
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: urlRequest, completionHandler:
        { (data, response, error) in
            
            guard error == nil else {
                self.delegate?.didFailWithError(error: QuizError.networkFail(description: error!.localizedDescription))
                print("QuizError: \(error!.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                self.delegate?.didFailWithError(error: QuizError.unknown)
                print("QuizError: Unknown error. Could not get response!")
                return
            }
            
            guard response.statusCode == 200 else {
                self.delegate?.didFailWithError(error: QuizError.internalError)
                print("QuizError: Response code was either 401 or 404.")
                return
            }
            
            guard let data = data else {
                self.delegate?.didFailWithError(error: QuizError.dataNotReceived)
                print("QuizError: Could not get data!")
                return
            }
            
            do {
                let quizes = try self.parseQuizes(with: data)
                self.delegate?.didFinishUpdatingQuizes(quizes: quizes)
            } catch (let error) {
                self.delegate?.didFailWithError(error: error)
                print("QuizError: Some problem occurred during JSON serialization.")
                return
            }
            
        });
        task.resume()
    }
    
    func parseQuizes(with data: Data) throws -> [Quiz] {
        do {
            
            guard let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                throw QuizError.castFail
            }
            
            guard let quizDictionaries = responseDictionary["results"] as? [[String : Any?]] else {
                print("QuizError: Quiz dictionary not found.")
                throw QuizError.unknown
            }
            
            return Quiz.quizes(quizList: quizDictionaries)
            
        } catch (let error) {
            print("QuizError: \(error.localizedDescription)")
            throw error
        }
    }
    
}

