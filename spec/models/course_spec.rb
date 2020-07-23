require 'rails_helper'

RSpec.describe Course, type: :model do
  subject { course }

  let!(:admin) { FactoryBot.create :user, full_name: "admin", email: "admin@gmail.com", is_admin: true }
  let!(:course_type) { FactoryBot.create :course_type }
  let!(:course) { FactoryBot.create :course, course_type_id: course_type.id, user_id: admin.id }

  # Test validations
  describe "Validations" do
    before { course.save }

    it { expect(subject).to be_valid }

    [:user_id, :course_title, :course_overview, :course_description, :course_type_id].each do |field|
      it { is_expected.to validate_presence_of(field).with_message("can't be blank") }
    end
    [:user_id, :course_type_id].each do |field|
      it { is_expected.to validate_numericality_of(field) }
    end
  end

  # Test associations
  describe "Associations" do
    [:user, :course_type].each do |field|
      it { is_expected.to belong_to(field) }
    end
    [:registers, :review_courses, :lessons, :likes].each do |field|
      it { is_expected.to have_many(field).dependent(:destroy) }
    end
    it { is_expected.to have_many(:users).through(:registers) }

    it { is_expected.to accept_nested_attributes_for(:lessons) }
  end

  # Test nested attributes
  describe "accepts nested attributes for lessons" do
    it { is_expected.to accept_nested_attributes_for(:lessons) }
  end

  # Test search
  describe "Search" do
    it do
      Course.create!(user_id: admin.id, course_title: "Doloremque ex non",
                     course_overview: "Excepturi eum dolor atque distinctio.",
                     course_description: "Nesciunt quis voluptas ex ut ",
                     course_image: nil,
                     overview_video_url: "https://player.vimeo.com/video/368134723",
                     course_type_id: course_type.id)
      Course.search_index.refresh
      assert_equal ["Doloremque ex non"], Course.search("Doloremque").map(&:course_title)
    end
  end
end
