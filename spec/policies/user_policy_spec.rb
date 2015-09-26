require 'rails_helper'
require 'support/features/session_helper'
require 'support/database_cleaner'
include Features::SessionHelpers

describe UserPolicy do
  subject { UserPolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  permissions :index? do
    it 'denies access if not an admin' do
      expect(UserPolicy).not_to permit(current_user)
    end
    it 'allows access for admin' do
      expect(UserPolicy).to permit(admin)
    end
  end

  permissions :show? do
    it 'prevents other users from seeing the profile' do
      expect(subject).not_to permit(current_user, other_user)
    end

    it 'allows owner to see profile' do
      expect(subject).to permit(current_user, current_user)
    end

    it 'allows and admin to see profile' do
      expect(subject).to permit(admin)
    end
  end
end
