PATH_MAP = {
  'sign up' => '/#/users/new',
  'sign in' => '/#/sessions/new',
  'task list' => '/#/tasks/index'
}

Given /^^(?:|I )go on the (.+) page$/ do |page_name|
  visit PATH_MAP[page_name.downcase]
end

Given /^I am registered with email (.+) and password (.+)$/ do |email, password|
  User.create email: email, password: password, password_confirmation: password
end

Given /^^(?:|I am )signed in$/ do
  visit '/'
  user = User.new email: 'joe@doe.com', password: 'password', password_confirmation: 'password'
  user.ensure_authentication_token!
  page.execute_script """
    var session = App.Session.create({email: '#{user.email}', authenticationToken: '#{user.authentication_token}'});
    App.__container__.lookup('controller:currentSession').set('content', session);
  """
end

When /^(?:|I )fill in (.+) field with (.+)$/ do |field_name, value|
  fill_in field_name, with: value
end

When /^(?:|I )submit the form$/ do
  find("button[type='submit']").click
end

Then /^I (?:am|stay) on the (.+) page$/ do |page_name|
  sleep 1
  expect(page.evaluate_script("location.hash")).to eq PATH_MAP[page_name.downcase][1..-1]
end

Then /^(?:|I )see a validation error$/ do
  page.should have_css('.control-group.error')
end

Then /^I see (.+) in task list$/ do |task_title|
  within(".task-list ul") do
    page.should have_content(task_title)
  end
end

