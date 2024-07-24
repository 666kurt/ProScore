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
                    .foregroundColor(textColor)
                    .background(buttonColor)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(!buttonIsValid)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(
            Color.theme.background.main
                .ignoresSafeArea()
        )
    }
    
    private var buttonIsValid: Bool {
        return !name.isEmpty && !game.isEmpty && !nickname.isEmpty
    }

    private var buttonColor: Color {
        return buttonIsValid ? Color.theme.other.primary : Color.theme.other.disabled
    }
    
    private var textColor: Color {
        return buttonIsValid ? Color.theme.text.main : Color.theme.background.light
    }
    
}

#Preview {
    TeamListSheetView(viewModel: TeamViewModel())
}
