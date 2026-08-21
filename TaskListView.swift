import SwiftUI

struct TaskListView: View {
    @StateObject var viewModel = TaskListViewModel()
    @StateObject var quotesManager = QuotesManager()
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var authManager: AuthManager
    @State private var showingAddTask = false
    @State private var showingSettings = false
    @State private var showingAchievements = false
    @State private var showingTimer = false
    @State private var showingPomodoro = false
    @State private var selectedTab = 0
    @State private var taskPendingReflection: UserTask? = nil
    @State private var showingClearConfirmStep1 = false
    @State private var showingClearConfirmStep2 = false

    var body: some View {
        NavigationView {
            ZStack {
                themeManager.currentTheme.backgroundColor
                    .ignoresSafeArea()

                VStack(spacing: 16) {
                    Text(quotesManager.currentQuote)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .italic()
                        .foregroundColor(themeManager.currentTheme.textColor)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .glassEffect(.regular.tint(themeManager.currentTheme.cardColor.opacity(0.7)), in: .rect(cornerRadius: 10))
                        .padding(.horizontal)
                        .padding(.top, 4)
                        .onTapGesture {
                            withAnimation {
                                quotesManager.nextQuote()
                            }
                        }

                    VStack(spacing: 12) {
                        TreeView(level: viewModel.treeLevel, progress: viewModel.treeProgress, pulse: viewModel.pulseTrigger)

                        Text("Tree Level \(viewModel.treeLevel)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(themeManager.currentTheme.textColor)

                        ProgressView(value: Double(viewModel.completedCount), total: Double(viewModel.tasksNeededForNextLevel))
                            .tint(themeManager.currentTheme.accentColor)
                            .padding(.horizontal, 40)

                        Text("\(viewModel.completedCount)/\(viewModel.tasksNeededForNextLevel) tasks to next level")
                            .font(.caption)
                            .foregroundColor(themeManager.currentTheme.secondaryTextColor)
                    }
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .glassEffect(.regular.tint(themeManager.currentTheme.cardColor), in: .rect(cornerRadius: 20))
                    .padding(.horizontal)

                    Picker("Filter", selection: $selectedTab) {
                        Text("Uncompleted").tag(0)
                        Text("Completed").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    let filteredTasks = selectedTab == 0
                        ? viewModel.tasks.filter { !$0.isCompleted }
                        : viewModel.tasks.filter { $0.isCompleted }

                    if selectedTab == 1 && !filteredTasks.isEmpty {
                        Button(action: { showingClearConfirmStep1 = true }) {
                            HStack {
                                Image(systemName: "trash")
                                Text("Clear All Completed")
                            }
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.red)
                        }
                        .padding(.horizontal)
                    }

                    if filteredTasks.isEmpty {
                        Spacer()
                        VStack(spacing: 12) {
                            Image(systemName: selectedTab == 0 ? "checklist" : "checkmark.circle")
                                .font(.system(size: 44))
                                .foregroundColor(themeManager.currentTheme.secondaryTextColor)
                            Text(selectedTab == 0 ? "No uncompleted tasks" : "No completed tasks yet")
                                .font(.headline)
                                .foregroundColor(themeManager.currentTheme.textColor)
                        }
                        Spacer()
                    } else {
                        List {
                            ForEach(filteredTasks) { task in
                                taskRow(task)
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                }

                if showingTimer {
                    VStack {
                        TimerView(isPresented: $showingTimer)
                            .environmentObject(themeManager)
                        Spacer()
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(1)
                }

                if showingPomodoro {
                    VStack {
                        PomodoroView(isPresented: $showingPomodoro)
                            .environmentObject(themeManager)
                        Spacer()
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(1)
                }
            }
            .navigationTitle("My Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 10) {
                        Button(action: { showingSettings = true }) {
                            ProfileImageView(size: 32)
                        }

                        GlassEffectContainer(spacing: 8) {
                            HStack {
                                Button(action: { showingSettings = true }) {
                                    Image(systemName: "gearshape.fill")
                                }
                                .glassEffect()

                                Button(action: { showingAchievements = true }) {
                                    Image(systemName: "trophy.fill")
                                }
                                .glassEffect()

                                Button(action: { withAnimation { showingTimer = true } }) {
                                    Image(systemName: "clock")
                                }
                                .glassEffect()

                                Button(action: { withAnimation { showingPomodoro = true } }) {
                                    Image(systemName: "clock.badge")
                                }
                                .glassEffect()
                            }
                        }
                        .foregroundColor(themeManager.currentTheme.accentColor)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                    }
                    .glassEffect(.regular.tint(themeManager.currentTheme.accentColor), in: .circle)
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView().environmentObject(themeManager).environmentObject(authManager)
            }
            .sheet(isPresented: $showingAchievements) {
                AchievementsView(viewModel: viewModel).environmentObject(themeManager)
            }
            .sheet(item: $taskPendingReflection) { task in
                ReflectionView(viewModel: viewModel, task: task)
                    .environmentObject(themeManager)
                    .presentationDetents([.large])
            }
            .onAppear {
                NotificationManager.shared.requestPermission()
            }
            .alert("Clear all completed tasks?", isPresented: $showingClearConfirmStep1) {
                Button("Cancel", role: .cancel) { }
                Button("Continue", role: .destructive) {
                    showingClearConfirmStep2 = true
                }
            } message: {
                Text("This will permanently remove all tasks in your Completed list.")
            }
            .alert("Are you sure?", isPresented: $showingClearConfirmStep2) {
                Button("Cancel", role: .cancel) { }
                Button("Delete Everything", role: .destructive) {
                    viewModel.clearCompletedTasks()
                }
            } message: {
                Text("This action cannot be undone.")
            }
        }
        .preferredColorScheme(themeManager.currentTheme.colorScheme)
    }

    @ViewBuilder
    func taskRow(_ task: UserTask) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(task.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .strikethrough(task.isCompleted)
                    .foregroundColor(task.isCompleted ? themeManager.currentTheme.secondaryTextColor : themeManager.currentTheme.textColor)

                Text(task.category == "Studies" ? "\(task.category) • \(task.subject)" : task.category)
                    .font(.caption)
                    .foregroundColor(themeManager.currentTheme.secondaryTextColor)

                if !task.notes.isEmpty {
                    Text(task.notes)
                        .font(.caption2)
                        .foregroundColor(themeManager.currentTheme.secondaryTextColor)
                }

                if let deadline = task.deadline {
                    Text("Due: \(deadline.formatted(date: .abbreviated, time: .shortened))")
                        .font(.caption2)
                        .foregroundColor(.orange)
                }
            }
            Spacer()
            if !task.isCompleted {
                Button("Done") {
                    taskPendingReflection = task
                }
                .buttonStyle(.borderedProminent)
                .tint(themeManager.currentTheme.accentColor)
                .controlSize(.small)
            } else {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(themeManager.currentTheme.accentColor)
                    .font(.title2)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .glassEffect(.regular.tint(themeManager.currentTheme.cardColor), in: .rect(cornerRadius: 14))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
    }
}
