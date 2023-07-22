require 'rails_helper'

RSpec.describe 'Employee #show page', type: :feature do
  describe 'When I visit the Employee show page' do
    before :each do
      @cx = Department.create!(name: 'CX', floor: "Third" )
      @michael = @cx.employees.create!(name: 'Michael', level: 2)
      @emily = @cx.employees.create!(name: 'Emily', level: 5)

      @ticket1 = Ticket.create!(subject: 'Update profile bug', age: 28)
      @ticket2 = Ticket.create!(subject: 'Infinitie Loop', age: 21)
      @ticket3 = Ticket.create!(subject: 'Page not loading', age: 14)
      @ticket4 = Ticket.create!(subject: 'view on mobile broken', age: 19)

      @employee_ticket1 = EmployeeTicket.create!(employee_id: @michael.id, ticket_id: @ticket1.id)
      @employee_ticket2 = EmployeeTicket.create!(employee_id: @michael.id, ticket_id: @ticket2.id)
      @employee_ticket3 = EmployeeTicket.create!(employee_id: @michael.id, ticket_id: @ticket3.id)
      @employee_ticket4 = EmployeeTicket.create!(employee_id: @emily.id, ticket_id: @ticket3.id) # shares ticket with michael
      @employee_ticket5 = EmployeeTicket.create!(employee_id: @emily.id, ticket_id: @ticket4.id)
    
      visit "/employees/#{@michael.id}"
    end

    it 'shows the employees name' do
      expect(page).to have_content(@michael.name)
      expect(page).to_not have_content(@emily.name)
    end

    it 'shows the employees department' do
      expect(page).to have_content(@michael.department.name)
    end

    it 'lists all of their tickets from oldest to newest' do
      expect(@ticket1.subject).to appear_before(@ticket2.subject)
      expect(@ticket2.subject).to appear_before(@ticket3.subject)
    end

    it 'shows the oldest ticket assigned listed separately' do
      within("#oldest_ticket") do
        expect(page).to have_content("Subject: #{@ticket1.subject}")
        expect(page).to have_content("Age of Ticket: #{@ticket1.age}")
      end
    end

    it 'does not show tickets that are not assigned to the employee' do
      expect(page).to_not have_content(@ticket4.subject) # Only Emily's ticket
    end

    it 'has a form to add an existing ticket to an employee' do
      expect(page).to have_css("#add_ticket")
      expect(page).to have_button("Submit")
    end

    it 'redirects to the show page and displays added ticket' do
      within("#add_ticket") do
        fill_in :ticket_id, with: @ticket4.id
        click_button "Submit"
      end
      
      save_and_open_page
      expect(current_path).to eq("/employees/#{@michael.id}")
      expect(page).to have_content(@ticket4.subject)
    end
  end
end