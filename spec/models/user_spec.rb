require 'rails_helper'

RSpec.describe User, type: :model do
  subject { user }

  let!(:user) { FactoryBot.create :user }
  let(:u1) { FactoryBot.create :user, full_name: "derre", email: "derre@gmail.com", created_at: "2020-07-20 17:00:00" }
  let(:u2) { FactoryBot.create :user, full_name: "fred", email: "fred@gmail.com", created_at: "2020-07-15 17:00:00" }
  let(:u3) { FactoryBot.create :user, full_name: "sam", email: "sam@gmail.com", created_at: "2020-07-10 17:00:00" }

  #  Test validations
  describe "Validation" do
    before { user.save }

    it { expect(subject).to be_valid }

    it { is_expected.to validate_presence_of(:full_name).with_message("can't be blank") }
    it { is_expected.to validate_length_of(:full_name).is_at_most(Settings.user.max_length_full_name) }
    it "is not valid for full_name with special characters" do
      user.full_name = "ngoctoan£"
      expect(user).not_to be_valid
    end

    it { is_expected.to validate_presence_of(:email).with_message("can't be blank") }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive.with_message("has already been taken") }
    it { is_expected.to allow_value("ngoctoan@gmail.com").for(:email) }
    it { is_expected.not_to allow_value("ngoctoan£@gmail.com").for(:email) }

    # it { is_expected.to validate_inclusion_of(:is_admin).in_array([true, false]) }
    it { is_expected.not_to allow_value(nil).for(:is_admin) }
    it { expect(subject.is_admin?).to be false }
  end

  # Test associations
  describe "Associations" do
    # do not use gem shoulda-matchers
    it "has many courses" do
      assc = User.reflect_on_association :courses
      expect(assc.macro).to eq :has_many
    end

    # use gem shoulda-matchers
    it { is_expected.to have_many(:courses).through(:registers) }
    [:registers, :review_courses, :quiz_result, :comment_lesson, :likes].each do |field|
      it { is_expected.to have_many(field).dependent(:destroy) }
    end
  end

  # Test scope
  describe "scope" do
    it "Search for non-admin users" do
      expect(User.not_admin.to_sql).to eq User.all.where(is_admin: false).to_sql
    end

    it "user created from 14th to 21st" do
      expect(User.created("2020-07-14", "2020-07-21")).to eq [u1, u2]
    end
    it "user created from 8th to 21st" do
      expect(User.created("2020-07-08", "2020-07-21")).to eq [u1, u2, u3]
    end
  end
end
