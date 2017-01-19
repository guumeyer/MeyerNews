//
//  DNService.swift
//  NewDesigner
//
//  Created by gustavo r meyer on 1/19/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct DNService {
    
    // Doc: https://github.com/metalabdesign/dn_api_v2
    
    private static let baseURL = "https://www.designernews.co"
    private static let clientID = "750ab22aac78be1c6d4bbe584f0e3477064f646720f327c5464bc127100a1a6d"
    private static let clientSecret = "53e3822c49287190768e009a8f8e55d09041c5bf26d0ef982693f215c72d87da"
    
    
    private enum ResourcePath: CustomStringConvertible {
        case login
        case stories
        case storyId(storyId: Int)
        case storyUpvote(storyId: Int)
        case storyReply(storyId: Int)
        case commentUpvote(commentId: Int)
        case commentReply(commentId: Int)
        
        var description: String {
            switch self {
            case .login: return "/oauth/token"
            case .stories: return "/api/v1/stories"
            case .storyId(let id): return "/api/v1/stories/\(id)"
            case .storyUpvote(let id): return "/api/v1/stories/\(id)/upvote"
            case .storyReply(let id): return "/api/v1/stories/\(id)/reply"
            case .commentUpvote(let id): return "/api/v1/comments/\(id)/upvote"
            case .commentReply(let id): return "/api/v1/comments/\(id)/reply"
            }
        }
    }
    
    static func storiesForSection(_ section: String, page: Int, completionHandler: @escaping (JSON) -> ()) {
        let urlString = baseURL + ResourcePath.stories.description + "/" + section
        let parameters = [
            "page": String(page),
            "client_id": clientID
        ]
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON { response in
            let stories = JSON(response.result.value ?? [])
            completionHandler(stories)
        }
    }
    
    static func loginWithEmail(_ email: String, password: String, completion: @escaping (_ token: String?) -> Void) {
        let urlString = baseURL + ResourcePath.login.description
        let parameters = [
            "grant_type": "password",
            "username": email,
            "password": password,
            "client_id": clientID,
            "client_secret": clientSecret
        ]
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON { response in
            let json = JSON(response.result.value!)
            let token = json["access_token"].string
            completion(token)
        }
    }
    
    private static func upvoteWithUrlString(_ urlString: String, token: String, completion: @escaping (_ successful: Bool) -> Void) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(request).responseJSON { response in
            let successful = response.response?.statusCode == 200
            completion(successful)
        }
    }
    
    static func upvoteStoryWithId(_ storyId: Int, token: String, completion: @escaping (_ successful: Bool) -> Void) {
        let urlString = baseURL + ResourcePath.storyUpvote(storyId: storyId).description
        upvoteWithUrlString(urlString, token: token, completion: completion)
    }
    
    static func upvoteCommentWithId(_ commentId: Int, token: String, completion: @escaping (_ successful: Bool) -> Void) {
        let urlString = baseURL + ResourcePath.commentUpvote(commentId: commentId).description
        upvoteWithUrlString(urlString, token: token, completion: completion)
    }
    
    private static func replyWithUrlString(_ urlString: String, token: String, body: String, completion: @escaping (_ successful: Bool) -> Void) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = "comment[body]=\(body)".data(using: String.Encoding.utf8)
        
        Alamofire.request(request).responseJSON { response in
            let json = JSON(response.result.value!)
            if json["comment"].string != nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    static func replyStoryWithId(_ storyId: Int, token: String, body: String, completion: @escaping (_ successful: Bool) -> Void) {
        let urlString = baseURL + ResourcePath.storyReply(storyId: storyId).description
        replyWithUrlString(urlString, token: token, body: body, completion: completion)
    }
    
    static func replyCommentWithId(_ commentId: Int, token: String, body: String, completion: @escaping (_ successful: Bool) -> Void) {
        let urlString = baseURL + ResourcePath.commentReply(commentId: commentId).description
        replyWithUrlString(urlString, token: token, body: body, completion: completion)
    }
    
}
