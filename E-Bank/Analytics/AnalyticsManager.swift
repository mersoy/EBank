//  Copyright © 2018 Muge Ersoy. All rights reserved.

import Foundation

public enum EventName: String {
    case loginSuccessful
    case loginFailed
}

protocol AnalyticsManager {
    func sendEvent(eventName: EventName)
}

class DefaultAnalyticsManager: AnalyticsManager {
    func sendEvent(eventName: EventName) {
        // This will be sent to server
        // For MVP just printing on terminal
        print("Event Neme" + eventName.rawValue + "has been sent")
    }
}
