class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  validates_presence_of :name
  validates_presence_of :level

  def tickets_by_oldest
    tickets.order(age: :desc)
  end

  def oldest_ticket
    tickets_by_oldest.first
  end

  def shared_ticket_ees
    ticket_ids = tickets.pluck(:id)
    distinct_employee_ids = EmployeeTicket.select(:employee_id).distinct.where(ticket_id: ticket_ids).pluck(:employee_id).excluding(self.id).sort
    Employee.find(distinct_employee_ids).pluck(:name).join(', ')
  end
end