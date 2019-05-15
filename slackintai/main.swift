//
//  main.swift
//  slackintai
//
//  Created by 史 翔新 on 2019/05/15.
//  Copyright © 2019 史 翔新. All rights reserved.
//

import Foundation

// Set `webhookStrings` in Credintials/Webhooks.swift like this:
// let webhookStrings: [String] = ["webhookURLStringA", "webhookURLStringB", ...]
let webhooks = webhookStrings.map({ URL(string: $0)! })

let messageBody = ":innocent:"
let jsonBody: [String: [[String: String]]] = [
    "attachments":
        [
            ["author_name": "lovee",
             "author_link": "https://github.com/el-hoshino",
             "text": "This is a test message"]
        ]
    ]
let json = try! JSONEncoder().encode(jsonBody)

let requests = webhooks.map({ (webhook) -> URLRequest in
    var request = URLRequest(url: webhook)
    request.httpMethod = "POST"
    request.httpBody = json
    return request
})

let dispatchGroup = DispatchGroup()

requests.forEach { (request) in
    dispatchGroup.enter()
    URLSession.shared.dataTask(with: request, completionHandler: { [dispatchGroup] (_, _, _) in
        dispatchGroup.leave()
    })
    .resume()
}

let result = dispatchGroup.wait(timeout: .now() + 10)
switch result {
case .success:
    exit(0)
    
case .timedOut:
    exit(1)
}

dispatchMain()
