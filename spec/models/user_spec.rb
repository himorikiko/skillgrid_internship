require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }


  it { is_expected.to strip_attribute(:name).collapse_spaces }
  it { is_expected.to strip_attribute :email }
  it { is_expected.not_to strip_attribute :password_digest }
  it { is_expected.not_to strip_attribute :password }
  it { is_expected.not_to strip_attribute :password_confirmation }

  describe 'validations' do
    context 'if name not present' do
      before { user.name = " " }
      it { should_not be_valid }
    end

    context 'if email not present' do
      before { user.email = " " }
      it { should_not be_valid }
    end

    context "when email format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          user.email = invalid_address
          expect(user).not_to be_valid
        end
      end
    end

    context "when email format is valid" do
      it "should be valid" do
        addresses = ['user@foo.COM', 'A_US-ER@f.b.org', 'frst.lst@foo.jp', 'a+b@baz.cn']
        addresses.each do |valid_address|
          user.email = valid_address
          expect(user).to be_valid
        end
      end
    end

    context "when name is too long" do
      before { user.name = "a" * 51 }
      it { should_not be_valid }
    end

    context "with email is already taken" do
      let(:another_user) { create :user, name: "FirstName" }

      it { should_not be_valid }
    end
  end

  describe 'auth' do
    context "password is not present" do
      let(:user_without_password) { create :user, password: ""}

      it { should_not be_valid }
    end

    context "password doesn't match confirmation" do
      let(:user_without_password) { create :user, password: "password", password_confirmation: "pssaword"}
      it { should_not be_valid }
    end

    context "password too short" do
      before { user.password = user.password_confirmation = "a" * 5 }
      it { should be_invalid }
    end

    context "with valid password" do
      let(:found_user) { User.find_by!(email: user.email) }

      it { expect(user).to eq found_user.authenticate(user.password)}
    end

    context "with invalid password" do
      let(:user_for_invalid_password) { user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be false }
    end
  end
end
