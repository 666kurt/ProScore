import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        
        
        VStack {
            TitleView(title: "Settings")
            
            VStack(spacing: 0) {
                SettingsCellView(image: "bubble.fill", title: "Contact us")
                SettingsCellView(image: "shield.fill", title: "Privacy")
                SettingsCellView(image: "menucard.fill", title: "Terms of use")
                SettingsCellView(image: "wallet.pass.fill", title: "License")
            }
            
            Spacer()
            
            CustomButtonView(buttonLabel: "Reset data") {
                //
            }
            .offset(y: -16)
        }
        .padding(.horizontal, 20)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(
            Color.theme.background.main
                .ignoresSafeArea()
        )
    }
    
}

#Preview {
    SettingsScreen()
}
