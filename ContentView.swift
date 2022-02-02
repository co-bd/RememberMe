
import SwiftUI
import UIKit
import AuthenticationServices

let storedUser = "Cbaker"
let storedPass = "NEFC"


struct ContentView: View {
    
    @State var authentication = false
//    @Binding var event: Event
    
    var body: some View {
        return Group{
            
            if authentication == true {
                HomeView()
            }
            else {
                LoginFormView(authentication: $authentication)
            }
            
        }
        
    }
}


struct LoginFormView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State private var error = false
//    @State private var authentication = false
    @Binding var authentication: Bool


    var body: some View {
        VStack{

            Image("RememberMe").resizable().scaledToFit()
            HStack{
                TextField("Username", text: $username).padding()
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
            }

            HStack{
                SecureField("Password", text: $password).textContentType(.password)
                                .padding()
                                .cornerRadius(5.0)
                                .padding(.bottom, 20)
            }
            
      
            Button(action: {
                                if self.username == storedUser && self.password == storedPass {
                                    self.authentication = true
                                }
                else{
                    self.error = true
                }
                            }) {
                                Text("Login")
                                    .fontWeight(.semibold)
                                    .padding()
                                    .frame(width: 150.0, height: 150.0)
                            }

            }.padding()
        if error {
            Text("Incorrect username/password").foregroundColor(Color.red)
        }
    }
}


struct HomeView: View {
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var eventData = false
    @State private var addEventData = false
    @State private var addPlayerData = false
    @State private var searchTool = false
    
//    @State private var event: Event

    @ViewBuilder var body: some View {
        
//        return Group {
            
            if eventData ==
            true{
                EventDatabaseView(eventData: $eventData, addEventData: $addEventData, searchTool: $searchTool, addPlayerData: $addPlayerData)
            }
            else if addEventData == true{
                AddEventView(addEventData: $addEventData, eventData: $eventData, searchTool: $searchTool, addPlayerData: $addPlayerData)
            }
            else if searchTool == true{
                SearchView(searchTool: $searchTool, addPlayerData: $addPlayerData)
            }
            else {
            
                ZStack {
                    Image("ncaa").resizable().aspectRatio(contentMode: .fill)}
                    VStack {
                        Spacer()
        //                Spacer()
                        HStack{
                            Spacer()
                            SwiftUI.Button("Event Database"){
                                eventData = true
                            }.font(.footnote).foregroundColor(.black).multilineTextAlignment(.center)
                            Spacer()
        //                    Spacer()
                            SwiftUI.Button("Add Event"){
                                addEventData = true
                            }.font(.footnote).foregroundColor(.black).multilineTextAlignment(.center)
                            Spacer()
                            SwiftUI.Button("Camera") {
                                                              self.sourceType = .camera
                                                              self.isImagePickerDisplay.toggle()
                            }
                        Spacer()
                            Button("Search"){
                                searchTool = true }.font(.footnote).foregroundColor(.black).multilineTextAlignment(.trailing)
                            Spacer()
                            
                        }.sheet(isPresented: self.$isImagePickerDisplay){
                            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                        }
                       
                        
                    
                    }
            
//        }
        
    }
    }
}


struct EventDatabaseView: View {
    @StateObject var events = Event()
//    var events: Event
    @Binding var eventData: Bool
    @Binding var addEventData: Bool
    @Binding var searchTool: Bool
    @Binding var addPlayerData: Bool
    
    var body: some View{
        
            VStack{
                
                
                HStack{
                    Spacer()
                    Image("both").resizable().frame(width: 304, height: 68, alignment: .center)
                }
                Spacer()
                
                VStack{
                    Group{
                        HStack{
                            Text("Event Database").fontWeight(.bold).font(.body).multilineTextAlignment(.leading).padding()
                            Spacer()
                        }
                    }
                    
                    let event = events.event
                    List{
                        ForEach(event){ e in
                            Text("Event Name")
                            Text(e.eventName).fontWeight(.bold).font(.body).multilineTextAlignment(.leading).padding()
                            Spacer()
                            Text("Event Date")
                            Text(e.eventDate).fontWeight(.bold).font(.body).multilineTextAlignment(.leading).padding()
                        }
                    }
                   
                }
                
                Spacer()
                VStack {
                    Spacer()
    //                Spacer()
                    HStack{
                        Spacer()
                        SwiftUI.Button("Home"){
                            eventData = false
                            HomeView()
                        }.font(.footnote).foregroundColor(.black).multilineTextAlignment(.center)
                        Spacer()
    //                    Spacer()
                        SwiftUI.Button("Add Event"){
                            eventData = false
                            addEventData = true
                            
                            AddEventView(addEventData: $addEventData, eventData: $eventData, searchTool: $searchTool, addPlayerData: $addPlayerData)
                        }.padding().font(.footnote).foregroundColor(.black).multilineTextAlignment(.center)
                        Spacer()
                        Button("Search"){
                            eventData = false
                            searchTool = true
                            SearchView(searchTool: $searchTool, addPlayerData: $addPlayerData)
                        }.font(.footnote).foregroundColor(.black).multilineTextAlignment(.trailing)
                        Spacer()
                    }
                }
            }
        }
    }

