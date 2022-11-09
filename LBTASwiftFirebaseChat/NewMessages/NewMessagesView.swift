//
//  NewMessagesView.swift
//  LBTASwiftFirebaseChat
//
//  Created by dev22 jumpa on 09/11/22.
//

import SwiftUI
import SDWebImageSwiftUI



class MainMessagesViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    
    init() {
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        fetchCurrentUser()
    }
    
     func fetchCurrentUser() {
        self.errorMessage = "Fetching current user"
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).getDocument { snapshot, error in
                if let error = error {
                    print("Failed to fetch current user: ", error)
                    self.errorMessage = "Failed to fetch current user"
                    return
                }
                
                guard let data = snapshot?.data() else { self.errorMessage = "Failed to fetch current user"
                    return
                }
                
                self.chatUser = .init(data: data)
            }
    } 
    
    @Published var isUserCurrentlyLoggedOut = false
    
    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
}

struct NewMessagesView: View {
    
    @State var shouldShowLogoutOptions = false
    @ObservedObject private var vm = MainMessagesViewModel()
    
    private var customNavbar: some View {
        HStack(spacing: 16) {
            WebImage(url: URL(string: vm.chatUser?.profileImageUrl ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipped()
                .cornerRadius(50)
                .overlay(RoundedRectangle(cornerRadius: 50)
                    .stroke(Color(.label), lineWidth: 1)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                let username = vm.chatUser?.email.components(separatedBy: "@")[0] ?? ""
                Text(username)
                    .font(.system(size: 24, weight: .bold))
                
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }
            }
            Spacer()
            
            Button {
                shouldShowLogoutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
            }
        }
        .padding()
        .actionSheet(isPresented: $shouldShowLogoutOptions) {
            .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                .destructive(Text("Sign Out"), action: {
                    print("handle sign out")
                    vm.handleSignOut()
                }),
                .cancel()
            ])
        }
        .fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut, onDismiss: nil) {
            LoginView(didCompleteLoginProcess: {
                self.vm.isUserCurrentlyLoggedOut = false
                self.vm.fetchCurrentUser()
            })
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                customNavbar
                newMessageView
            }
            .overlay (newMessageButton, alignment: .bottom)
            .navigationBarHidden(true)
        }
    }
}

private var newMessageView: some View {
    ScrollView {
        ForEach(0..<10, id: \.self) { num in
            VStack {
                HStack(spacing: 16) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 32))
                        .padding(.all, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 32)
                                .stroke(Color(.label), lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text("Username")
                            .font(.system(size: 14, weight: .bold))
                        Text("Message sent to user")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.lightGray))
                    }
                    
                    Spacer()
                    Text("22d")
                        .font(.system(size: 14, weight: .semibold))
                }.padding(.top, 8)
                Divider()
                    .padding(.vertical, 8)
            }.padding(.horizontal)
        }.padding(.bottom, 50)
    }
}

private var newMessageButton: some View {
    Button {
        
    } label: {
        HStack {
            Spacer()
            Text("+ New Messages")
                .font(.system(size: 16, weight: .bold))
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.vertical)
            .background(Color.blue)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 5)
    }
}

struct NewMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessagesView()
    }
}
