import SwiftUI

struct TeamScreen: View {
    
    @StateObject private var viewModel = TeamViewModel()
    @State private var showTeamHeaderView = false
    @State private var showTeamListView = false
    
    var body: some View {
        
        VStack {
            headerTeamView
            
            TitleView(title: "Team")
                .padding(.top, 30)
            
            if viewModel.participant.isEmpty {
                initialTeamView
            } else {
                participantListView
            }
        }
        .sheet(isPresented: $showTeamHeaderView) {
            TeamHeaderView(viewModel: viewModel)
        }
        .sheet(isPresented: $showTeamListView) {
            TeamListView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.fetchTeam()
        }
        .padding(.horizontal, 20)
        .frame(maxHeight: .infinity)
        .background(
            Color.theme.background.main
                .ignoresSafeArea()
        )
    }
}

extension TeamScreen {
    
    private var headerTeamView: some View {
        
        VStack {
            if let image = viewModel.image, !viewModel.name.isEmpty {
                ZStack(alignment: .bottom) {
                    Image(uiImage: image)
                        .resizable()
                    Text(viewModel.name)
                        .font(.largeTitle).bold()
                        .padding(.vertical, 20)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.theme.other.primary)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                VStack() {
                    
                    Text("Add the info")
                        .font(.title).bold()
                        .foregroundColor(Color.theme.text.main)
                    Text("Indicate information about team")
                        .font(.callout)
                        .foregroundColor(
                            Color(hex: "#F4F8FF").opacity(0.7)
                        )
                    CustomButtonView(buttonLabel: "Add information", action: {
                        showTeamHeaderView.toggle()
                    })
                    .padding(.top, 14)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 26)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.05))
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top)
    }
    
    private var initialTeamView: some View {
        VStack {
            
            VStack {
                Text("Add participants")
                    .font(.title).bold()
                    .foregroundColor(Color.theme.text.main)
                Text("Manage your team")
                    .font(.callout)
                    .foregroundColor(
                        Color(hex: "#F4F8FF").opacity(0.7)
                    )
                CustomButtonView(buttonLabel: "Add a participants", action: {
                    showTeamListView.toggle()
                })
                .padding(.top, 14)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
        }
    }
    
    private var participantListView: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                LazyVStack {
                    
                    ForEach(viewModel.participant, id: \.self) { gamers in
                        ParticipantCellView(
                            name: gamers.name ?? "",
                            nickname: gamers.nickname ?? "",
                            game: gamers.game ?? "")
                    }
                    
                }
            }
            
            CustomButtonView(buttonLabel: "Add a participants", action: {
                showTeamListView.toggle()
            })
            .offset(y: -16)
        }
        .frame(maxHeight: .infinity)
    }
    
}

#Preview {
    ContentView()
        .environmentObject(Router.shared)
}
