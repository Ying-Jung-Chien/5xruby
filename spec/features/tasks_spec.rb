require 'rails_helper'
require 'webdrivers'

RSpec.feature "Tasks", type: :feature do
  before(:each) do
    visit "/login"
    @test_user = create(:user, name:"task_spec", password:"1234abcD")
    within(".login") do # 填表單
      fill_in I18n.t("name"), with: "task_spec"
      fill_in I18n.t("password"), with: "1234abcD"
    end
    click_button I18n.t("login")
    expect(page).to have_text("Logged in successfully")
  end
  
  scenario "creates a new task" do
    visit "/tasks"
    find("a[href='/tasks/new']").click
    expect(page).to have_selector(:id, 'modal')

    within("#new_task") do # 填表單
      fill_in I18n.t("header"), with: "test_spec"
      fill_in I18n.t("content"), with: "12345678"
      choose('task[priority]',option:0)
      choose('task[status]',option:0)
      fill_in I18n.t("start_time"), with: "2022-08-22T14:39:30Z"
      fill_in I18n.t("end_time"), with: "2022-08-23T14:39:30Z"
      fill_in 'input_tag', with: "apple"
      click_button I18n.t("add_tag")
    end
    click_button I18n.t("submit")
    expect(page).to have_text("Task was successfully created.")

    task = Task.last
    expect(task.header).to eq("test_spec")
  end

  scenario "edits a task" do
    task = build(:task)
    @test_user.tasks << task

    visit "/tasks"
    find("a[href='/tasks/#{task.id}/edit']").click
    expect(page).to have_content(I18n.t("edit_task"))

    within(".edit_task") do # 填表單
      fill_in I18n.t("header"), with: "edit"
      fill_in I18n.t("content"), with: "12345678"
      choose('task[priority]',option:0)
      choose('task[status]',option:0)
      fill_in I18n.t("start_time"), with: "2022-08-22T14:39:30Z"
      fill_in I18n.t("end_time"), with: "2022-08-23T14:39:30Z"
      fill_in 'input_tag', with: "apple"
      click_button I18n.t("add_tag")
    end
    click_button I18n.t("submit")
    expect(page).to have_text("Task was successfully edited.")

    new_task = Task.find(task.id)
    expect(new_task.header).to eq("edit")
  end

  scenario "deletes a task" do
    task = build(:task)
    @test_user.tasks << task

    visit "/tasks"
    expect(Task.count).to eq(1)

    find("a[href='/tasks/#{task.id}']").click
    expect(Task.count).to eq(0)
    expect(page).to have_text("Success!")
  end

  scenario "order by end time" do
    tasks = build_list(:task, 3)
    @test_user.tasks << tasks

    visit "/tasks"
    find("#label_sort_end_time").click
    visit "/tasks?sort=end_time&dir=desc"
    tasks = Task.order("end_time desc")
    within '#task_1' do
      expect(page).to have_text tasks[1].header
    end
    
    within '#task_2' do
      expect(page).to have_text tasks[2].header
    end

    find("#label_sort_end_time").click
    visit "/tasks?sort=end_time&dir=asc"
    within '#task_1' do
      expect(page).to have_text tasks[1].header
    end

    within '#task_2' do
      expect(page).to have_text tasks[0].header
    end
  end

  scenario "order by priority" do
    @test_user.tasks << build_list(:task, 3)

    visit "/tasks"
    
    find("#label_sort_priority").click
    visit "/tasks?sort=priority&dir=desc"

    tasks = Task.order("priority desc")
    within '#task_1' do
      expect(page).to have_text tasks[1].header
    end
    
    within '#task_2' do
      expect(page).to have_text tasks[2].header
    end

    find("#label_sort_priority").click
    visit "/tasks?sort=priority&dir=asc"
    tasks = Task.order("priority asc")
    within '#task_1' do
      expect(page).to have_text tasks[1].header
    end
    
    within '#task_2' do
      expect(page).to have_text tasks[2].header
    end
  end

  scenario "search by header" do
    @test_user.tasks << build_list(:task, 28)
    tasks = build_list(:task, 2, header:'abcdef')
    @test_user.tasks << tasks
    
    visit "/tasks" 
    fill_in :search, with: 'cde'
    click_button I18n.t('search')
    within '#task_1' do
      expect(page).to have_text tasks[1].header
    end
  end

  scenario "search by status" do
    @test_user.tasks << build_list(:task, 100)
    
    visit "/tasks"
    test_tasks = Task.where("status = 2").order("id asc")
    find('label', :text => I18n.t('pending')).click
    visit "/tasks?option=2"
    within '#task_1' do
      expect(page).to have_text test_tasks[1].header
    end
  end

  scenario "search by tag" do
    @test_user.tasks << build_list(:task, 9)
    task = build(:task, tag_list:'apple')
    @test_user.tasks << task
    
    visit "/tasks" 
    select I18n.t("tag"), :from => "search_by"
    fill_in :search, with: 'apple'
    click_button I18n.t('search')
    within '#task_0' do
      expect(page).to have_text task.header
    end
  end
  
end