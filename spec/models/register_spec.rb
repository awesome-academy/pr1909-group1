require 'rails_helper'

RSpec.describe Register, type: :model do
  subject { register }

  let!(:user) { FactoryBot.create :user }
  let!(:course) { FactoryBot.create :course }
  let!(:register) { FactoryBot.build :register, user_id: user.id, course_id: course.id }

  # Test validations
  describe "Validations" do
    it { expect(subject).to be_valid }

    [:course_id, :user_id].each do |field|
      it { is_expected.to validate_presence_of(field).with_message("can't be blank") }
      it { is_expected.to validate_numericality_of(field) }
    end
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:course_id) }
  end

  # Test associations
  describe "Associations" do
    [:user, :course].each do |field|
      it { is_expected.to belong_to(field) }
    end
  end

  # Test callback
  describe "triggers increase counter register on save" do
    it do
      expect(register).to receive(:increase_counter_register)
      register.save
    end
  end
end
