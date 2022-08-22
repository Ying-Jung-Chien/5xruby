require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  scenario "User creates a new task" do
    visit "/tasks"

    click_on("Add Task")

    expect(page).to have_content("Add Task")

    # visit "/tasks/new"

    within("#new_task") do  # 填表單
      fill_in "Header", with: "test_spec"
      fill_in "Content", with: "12345678"
      fill_in "Priority", with: 0
      fill_in "Status", with: 1
      fill_in "Start", with: "2022-08-22T14:39:30Z"
      fill_in "End", with: "2022-08-23T14:39:30Z"
    end
    
    click_button "Create Task"

    expect(page).to have_text("Success!")

    task = Task.last
    expect(task.header).to eq("test_spec")
  end

  scenario "User edits a task" do

    task = Task.create!( header:"test", content:"12345678", priority:0, status:1, start:"2022-08-22T14:39:30Z", end:"2022-08-23T14:39:30Z")

    visit "/tasks"

    find("a[href='/tasks/#{task.id}/edit']").click

    expect(page).to have_content("Edit Task")


    within(".edit_task") do  # 填表單
      fill_in "Header", with: "edit"
      fill_in "Content", with: "12345678"
      fill_in "Priority", with: "0"
      fill_in "Status", with: "1"
      fill_in "Start", with: "2022-08-22T14:39:30Z"
      fill_in "End", with: "2022-08-23T14:39:30Z"
    end
    
    click_button "Update Task"

    expect(page).to have_text("Success!")

    new_task = Task.find_by(id: task.id)
    expect(new_task.header).to eq("edit")
    
  end

  scenario "User deletes a task" do

    task = Task.create!( header:"test", content:"12345678", priority:0, status:1, start:"2022-08-22T14:39:30Z", end:"2022-08-23T14:39:30Z")

    visit "/tasks"

    find("a[href='/tasks/#{task.id}']").click

    # a = page.driver.browser.switch_to.alert
    # expect(a.text).to eq("Confirm")
    # a.accept

    expect(page).to have_text("Success!")

  end

end
