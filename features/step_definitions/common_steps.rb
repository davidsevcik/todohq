PATH_MAP = {
  'sign up' => '/#/users/new',
  'sign in' => '/#/sessions/new',
  'task list' => '/#/tasks/index'
}

user = nil


Given /^^(?:|I )go on "([^\"]+)" page$/ do |page_name|
  visit PATH_MAP[page_name.downcase]
end

Given /^I am registered with email "([^\"]+)" and password "([^\"]+)"$/ do |email, password|
  User.create email: email, password: password, password_confirmation: password
end

Given /^^(?:|I am )signed in$/ do
  user = FactoryGirl.build :user
  user.ensure_authentication_token!
  visit '/'
  page.execute_script """
    var session = App.Session.create({email: '#{user.email}', authenticationToken: '#{user.authentication_token}'});
    App.__container__.lookup('controller:currentSession').set('content', session);
  """
end

Given /^(?:|I )have (\d+) tasks?$/ do |count|
  FactoryGirl.create_list :task, count.to_i, user: user
end

When /^(?:|I )fill in "([^\"]+)" field with "([^\"]+)"$/ do |field_name, value|
  fill_in field_name, with: value
end

When /^(?:|I )select "([^\"]+)" value "([^\"]+)"$/ do |field_name, value|
  select value, from: field_name
end

When /^(?:|I )click on "([^\"]+)" action$/ do |action_name|
  find(:xpath, "//a[@title='#{action_name}']").click
end

When /^(?:|I )submit the form$/ do
  find("button[type='submit']").click
end

When /^(?:|I )submit the edit form$/ do
  find("#edit-task-form button[type='submit']").click
end

When /^(?:|I )check the task as done$/ do
  find(".task-list li input[type='checkbox']").click
end

Then /^I (?:am redirected|stay) on "([^\"]+)" page$/ do |page_name|
  sleep 1
  expect(page.evaluate_script("location.hash")).to eq PATH_MAP[page_name.downcase][1..-1]
end

Then /^(?:|I )see a validation error$/ do
  page.should have_css('.control-group.error')
end

Then /^(?:|I )see task "([^\"]+)" in my task list$/ do |title|
  within(".task-list li") do
    page.should have_content(title)
  end
end

Then /^(?:|I )see task "([^\"]+)" with priority "([^\"]+)" in my task list$/ do |title, priority|
  within(".task-list li") do
    page.should have_content(title)
    page.should have_content(priority)
  end
end

Then /^(?:|I )do not see any task in my task list$/ do
  page.should_not have_css('.task-list li')
end

Then /^(?:|I )see the task set as done$/ do
  page.should have_css('.task-list li span.done')
end


