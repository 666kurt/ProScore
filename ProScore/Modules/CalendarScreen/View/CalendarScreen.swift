import SwiftUI

// MARK: - CalendarScreen

struct CalendarScreen: View {
    
    @EnvironmentObject private var viewModel: CalendarViewModel
    @State private var showingAddEvent = false
    
    var body: some View {
        
        VStack {
            
            TitleView(title: "Calendar")
            
            calendarView
            
            activitiesView
            
            if viewModel.events.isEmpty {
                eventsListTitleView
            } else {
                eventsListView
            }
            
        }
        .padding(.horizontal, 20)
        .background(
            Color.theme.background.main
                .ignoresSafeArea()
        )
        .sheet(isPresented: $showingAddEvent) {
            CalendarSheetView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.fetchEvents()
        }
    }
}

// MARK: - CalendarScreen's components

extension CalendarScreen {
    
    private var calendarView: some View {
        DatePicker("Select Date",
                   selection: $viewModel.selectedDate,
                   displayedComponents: [.date])
        .datePickerStyle(GraphicalDatePickerStyle())
        .colorScheme(.dark)
        .background(Color.theme.other.calendar)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
        
    }
    
    private var activitiesView: some View {
        HStack {
            Text("Activities")
                .font(.title3).bold()
                .foregroundColor(Color.theme.text.main)
            Spacer()
            Button(action: {
                showingAddEvent.toggle()
            }, label: {
                Image(systemName: "plus")
            })
        }
        .padding(.vertical, 15)
    }
    
    private var eventsListView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.events) { event in
                    CalendarCellView(title: event.name ?? "",
                                     time: event.startTime ?? Date(),
                                     date: event.date ?? Date())
                }
            }
        }
    }
    
    private var eventsListTitleView: some View {
        Text("There are no scheduled\nholidays for this day")
            .font(.callout)
            .foregroundColor(Color(hex: "#93979F"))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .multilineTextAlignment(.center)
    }
    
}

#Preview {
    CalendarScreen()
        .environmentObject(CalendarViewModel())
}
