require 'rails_helper'
require 'webdrivers'

RSpec.feature "Tasks", type: :feature do
  scenario "creates a new task" do
    visit "/tasks"

    find("a[href='/tasks/new']").click

    expect(page).to have_css('.add_task')

    within("#new_task") do # 填表單
      fill_in I18n.t("header"), with: "test_spec"
      fill_in I18n.t("content"), with: "12345678"
      fill_in I18n.t("priority"), with: 0
      fill_in I18n.t("status"), with: 1
      fill_in I18n.t("start_time"), with: "2022-08-22T14:39:30Z"
      fill_in I18n.t("end_time"), with: "2022-08-23T14:39:30Z"
    end

    click_button I18n.t("submit")

    expect(page).to have_text("Success!")

    task = Task.last
    expect(task.header).to eq("test_spec")
  end

  scenario "edits a task" do
    task = create(:task)
    visit "/tasks"

    find("a[href='/tasks/#{task.id}/edit']").click

    expect(page).to have_content(I18n.t("edit_task"))

    within(".edit_task") do # 填表單
      fill_in I18n.t("header"), with: "edit"
      fill_in I18n.t("content"), with: "12345678"
      fill_in I18n.t("priority"), with: 0
      fill_in I18n.t("status"), with: 1
      fill_in I18n.t("start_time"), with: "2022-08-22T14:39:30Z"
      fill_in I18n.t("end_time"), with: "2022-08-23T14:39:30Z"
    end

    click_button I18n.t("submit")

    expect(page).to have_text("Success!")

    new_task = Task.find(task.id)
    expect(new_task.header).to eq("edit")
  end

  scenario "deletes a task" do
    task = create(:task)
    visit "/tasks"

    expect(Task.count).to eq(1)

    find("a[href='/tasks/#{task.id}']").click

    expect(Task.count).to eq(0)
    expect(page).to have_text("Success!")

    # accept_alert 'Confirm' do
    #   find("a[href='/tasks/#{task.id}']").click
    # end
  end

  scenario "order by created time" do
    Task.create!( header:"test1")
    sleep 2
    Task.create!( header:"test2")
    sleep 2
    Task.create!( header:"test3")

    visit "/tasks"

    within 'tr:nth-child(2)' do
      expect(page).to have_text 'test2'
    end
    within 'tr:nth-child(3)' do
      expect(page).to have_text 'test1'
    end

  end
end
