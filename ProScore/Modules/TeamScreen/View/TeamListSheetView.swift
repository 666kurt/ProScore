import SwiftUI

struct TeamListSheetView: View {
    
    @ObservedObject var viewModel: TeamViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State var name: String = ""
    @State var nickname: String = ""
    @State var game: String = ""
    
    var body: some View {
        
        VStack {
            SheetTitleView(title: "Add participants")
            
            TextFieldView(title: "Enter name", tfText: $name)
            TextFieldView(title: "Enter nickname", tfText: $nickname)
            TextFieldView(title: "Enter game", tfText: $game)
            
            Button {
                viewModel.addParticipant(
                    name: name,
                    nickname: nickname,
                    game: game)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .foregroundColor(Color.theme.text.main)
                    .background(
                        (name.isEmpty
                         || nickname.isEmpty
                         || game.isEmpty)
                        ? Color.theme.background.light
                        : Color.theme.other.primary
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(
            Color.theme.background.main
                .ignoresSafeArea()
        )
    }
}

#Preview {
    TeamListSheetView(viewModel: TeamViewModel())
}