require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { like }

  let!(:user) { FactoryBot.create :user }
  let!(:course) { FactoryBot.create :course }
  let!(:like) { FactoryBot.create :like, user_id: user.id, course_id: course.id }

  # Test validations
  describe "Validations" do
    before { like.save }

    it { expect(subject).to be_valid }

    [:course_id, :user_id].each do |field|
      it { is_expected.to validate_presence_of(field).with_message("can't be blank") }
      it { is_expected.to validate_numericality_of(field) }
    end
    it { is_expected.to validate_uniqueness_of(:course_id).scoped_to(:user_id) }
  end

  # Test associations
  describe "Associations" do
    [:user, :course].each do |field|
      it { is_expected.to belong_to(field) }
    end
  end
end
