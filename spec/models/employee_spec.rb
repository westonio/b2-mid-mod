require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "Associations" do
    it { should belong_to :department }
    it { should have_many :employee_tickets }
    it { should have_many :tickets }
  end

  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :level }
  end

  describe "Instance Methods" do
    describe 'When I visit the Employee show page' do
      before :each do
        @cx = Department.create!(name: 'CX', floor: "Third" )
        @michael = @cx.employees.create!(name: 'Michael', level: 2)
  
        @ticket1 = Ticket.create!(subject: 'Update profile bug', age: 28)
        @ticket2 = Ticket.create!(subject: 'Infinitie Loop', age: 21)
        @ticket3 = Ticket.create!(subject: 'Page not loading', age: 14)
  
        @employee_ticket1 = EmployeeTicket.create!(employee_id: @michael.id, ticket_id: @ticket1.id)
        @employee_ticket2 = EmployeeTicket.create!(employee_id: @michael.id, ticket_id: @ticket2.id)
        @employee_ticket3 = EmployeeTicket.create!(employee_id: @michael.id, ticket_id: @ticket3.id)
      end

      it 'can sort tickets by age oldeest to newest' do
        expect(@michael.tickets_by_oldest).to eq([@ticket1, @ticket2, @ticket3])
      end

      it 'can return the oldest ticket' do
        expect(@michael.oldest_ticket).to eq(@ticket1)
      end
    end
  end
end