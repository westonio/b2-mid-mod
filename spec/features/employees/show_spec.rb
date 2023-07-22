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

      @employee_ticket1 = EmployeeTicket.create!(employee_id: @michael.id, ticket_id: @ticket1.id)
      @employee_ticket2 = EmployeeTicket.create!(employee_id: @michael.id, ticket_id: @ticket2.id)
      @employee_ticket3 = EmployeeTicket.create!(employee_id: @michael.id, ticket_id: @ticket3.id)
    
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
  end
end