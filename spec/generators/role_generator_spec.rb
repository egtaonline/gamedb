require 'spec_helper'

describe RoleGenerator do
  describe '.build_roles' do
    let(:role_names) { %w(Role1 Role2) }

    it 'constructs the specified roles and returns their ids and names' do
      roles = RoleGenerator.build(role_names)
      expect(Role[roles[0][:role_id]][:role_name]).to eq('Role1')
      expect(Role[roles[1][:role_id]][:role_name]).to eq('Role2')
    end
  end
end
