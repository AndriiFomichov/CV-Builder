//
//  TextGenerator.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import OpenAIKit

class TextGenerator {
    
    static let TEMP_LOW: Double = 0.15
    static let TEMP_MEDIUM: Double = 0.5
    static let TEMP_HIGH: Double = 0.8
    
    static func completeText (prompt: String, maxTokens: Int, temp: Double) async -> String? {
        if Reachability.isConnectedToNetwork() {
            let chat: [ChatMessage] = [ ChatMessage(role: .user, content: prompt) ]

            let chatParameters = ChatParameters(
                model: .chatGPTTurbo,  // ID of the model to use.
                messages: chat
            )

            do {
                let key = String(Bundle.main.object(forInfoDictionaryKey: "K_ONE") as! String).replacingOccurrences(of: "\"", with: "")

//                print("Key 1 - " + key)
                
                let openAI = OpenAI(Configuration(organizationId: "", apiKey: key))
                let chatCompletion = try await openAI.generateChatCompletion(
                    parameters: chatParameters
                )
                AnalyticsManager.saveEvent(event: Events.AI_REQUEST)

                if let message = chatCompletion.choices[0].message {
                    if let c = message.content {
                        print("Responce:\n" + c)
                        return c
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
                
                do {
                    let key = String(Bundle.main.object(forInfoDictionaryKey: "K_TWO") as! String).replacingOccurrences(of: "\"", with: "")

//                    print("Key 2 - " + key)
                    
                    let openAI = OpenAI(Configuration(organizationId: "", apiKey: key))
                    let chatCompletion = try await openAI.generateChatCompletion(
                        parameters: chatParameters
                    )
                    AnalyticsManager.saveEvent(event: Events.AI_REQUEST)

                    if let message = chatCompletion.choices[0].message {
                        if let c = message.content {
                            print("Responce:\n" + c)
                            return c
                        }
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        return nil
    }
}
