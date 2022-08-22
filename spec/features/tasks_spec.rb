require 'rails_helper'
require 'webdrivers'

RSpec.feature "Tasks", type: :feature do
  scenario "creates a new task" do
    visit "/tasks"

    click_on("Add Task")

    expect(page).to have_content("Add Task")

    # visit "/tasks/new"

    within("#new_task") do # 填表單
      fill_in "Header", with: "test_spec"
      fill_in "Content", with: "12345678"
      fill_in "Priority", with: 0
      fill_in "Status", with: 1
      fill_in "Start Time", with: "2022-08-22T14:39:30Z"
      fill_in "End Time", with: "2022-08-23T14:39:30Z"
    end

    click_button "Create Task"

    expect(page).to have_text("Success!")

    task = Task.last
    expect(task.header).to eq("test_spec")
  end

  scenario "edits a task" do
    # task = Task.create!( header:"test", content:"12345678", priority:0, status:1, start:"2022-08-22T14:39:30Z", end:"2022-08-23T14:39:30Z")
    task = FactoryBot.create(:task)
    visit "/tasks"

    find("a[href='/tasks/#{task.id}/edit']").click

    expect(page).to have_content("Edit Task")

    within(".edit_task") do # 填表單
      fill_in "Header", with: "edit"
      fill_in "Content", with: "12345678"
      fill_in "Priority", with: "0"
      fill_in "Status", with: "1"
      fill_in "Start Time", with: "2022-08-22T14:39:30Z"
      fill_in "End Time", with: "2022-08-23T14:39:30Z"
    end

    click_button "Update Task"

    expect(page).to have_text("Success!")

    new_task = Task.find_by(id: task.id)
    expect(new_task.header).to eq("edit")
  end

  scenario "deletes a task" do
    # task = Task.create!( header:"test", content:"12345678", priority:0, status:1, start:"2022-08-22T14:39:30Z", end:"2022-08-23T14:39:30Z")
    task = FactoryBot.create(:task)
    visit "/tasks"

    expect(Task.count).to eq(1)

    find("a[href='/tasks/#{task.id}']").click

    expect(Task.count).to eq(0)
    expect(page).to have_text("Success!")

    # expect {
    #   accept_confirm do
    #   click_link '確認'
    # end
    # sleep 1 #needed because click_link doesn't wait for side effects to occur, although it should really be an expectation to see something that changes on the page after the article is deleted
    # }.to change(Task, :count).by(-1)

    # accept_alert 'Confirm' do
    #   find("a[href='/tasks/#{task.id}']").click
    # end
  end
end
