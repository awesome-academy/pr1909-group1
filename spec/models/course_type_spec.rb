require 'rails_helper'

RSpec.describe CourseType, type: :model do
  subject { course_type }

  let!(:course_type) { FactoryBot.create :course_type }

  # Test validations
  describe "Validations" do
    before { course_type.save }

    it { expect(subject).to be_valid }

    it { is_expected.to validate_presence_of(:course_type).with_message("can't be blank") }
    it { is_expected.to validate_length_of(:course_type).is_at_most(Settings.length.course_type.maximum ) }
  end

  # Test associations
  describe "Associations" do
    it { is_expected.to have_many(:courses) }
  end
end
