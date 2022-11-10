//
//  ChatMessage.swift
//  LBTASwiftFirebaseChat
//
//  Created by dev22 jumpa on 10/11/22.
//

import Foundation
import FirebaseFirestoreSwift

struct ChatMessage: Codable, Identifiable {
    @DocumentID var id: String?
    let fromId, toId, text: String
    let timestamp: Date
}