struct AddEventView: View {
    @StateObject var events = Event()
    @State var eventDate: String = ""
    @State var eventName: String = ""
    @State var databaseUpload: String = ""
    @Binding var addEventData: Bool
    @Binding var eventData: Bool
    @Binding var searchTool: Bool
    @Binding var addPlayerData: Bool
    var body: some View{
        VStack {
            HStack{
                Spacer()
                Image("both").resizable().frame(width: 304, height: 68, alignment: .center)

            }
            Spacer()
        }
        VStack{
            Group{
                HStack{
                    TextField("Event Name", text: $eventName).padding()
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Spacer()
                }
                Spacer()
                HStack{
                    TextField("Event Date", text: $eventDate).padding()
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    
                    Spacer()
                }
                Spacer()
            }
            
            Group{
                HStack{
                    TextField("Database Uplaod", text: $databaseUpload).padding()
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Spacer()
                }
                Spacer()
            }
            Button(action: {let event = Act(eventName: eventName, eventDate: eventDate)
                events.event.append(event)
                EventDatabaseView(eventData: $eventData, addEventData: $addEventData, searchTool: $searchTool, addPlayerData: $addPlayerData)
            }) {
                    Text("Save")
                }
            
//            Event(eventName: eventName, eventDate: eventDate)
            
        }
        
        VStack{
                Spacer()
                HStack{
//                    Spacer()
                    SwiftUI.Button("Home"){
                        addEventData = false
                        HomeView()
                    }.font(.footnote).foregroundColor(.black).multilineTextAlignment(.leading).padding()
                    Spacer()
//                    Spacer()
                }
        }
        
    }
}

//struct EventView: View {
//
//    var event: Event
//
//    var body: some View{
//        Text(event.eventName)
//    }
//}

//adding in function to add an excel sheet

struct AddPlayerView: View {
    @StateObject var players = Profile()
    @State var name: String = ""
    @State var highSchool: String = ""
    @State var gradYear: String = ""
    @State var clubTeam: String = ""
    @State var emailAddress: String = ""
    @State var notes: String = ""
    @State private var error = false
    @Binding var addPlayerData: Bool
    var body: some View{
        VStack {
            HStack{
                Spacer()
                Image("both").resizable().frame(width: 304, height: 68, alignment: .center)
            }
            Spacer()
            VStack{
            Group {
                HStack{
                    TextField("Player Name", text: $name).padding()
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Spacer()
                }
                Spacer()
                HStack{
                    TextField("Year of Graduation", text: $gradYear).padding()
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Spacer()
                }
                Spacer()
            }
            Group{
                HStack{
                    TextField("Club Team", text: $clubTeam).padding()
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Spacer()
                }
                Spacer()
                HStack{
                    TextField("High School", text: $highSchool).padding()
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Spacer()
                }
                Spacer()
                HStack{
                    TextField("Email Address", text: $emailAddress).padding()
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Spacer()
                }
                Spacer()
                HStack{
                    TextField("Notes", text: $notes).padding()
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Spacer()
                }
                Spacer()
                Button(action: {let player = Player(name: name, gradYear: gradYear, clubTeam: clubTeam, highSchool: highSchool, emailAddress: emailAddress, notes: notes)
                    players.player.append(player)}) {
                        Text("Save")
                    }
            }
        }
        
        VStack{
                Spacer()
                HStack{
//                    Spacer()
                    SwiftUI.Button("Home"){
                        addPlayerData = false
                        HomeView()
                    }.font(.footnote).foregroundColor(.black).multilineTextAlignment(.leading).padding()
                    Spacer()
//                    Spacer()
                }
        }
        }
    }
}

struct SearchView: View{
    @Binding var searchTool: Bool
    @Binding var addPlayerData: Bool
//    @Binding var player: Profile
//    @Binding var event: Event
    
    var body: some View{
        
            VStack {
                HStack{
                    Spacer()
                    Image("both").resizable().frame(width: 304, height: 68, alignment: .center)
    //                Image("remembermelogo").resizable().frame(width: 200, height: 15, alignment: .center)//.scaledToFit()
    //                Spacer()
    //                Image("ncaalogo").resizable().frame(width: 25, height: 25, alignment: .topTrailing)
                    
                }
                Spacer()
            
            VStack{
                HStack{
//                    TextField("Player Name", text: $player.gradYear).padding()
//                        .cornerRadius(5.0)
//                        .padding(.bottom, 20)
                    Text("Player Name").fontWeight(.bold).font(.body).multilineTextAlignment(.leading).padding()
                    Spacer()
                }
                Spacer()
                HStack{
                    Text("Event Name").fontWeight(.bold).font(.body).multilineTextAlignment(.leading).padding()
                    Spacer()
                }
                Spacer()
            }
            
            VStack{
                    Spacer()
                    HStack{
    //                    Spacer()
                        SwiftUI.Button("Add Player"){
                            addPlayerData = true
                            AddPlayerView(addPlayerData: $addPlayerData)
                        }.padding().font(.footnote).foregroundColor(.black).multilineTextAlignment(.center)
                        Spacer()
                        SwiftUI.Button("Home"){
                            searchTool = false
                            HomeView()
                        }.font(.footnote).foregroundColor(.black).multilineTextAlignment(.leading).padding()
                        Spacer()
    //                    Spacer()
                    }
            }
            
        }
    }
}

final class SignInWithApple: UIViewRepresentable {
  // 2
  func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
    // 3
    return ASAuthorizationAppleIDButton()
  }
  
  // 4
  func updateUIView(_ uiView
                    : ASAuthorizationAppleIDButton, context: Context) {
  }
}

struct ImagePickerView: UIViewControllerRepresentable {

    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    var sourceType: UIImagePickerController.SourceType
        
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }
    //connecting imagepicker with coordinator
    func makeCoordinator() -> Coordinator {
            return Coordinator(picker: self)
        }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView
    
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
    
}
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}

