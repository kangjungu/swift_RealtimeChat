//
//  Conversation.swift
//  RealtimeChat
//
//  Created by jG on 2017. 5. 17..
//  Copyright © 2017년 KangJungu. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Conversation{
    
    let user:User
    var lastMessage:Message
    
    class func showConversations(completion: @escaping ([Conversation])->Void){
        if let currentUserId = FIRAuth.auth()?.currentUser?.uid{
            var conversations = [Conversation]()
            
            FIRDatabase.database().reference().child("users").child(currentUserId).child("conversations").observe(.childAdded,with:{
                (snapshot) in
                if snapshot.exists(){
                    let fromId = snapshot.key
                    let values = snapshot.value as! [String:String]
                    let location = values["location"]!
                    
                    User.info(forUserID: fromId, completion: { (user) in
                        let emptyMessage = Message.init(type: .text, content: "loading", owner: .sender, timestamp: 0, isRead: true)
                        let conversation = Conversation.init(user: user, lastMessage: emptyMessage)
                        conversations.append(conversation)
                        conversation.lastMessage.downloadLastMessage(forLocation: location, completion: { (_) in
                            completion(conversations)
                        })
                    })
                }
            })
        }
    }
    
    init(user:User,lastMessage:Message) {
        self.user = user;
        self.lastMessage = lastMessage;
    }
}
