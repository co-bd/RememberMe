import Foundation
import SwiftUI

class Event: ObservableObject {
    @Published var event = [Act]()
    
    public func display(){
        
        ForEach(event, id: \.self){ event in
            Text("Event Name")
            Text(event.eventName).fontWeight(.bold).font(.body).multilineTextAlignment(.leading).padding()
            Spacer()
            Text("Event Date")
            Text(event.eventDate).fontWeight(.bold).font(.body).multilineTextAlignment(.leading).padding()
        }
    }
   
}

struct Act: Identifiable, Hashable{
    let id = UUID()
    let eventName: String
    let eventDate: String
}
