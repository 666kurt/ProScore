import SwiftUI

struct TeamHeaderSheetView: View {
    
    @ObservedObject var viewModel: TeamViewModel
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        
        VStack {
            SheetTitleView(title: "Add the info")
            
            Button(action: {
                viewModel.isImagePickerPresented = true
            }) {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.bottom, 20)
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.theme.background.second)
                        .frame(width: 160, height: 140)
                        .overlay(Image(systemName: "camera.fill").foregroundColor(.white))
                        .padding(.bottom, 20)
                }
            }
            
            TextFieldView(title: "Enter name", tfText: $viewModel.name)
            
            Button {
                viewModel.saveTeam()
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
        .sheet(isPresented: $viewModel.isImagePickerPresented) {
            ImagePicker(image: $viewModel.image)
        }
    }
    
    
    private var buttonIsValid: Bool {
        return !viewModel.name.isEmpty && !(viewModel.image == nil)
    }

    private var buttonColor: Color {
        return buttonIsValid ? Color.theme.other.primary : Color.theme.other.disabled
    }
    
    private var textColor: Color {
        return buttonIsValid ? Color.theme.text.main : Color.theme.background.light
    }
    
}

#Preview {
    TeamHeaderSheetView(viewModel: TeamViewModel())
}
