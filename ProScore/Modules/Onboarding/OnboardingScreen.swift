import SwiftUI

struct OnboardingScreen: View {
    
    @Binding var showOnboarding: Bool
    @State private var currentTab = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            TabView(selection: $currentTab) {
                OnboardingStepView(image: "onboarding1", title: "Your team", description: "Enter the stats for your team").tag(0)
                OnboardingStepView(image: "onboarding2", title: "Game statistics", description: "All important points for tracking statistics").tag(1)
                OnboardingStepView(image: "onboarding3", title: "Modify and nurture", description: "Quick data change right in your pocket").tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
            
            
            HStack(alignment: .center) {
                CustomTabIndicator(currentTab: $currentTab, numberOfTabs: 3)
                Spacer()
                Button(action: {
                    if currentTab < 2 {
                        currentTab += 1
                    } else {
                        showOnboarding = false
                        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                    }
                }, label: {
                    Text("Next")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 55)
                        .foregroundColor(Color.theme.text.main)
                        .background(Color.theme.other.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                })
            }
            .padding(.bottom, 55)
            .padding(.horizontal, 15)
        }
    }
}


#Preview {
    OnboardingScreen(showOnboarding: .constant(true))
}
