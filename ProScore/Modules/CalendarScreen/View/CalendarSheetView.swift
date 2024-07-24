import SwiftUI

struct CalendarSheetView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CalendarViewModel
    
    @State private var eventName: String = ""
    @State private var startTime: Date = Date()
    
    var body: some View {
            
            VStack {
                SheetTitleView(title: "Add activities")
                
                TextFieldView(title: "Enter name", tfText: $eventName)
                
                DatePicker("Date", selection: $viewModel.selectedDate, displayedComponents: .date)
                    .preferredColorScheme(.dark)
                
                DatePicker("Beginning", selection: $startTime, displayedComponents: .hourAndMinute)
                    .preferredColorScheme(.dark)

                
                Button {
                    viewModel.addEvent(name: eventName,
                                       date: viewModel.selectedDate,
                                       startTime: startTime)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Add")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .foregroundColor(Color.theme.text.main)
                        .background(eventName.isEmpty
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
    CalendarSheetView(viewModel: CalendarViewModel())
}
